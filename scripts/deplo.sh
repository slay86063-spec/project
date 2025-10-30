#!/bin/bash

echo "🚀 Deploying NFT Rental Contract to Stellar Testnet"
echo "=================================================="

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if stellar CLI is installed
if ! command -v stellar &> /dev/null; then
    echo -e "${RED}❌ Stellar CLI not found!${NC}"
    echo "Install: cargo install --locked stellar-cli"
    exit 1
fi

# Navigate to contract directory
cd "$(dirname "$0")/../contracts/nft-rental" || exit

# Build contract
echo -e "${YELLOW}📦 Building contract...${NC}"
cargo build --target wasm32-unknown-unknown --release

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Build failed!${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Build successful!${NC}"

# Deploy contract
echo -e "${YELLOW}🌐 Deploying to testnet...${NC}"
echo "Note: You'll need to provide your secret key when prompted"

stellar contract deploy \
  --wasm target/wasm32-unknown-unknown/release/nft_rental.wasm \
  --network testnet

echo -e "${GREEN}✅ Deployment complete!${NC}"
echo "⚠️  Save the CONTRACT_ID above and update it in frontend/index.html"