function Start-ProcessWithOutput {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$Path,
        [Parameter(Mandatory = $false)]
        [String[]]$ArgumentList = $null,
        [Parameter(Mandatory = $false)]
        [int[]]$ExpectedExitCodes = @(0, 3010)
    )

    $process = New-Object -TypeName System.Diagnostics.Process
    $processStartInfo = New-Object -TypeName System.Diagnostics.ProcessStartInfo
    $processStartInfo.FileName = $Path

    if ($null -ne $ArgumentList)
    {
        $processStartInfo.Arguments = $ArgumentList
    }

    $processStartInfo.RedirectStandardOutput = $true
    $processStartInfo.RedirectStandardError = $true
    $processStartInfo.UseShellExecute = $false
    $process.StartInfo = $processStartInfo

    $process.Start() | Out-Null
    $standardOutput = $process.StandardOutput.ReadToEnd()
    $standardError = $process.StandardError.ReadToEnd()
    $process.WaitForExit() | Out-Null

    if ($process.ExitCode -notin $ExpectedExitCodes)
    {
        throw "$($process) exited with $($process.ExitCode), output: $($standardOutput), error: $($standardError)"
    }

    return [PSCustomObject]@{
        Output = $standardOutput
        Error = $standardError
        ExitCode = $process.ExitCode
    }
}

$exportMembers = @{
    Function = 'Start-ProcessWithOutput'
}

Export-ModuleMember @exportMembers
