# Setup Guide

## Step-by-Step Installation

### 1. Install Prerequisites

#### Rust
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup target add wasm32-unknown-unknown
```

#### Stellar CLI
```bash
cargo install --locked stellar-cli --features opt
```

#### Verify Installation
```bash
stellar --version
cargo --version
```

### 2. Clone & Setup
```bash
git clone https://github.com/YOUR_USERNAME/NFTRENTALPLATFORM.git
cd NFTRENTALPLATFORM
```

### 3. Create Stellar Testnet Account

1. Visit [Stellar Laboratory](https://laboratory.stellar.org/#account-creator?network=test)
2. Click "Generate keypair"
3. Save your PUBLIC KEY and SECRET KEY safely
4. Click "Get test network lumens" to fund account

### 4. Deploy Contract
```bash
cd contracts/nft-rental
cargo build --target wasm32-unknown-unknown --release

stellar contract deploy \
  --wasm target/wasm32-unknown-unknown/release/nft_rental.wasm \
  --network testnet \
  --source YOUR_SECRET_KEY
```

**Save the CONTRACT_ID output!**

### 5. Configure Frontend

Edit `frontend/index.html`:
```javascript
const CONTRACT_ID = 'YOUR_CONTRACT_ID_HERE';
```

### 6. Run Frontend
```bash
cd ../../frontend
python3 -m http.server 8000
```

Open: `http://localhost:8000`

### 7. Install Freighter Wallet

1. Install from [freighter.app](https://www.freighter.app/)
2. Create/Import account
3. Switch to Testnet
4. Connect to app

## Troubleshooting

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md)