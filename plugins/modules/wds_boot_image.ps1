#!powershell

#AnsibleRequires -CSharpUtil Ansible.Basic
#AnsibleRequires -PowerShell ansible_collections.trippsc2.windows.plugins.module_utils.WDS

$spec = @{
    options = @{
        image_name = @{
            type = 'str'
            required = $true
        }
        path = @{
            type = 'path'
            required = $false
        }
        architecture = @{
            type = 'str'
            required = $false
            choices = @(
                'x86',
                'ia64',
                'x64',
                'arm'
            )
        }
        description = @{
            type = 'str'
            required = $false
        }
        display_order = @{
            type = 'int'
            required = $false
        }
        state = @{
            type = 'str'
            required = $false
            default = 'present'
            choices = @(
                'present',
                'absent'
            )
        }
    }
    required_if = @(
        , @('state', 'present', @('path'))
    )
    supports_check_mode = $false
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

Import-WDSModule | Out-Null

$imageName = $module.Params['image_name']
$path = $module.Params['path']
$architecture = $module.Params['architecture']
$description = $module.Params['description']
$displayOrder = $module.Params['display_order']
$state = $module.Params['state']

$module.Result["changed"] = $false

$registryPath = Get-ItemProperty -LiteralPath "HKLM:\SYSTEM\CurrentControlSet\Services\WDSServer\Providers\WDSTFTP" -ErrorAction Stop

if ($null -eq $registryPath) {
    $module.FailJson("WDS is not installed.")
}

if ($state -eq 'present') {

    if (-not (Test-Path -LiteralPath $path)) {
        $module.FailJson("Path '$path' does not exist.")
    }

    $existingBootImage = Get-WdsBootImage -ImageName $imageName -ErrorAction SilentlyContinue

    if ($null -eq $existingBootImage) {

        $module.Result["changed"] = $true

        if ($null -eq $description) {
            $description = ''
        }

        if ($null -eq $displayOrder) {
            $displayOrder = 50000
        }

        if ($null -eq $architecture) {

            $bootImage = Import-WdsBootImage -NewImageName $imageName -Path $path -NewDescription $description -DisplayOrder $displayOrder

            $architecture = $bootImage.Architecture.ToString().ToLower()

            $module.Result["current"] = @{
                image_name = $imageName
                architecture = $architecture
                description = $description
                display_order = $displayOrder
            }
        }
        else {

            $module.Result["current"] = @{
                image_name = $imageName
                architecture = $architecture
                description = $description
                display_order = $displayOrder
            }

            $bootImage = Import-WdsBootImage -NewImageName $imageName -Path $path -NewDescription $description -DisplayOrder $displayOrder

            if ($architecture -ne $bootImage.Architecture.ToString().ToLower()) {
                $module.FailJson("Cannot change architecture of existing boot image.")
            }
        }
    }
    else {
        if ($null -eq $architecture) {
            $architecture = $existingBootImage.Architecture.ToString().ToLower()
        }
        elseif ($architecture -ne $existingBootImage.Architecture.ToString().ToLower()) {
            $module.FailJson("Cannot change architecture of existing boot image.")
        }

        $propertyChanged = $false

        if ($null -eq $description) {
            $description = $existingBootImage.Description
        }
        elseif ($description -ne $existingBootImage.Description) {
            $propertyChanged = $true
        }

        if ($null -eq $displayOrder) {
            $displayOrder = $existingBootImage.DisplayOrder
        }
        elseif ($displayOrder -ne $existingBootImage.DisplayOrder) {
            $propertyChanged = $true
        }

        $module.Result["changed"] = $true

        $module.Result["previous"] = @{
            image_name = $imageName
            architecture = $existingBootImage.Architecture.ToString().ToLower()
            description = $existingBootImage.Description
            display_order = $existingBootImage.DisplayOrder
        }

        $module.Result["current"] = @{
            image_name = $imageName
            architecture = $architecture
            description = $description
            display_order = $displayOrder
        }

        if ($propertyChanged) {
            Set-WdsBootImage -ImageName $imageName -Architecture $architecture -NewDescription $description -DisplayOrder $displayOrder | Out-Null
        }

        Start-Process -FilePath "C:\Windows\System32\wdsutil.exe" `
            -ArgumentList "/Replace-Image /Image:""$($imageName)"" /ImageType:Boot /Architecture:$($architecture) /ReplacementImage /ImageFile:""$($path)""" `
            -Wait |
            Out-Null
    }
}
elseif ($state -eq "absent") {

    $existingBootImage = Get-WdsBootImage -ImageName $imageName -ErrorAction SilentlyContinue

    if ($null -ne $existingBootImage) {

        $module.Result["changed"] = $true

        $module.Result["previous"] = @{
            image_name = $imageName
            architecture = $existingBootImage.Architecture.ToString().ToLower()
            description = $existingBootImage.Description
            display_order = $existingBootImage.DisplayOrder
        }

        Remove-WdsBootImage -ImageName $imageName -Architecture $existingBootImage.Architecture | Out-Null
    }
}

$module.ExitJson()
