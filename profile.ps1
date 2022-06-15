Set-PoshPrompt -Theme D:\devstuff\themepowershell.json

Enable-PoshTooltips
Import-Module posh-git

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

# npm autocompletion
Import-Module npm-completion

Import-Module -Name Terminal-Icons

function gclean {
    param(
        [switch]$dry
    )

    git fetch --all --prune;

    if ($dry) {
        Write-Output "Running dry run of gclean" 
        git branch --v | Where-Object { $_ -match "\[gone\]" } | ForEach-Object { -split $_ | Select-Object -First 1 }
    }
    else {
        git branch --v | Where-Object { $_ -match "\[gone\]" } | ForEach-Object { -split $_ | Select-Object -First 1 } | ForEach-Object { git branch -D $_ }
    }
}

function nvameno {
    git add .; 
    git commit --amend --no-edit --no-verify;
    git push -f --no-verify
}

function explorerdot {
    explorer .
}

Set-Alias -Name e. -Value explorerdot

function goaoc {
    set-location "c:\dev\github\aoc";
}

function gopds {
    set-location "c:\dev\PDS";
}

$env:PYTHONIOENCODING = "utf-8"

Invoke-Expression "$(thefuck --alias)"
