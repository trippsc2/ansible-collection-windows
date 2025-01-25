function Import-WDSModule {
    [CmdletBinding()]
    param ()

    if (-not (Get-Module -Name WDS))
    {
        try
        {
            Import-Module -Name WDS | Out-Null
        }
        catch
        {
            $module.FailJson("Failed to import WDS module. Ensure the Windows Deployment Services management tools are installed.")
        }
    }
}

$exportMembers = @{
    Function = 'Import-WDSModule'
}

Export-ModuleMember @exportMembers
