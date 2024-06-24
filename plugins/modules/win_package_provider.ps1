#!powershell

#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options = @{
        name = @{
            type = 'str'
            required = $true
        }
        min_version = @{
            type = 'str'
            required = $false
        }
    }
    supports_check_mode = $true
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$changed = $false

$name = $module.Params['name']

if ($module.Params.ContainsKey('min_version')) {
    try {
        $minVersion = [System.Version]::Parse($module.Params['min_version'])
    }
    catch {
        $module.FailJson("Invalid version format for 'min_version'.")
    }
}
else {
    $minVersion = $null
}

$currentVersion = $null
$providers = ([Array](Get-PackageProvider | Where-Object { $_.Name -eq $name }))

if ($providers.Count -gt 0) {
    $currentVersion = $providers[0].Version
}

if ($null -eq $currentVersion)
{
    $changed = $true
}

if ($null -ne $minVersion -and $currentVersion -lt $minVersion)
{
    $changed = $true
}

if ($changed) {
    if ($null -eq $currentVersion) {
        $module.Result["previous_version"] = "Not Installed"
    }
    else {
        $module.Result["previous_version"] = $currentVersion.ToString()
    }

    if (-not $module.CheckMode) {
        $providers = ([Array](Install-PackageProvider -Name $name -Force -ForceBootstrap))

        $installedVersion = $providers[0].Version
  
        if ($null -ne $minVersion -and $installedVersion -lt $minVersion)
        {
            $module.FailJson("Failed to install package provider '$name' version '$minVersion'.")
        }
  
        $module.Result["installed_version"] = $installedVersion.ToString()
    }
}
else {
    $module.Result["installed_version"] = $currentVersion.ToString()
}

$module.Result["changed"] = $changed
$module.ExitJson()
