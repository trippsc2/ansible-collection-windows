#!powershell

#AnsibleRequires -CSharpUtil Ansible.Basic
#AnsibleRequires -PowerShell ansible_collections.trippsc2.windows.plugins.module_utils.SharedFunctions
#AnsibleRequires -PowerShell ansible_collections.trippsc2.windows.plugins.module_utils.WDS

$spec = @{
    options = @{
        remote_install_path = @{
            type = 'path'
            required = $false
        }
        standalone = @{
            type = 'bool'
            required = $false
            default = $false
        }
        authorized = @{
            type = 'bool'
            required = $false
            default = $false
        }
        state = @{
            type = 'str'
            required = $false
            default = 'initialized'
            choices = @(
                'initialized',
                'uninitialized'
            )
        }
    }
    required_if = @(
        , @('state', 'initialized', @('remote_install_path'))
    )
    supports_check_mode = $true
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

Import-WDSModule | Out-Null

$remoteInstallPath = $module.Params.remote_install_path
$standalone = $module.Params.standalone
$authorized = $module.Params.authorized
$state = $module.Params.state

$wdsutilPath = "C:\Windows\System32\wdsutil.exe"

$currentConfig = Start-ProcessWithOutput -Path $wdsutilPath -ArgumentList @("/Get-Server", "/Show:Config") -ErrorAction SilentlyContinue

$isConfigured = $currentConfig.Output -notmatch 'WDS operational mode: Not Configured'

$currentConfig.Output -match 'RemoteInstall location:\s*(?<Path>[\w:\\]+)' | Out-Null

$existingRemoteInstallPath = $matches.Path
$isStandalone = $currentConfig.Output -match 'Standalone configuration:\s*yes'

$module.Result["changed"] = $false

if ($state -eq 'initialized')
{
    if (-not $isConfigured)
    {
        $module.Result["changed"] = $true
    }

    if ($standalone -and -not $isStandalone)
    {
        $module.Result["changed"] = $true
    }

    if (-not $standalone -and $isStandalone)
    {
        $module.Result["changed"] = $true
    }

    if ($remoteInstallPath -ne $existingRemoteInstallPath)
    {
        $module.Result["changed"] = $true
    }

    if ($module.Result["changed"] -and -not $module.CheckMode)
    {
        $argumentsList = New-Object System.Collections.ArrayList

        $argumentsList.Add("/Initialize-Server") | Out-Null
        $argumentsList.Add("/RemInst:$($remoteInstallPath)") | Out-Null
        
        if ($standalone)
        {
            $argumentsList.Add("/Standalone") | Out-Null
        }

        if ($authorized)
        {
            $argumentsList.Add("/Authorize") | Out-Null
        }

        Start-ProcessWithOutput -Path $wdsutilPath -ArgumentList $argumentsList.ToArray() -ErrorAction SilentlyContinue | Out-Null
    }
}
elseif ($state -eq 'uninitialized')
{
    if ($isConfigured)
    {
        $module.Result["changed"] = $true

        if (-not $module.CheckMode)
        {
            Start-ProcessWithOutput -Path $wdsutilPath -ArgumentList @("/Uninitialize-Server") -ErrorAction SilentlyContinue | Out-Null
        }
    }
}

$module.ExitJson()
