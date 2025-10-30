# Robust deployment script for nftrentalplatform
# Usage: run from project root: .\scripts\deploy.ps1

# Resolve paths
$scriptDir = $PSScriptRoot
$projectRoot = (Resolve-Path (Join-Path $scriptDir "..")).Path
$contractDir = Join-Path $projectRoot "contracts\nft-rental"

if (-not (Test-Path $contractDir)) {
    Write-Host "ERROR: Contract directory not found: $contractDir" -ForegroundColor Red
    exit 1
}

# Prompt inputs
$sourceAccount = Read-Host "Enter your Stellar source account address (required)"
if ([string]::IsNullOrWhiteSpace($sourceAccount)) {
    Write-Host "ERROR: Source account is required." -ForegroundColor Red
    exit 1
}

$network = Read-Host -Prompt "Target network (press Enter for testnet)"
if ([string]::IsNullOrWhiteSpace($network)) { $network = "testnet" }

# Build contract
Write-Host "Building contract in $contractDir" -ForegroundColor Yellow
Set-Location $contractDir

if (Get-Command stellar -ErrorAction SilentlyContinue) {
    Write-Host "Using 'stellar contract build' (stellar CLI detected)" -ForegroundColor Gray
    stellar contract build
} else {
    Write-Host "stellar CLI not found - using cargo build" -ForegroundColor Gray
    rustup target add wasm32-unknown-unknown 2>$null
    cargo build --target wasm32-unknown-unknown --release
}

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Build failed. Check build output above." -ForegroundColor Red
    exit 1
}

# Locate wasm artifact (search release folders)
$wasmFile = Get-ChildItem -Path $contractDir -Filter *.wasm -Recurse |
    Where-Object { $_.FullName -match "release" } |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1

if (-not $wasmFile) {
    Write-Host "ERROR: No .wasm artifact found under $contractDir (looking in release folders)." -ForegroundColor Red
    exit 1
}

Write-Host "SUCCESS: Found wasm: $($wasmFile.FullName)" -ForegroundColor Green

# Deploy contract
Write-Host "Deploying contract to $network using source account $sourceAccount" -ForegroundColor Yellow
Set-Location $projectRoot

$deployCmd = @("contract", "deploy", "--wasm", $wasmFile.FullName, "--network", $network, "--source-account", $sourceAccount)
$deployOutput = & stellar @deployCmd 2>&1
$exit = $LASTEXITCODE

$outPath = Join-Path $projectRoot "CONTRACT_DEPLOY_OUTPUT.txt"
$deployOutput | Out-File -FilePath $outPath -Encoding UTF8

if ($exit -ne 0) {
    Write-Host "ERROR: Deployment failed. See $outPath for details." -ForegroundColor Red
    Write-Host $deployOutput -ForegroundColor DarkRed
    exit $exit
}

Write-Host "SUCCESS: Deployment finished. Full CLI output saved to: $outPath" -ForegroundColor Green
Write-Host ""
Write-Host "CLI Output:" -ForegroundColor Cyan
Write-Host $deployOutput -ForegroundColor White

# Try to extract a possible contract id from CLI output
$text = ($deployOutput -join "`n")
$maybeId = [regex]::Match($text, "[A-Za-z0-9_\-]{10,}").Value
if ($maybeId) {
    $idPath = Join-Path $projectRoot "CONTRACT_ID.txt"
    $maybeId | Out-File -FilePath $idPath -Encoding UTF8
    Write-Host "Saved possible Contract ID to: $idPath" -ForegroundColor Green
}

Write-Host "Done." -ForegroundColor Cyan