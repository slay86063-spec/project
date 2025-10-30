#!/bin/bash

echo "🧪 Testing NFT Rental Contract"
echo "=============================="

CONTRACT_ID="CC6N6HB6G4BN3OA2NATB34V54AE6NIR7CQ2XUCH4SDUVAUIT3SWHE426"

# Test 1: List NFT
echo "1️⃣ Testing list_nft_for_rent..."
stellar contract invoke \
  --id $CONTRACT_ID \
  --network testnet \
  -- list_nft_for_rent \
  --nft_id 9001 \
  --owner YOUR_PUBLIC_KEY \
  --rental_duration 86400 \
  --price 1000000

# Test 2: View Rental Info
echo "2️⃣ Testing view_rental_info..."
stellar contract invoke \
  --id $CONTRACT_ID \
  --network testnet \
  -- view_rental_info \
  --nft_id 9001

echo "✅ Tests complete!"