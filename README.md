# 🎨 NFT Rental Platform

A decentralized NFT rental marketplace built on Stellar blockchain using Soroban smart contracts.

## ✨ Features

- List NFTs for rent with custom duration and pricing
- Browse available NFTs in marketplace
- Rent NFTs with secure smart contract transactions
- Return rented NFTs
- Track rental history

## 🚀 Quick Start

### Prerequisites

- [Rust](https://rustup.rs/) (latest stable)
- [Stellar CLI](https://developers.stellar.org/docs/smart-contracts/getting-started/setup)
- [Node.js](https://nodejs.org/) v16+ (for local server)
- [Freighter Wallet](https://www.freighter.app/) (browser extension)

### Installation

1. **Clone the repository**
```bash
   git clone https://github.com/YOUR_USERNAME/NFTRENTALPLATFORM.git
   cd NFTRENTALPLATFORM
```

2. **Deploy Smart Contract**
```bash
   cd contracts/nft-rental
   
   # Build contract
   cargo build --target wasm32-unknown-unknown --release
   
   # Deploy to testnet
   stellar contract deploy \
     --wasm target/wasm32-unknown-unknown/release/nft_rental.wasm \
     --network testnet \
     --source YOUR_SECRET_KEY
   
   # Save the CONTRACT_ID output!
```

3. **Configure Frontend**
```bash
   cd ../../frontend
   
   # Open index.html and replace CONTRACT_ID
   # Find: const CONTRACT_ID = 'CC6N6HB6G4BN3OA2...'
   # Replace with your deployed contract ID
```

4. **Run Frontend**
```bash
   # Simple HTTP server
   python3 -m http.server 8000
   
   # Or use npx
   npx serve .
   
   # Or Node.js
   npx http-server -p 8000
```

5. **Open Browser**

Navigate to: http://localhost:8000

## 📖 Documentation

- [Setup Guide](docs/SETUP.md) - Detailed installation instructions
- [API Documentation](docs/API.md) - Smart contract functions
- [Troubleshooting](docs/TROUBLESHOOTING.md) - Common issues

## 🧪 Testing

### Test Smart Contract
```bash
cd scripts
chmod +x test-contract.sh
./test-contract.sh
```

### Test Frontend
1. Open `http://localhost:8000`
2. Click "Connect Wallet"
3. Go to "Test Panel" tab
4. Run tests 1 → 2 → 3 → 4

## 🌐 Live Demo

**Contract ID (Testnet):** `CC6N6HB6G4BN3OA2NATB34V54AE6NIR7CQ2XUCH4SDUVAUIT3SWHE426`

[Try Live Demo →](https://your-github-username.github.io/NFTRENTALPLATFORM/frontend/)

## 🛠️ Tech Stack

- **Blockchain:** Stellar (Soroban)
- **Smart Contract:** Rust
- **Frontend:** HTML5, CSS3, Vanilla JavaScript
- **Wallet:** Freighter

## 📝 Smart Contract Functions

| Function | Description |
|----------|-------------|
| `list_nft_for_rent` | List an NFT with duration and price |
| `view_rental_info` | Get rental details for an NFT |
| `rent_nft` | Rent an available NFT |
| `return_nft` | Return a rented NFT |

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📄 License

MIT License - see [LICENSE](LICENSE) file

## 🆘 Support

- [GitHub Issues](https://github.com/YOUR_USERNAME/NFTRENTALPLATFORM/issues)
- [Stellar Discord](https://discord.gg/stellardev)

## 👥 Authors

- Your Name - [@yourhandle](https://github.com/YOUR_USERNAME)

---

**⭐ Star this repo if you find it helpful!**