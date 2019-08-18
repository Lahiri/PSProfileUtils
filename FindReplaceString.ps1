function grep {
    <#
    .SYNOPSIS
    Returns all occurrencies of an input string in all the files in the current folder and subfolders.
    It is also possible to replace the string with a new value.

    .DESCRIPTION
    This function cycles through all the files within the current directory and subfolders to find the string specified with the -String parameter.
    It is possible to replace that string in all its occurrencies using the -NewString parameter.

    .PARAMETER String
    The string to search for.

    .PARAMETER NewString
    The replacement string.

    .PARAMETER CaseSensitive
    Take case into account while searching for the string.

    .EXAMPLE
    grep "Hello World"

    Search for all occurrencies of the string "Hello World"

    .EXAMPLE
    grep "Hello World" "Spam eggs"

    Replaces all occurencies of "Hello World" with "Spam eggs"

    .EXAMPLE
    grep "Hello World" -CaseSensitive

    Search for all occurrencies of the string "Hello World", taking case into account.

    .NOTES
    Searching for some special characters may break the function.
    #>

    [CmdletBinding(
        SupportsShouldProcess = $true
    )]
    param(
        [Parameter (
            Mandatory = $true
        )]
        [string]$String,

        [Parameter (
            Mandatory = $false
        )]
        [string]$NewString,

        [switch]$CaseSensitive = $false
    )

    $Result = Get-ChildItem -Recurse -File | Select-String $String -AllMatches -CaseSensitive:$CaseSensitive

    if ($NewString.Length -gt 0) {
        $Files = $Result.Path | Select-Object -Unique
        foreach ($File in $Files) {
            $Content = Get-Content $File
            if ($PSCmdlet.ShouldProcess("File: $File", "Replace $String with $NewString")) {
                if ($CaseSensitive) {
                    $Content | ForEach-Object {$_.Replace($String, $NewString)} | Set-Content $File
                }
                else {
                    $Content | ForEach-Object {$_ -ireplace [regex]::Escape($String), $NewString} | Set-Content $File
                }
            }
            Write-Host "Replaced $String with $NewString in file: $File"
        }
    }
    else {
        return $Result
    }
}
