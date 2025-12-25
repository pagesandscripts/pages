param(
    [string]$Source = "index.html",
    [string]$Target = "local-preview.html"
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Resolve-Path (Join-Path $scriptDir "..")
$docsRoot = Join-Path $repoRoot "docs"

$sourcePath = Join-Path $docsRoot $Source
$targetPath = Join-Path $docsRoot $Target

if (-not (Test-Path $sourcePath)) {
    Write-Error "Source file '$Source' was not found at '$sourcePath'."
    exit 1
}

Copy-Item -Path $sourcePath -Destination $targetPath -Force
Write-Output "Generated '$Target' from '$Source'."
