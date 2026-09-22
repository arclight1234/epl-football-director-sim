param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$GitArguments
)

$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$gitDirectory = Join-Path $projectRoot 'work\git-meta'
$sshWrapper = Join-Path $projectRoot 'work\git-ssh-wrapper.exe'
$gitExecutable = Get-Command git.exe -ErrorAction SilentlyContinue

if (-not $gitExecutable) {
    $bundledGit = 'C:\Users\PSM\.cache\codex-runtimes\codex-primary-runtime\dependencies\native\git\cmd\git.exe'
    if (Test-Path -LiteralPath $bundledGit) {
        $gitExecutable = [pscustomobject]@{ Source = $bundledGit }
    } else {
        throw 'git.exe를 찾을 수 없습니다.'
    }
}

if (Test-Path -LiteralPath $sshWrapper) {
    $env:GIT_SSH = $sshWrapper
    $env:GIT_SSH_VARIANT = 'ssh'
}

& $gitExecutable.Source --git-dir=$gitDirectory --work-tree=$projectRoot @GitArguments
exit $LASTEXITCODE
