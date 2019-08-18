function escape {
    <#
    .SYNOPSIS
    Copies the Powershell language escape character ` to the clipboard.
    
    .DESCRIPTION
    Copies the Powershell language escape character ` to the clipboard.
    This is very useful when using a keyboard that does not have a physical key for the ` character.
    
    .EXAMPLE
    escape

    > Escape character ` copied to clipboard
    
    #>
    
    [CmdletBinding()]
    [alias("esc")]
    param (
    )

    begin {
    }

    process {
        Set-Clipboard -Value '`'
        Write-Host 'Escape character ` copied to clipboard' -ForegroundColor Green
    }

    end {
    }
}
