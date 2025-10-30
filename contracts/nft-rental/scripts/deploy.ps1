# Configuration
$sourceAccount = Read-Host "Enter your Stellar source account address"
$network = "testnet"
$projectRoot = $PSScriptRoot | Split-Path -Parent

# Set working directory
Set-Location $projectRoot

# Build contract
Write-Host "🔨 Building contract..." -ForegroundColor Yellow
Set-Location "contracts\nft-rental"

# Build
cargo build --target wasm32-unknown-unknown --release

# Return to project root
Set-Location $projectRoot

# Set WASM path
$wasmPath = "contracts\nft-rental\target\wasm32-unknown-unknown\release\nft_rental_platform.wasm"

# Verify WASM exists
if (-not (Test-Path $wasmPath)) {
    Write-Host "❌ WASM file not found at: $wasmPath" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Contract built successfully" -ForegroundColor Green

# Deploy contract with source account
Write-Host "🚀 Deploying contract..." -ForegroundColor Yellow
try {
    $result = stellar contract deploy `
        --wasm $wasmPath `
        --network $network `
        --source-account $sourceAccount

    Write-Host "✅ Contract deployed successfully!" -ForegroundColor Green
    Write-Host "Contract ID: $result" -ForegroundColor Cyan
}
catch {
    Write-Host "❌ Deployment failed: $_" -ForegroundColor Red
    exit 1
}