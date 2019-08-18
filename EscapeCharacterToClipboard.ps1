function escape {
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
