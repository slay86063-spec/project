# nftrentalplatform 🚀

A Soroban smart-contract for listing, renting, and returning NFTs on Stellar. Simple on‑chain rental lifecycle, rental tracking, and unit tests.

---

## Table of Contents
- [Tech stack](#tech-stack)
- [Features](#features)
- [Requirements](#requirements)
- [Quick install](#quick-install)
- [Build & test](#build--test)
- [Usage](#usage)
- [Screenshots](#screenshots)
- [Folder structure](#folder-structure)
- [Future work](#future-work)
- [Contributing](#contributing)
- [Troubleshooting](#troubleshooting)
- [License](#license)
- [Author](#author)

---

## Tech stack
- Rust (Soroban smart contracts)
- Soroban SDK / Stellar CLI
- Cargo, GNU Make (optional)
- Optional frontend: JavaScript / React

---

## Features
- List NFT for rent (owner, price, duration)
- Rent NFT (records renter and rental window)
- Return NFT (end rental)
- Query rental info by NFT ID
- Unit tests for contract logic

---

## Requirements
- Rust toolchain (stable)
- wasm target: wasm32-unknown-unknown
- Soroban / Stellar CLI on PATH
- GNU Make (optional)
- Node.js (only if using frontend)

---

## Quick install
Clone repository and enter project root:
```bash
git clone <REPOSITORY_URL>
cd nftrentalplatform
```

Add wasm target (once):
```bash
rustup target add wasm32-unknown-unknown
```

Install Soroban/stellar CLI per official docs.

---

## Build & test
Build contract (example):
```bash
cd contracts/nftrental
make build         # uses Makefile if present
# or
cargo build --release --target wasm32-unknown-unknown
```

Run tests:
```bash
cargo test
# or from repo root
make test
```

WASM artifact location (after build):
contracts/nftrental/target/wasm32-unknown-unknown/release/

---

## Usage
Deploy and call contract (example CLI commands — adapt args to your ABI):

Deploy:
```bash
stellar contract deploy --wasm contracts/nftrental/target/wasm32-unknown-unknown/release/nftrental.wasm --network local
```

Call examples:
```bash
# list an NFT
stellar contract invoke --id <CONTRACT_ID> --fn list_nft_for_rent --arg '("nft-123","owner","86400",100)' --network local

# rent an NFT
stellar contract invoke --id <CONTRACT_ID> --fn rent_nft --arg '("nft-123","renter")' --network local

# return an NFT
stellar contract invoke --id <CONTRACT_ID> --fn return_nft --arg '("nft-123")' --network local

# view rental info
stellar contract invoke --id <CONTRACT_ID> --fn view_rental_info --arg '("nft-123")' --network local
```

Refer to contracts/nftrental/src/lib.rs for exact signatures and auth requirements.

---

## Screenshots
Place images under docs/ and reference them with either Markdown or HTML for full-width display.

Full-width example (recommended for README):
```html
<p align="center">
  <img src="docs/screenshot.png" alt="Demo" width="100%">
</p>
```

Standard Markdown:
```markdown
![Demo screenshot](docs/screenshot.png)
```

Use relative paths so GitHub and local preview resolve images.

---

## Folder structure
```
.
├── README.md
├── LICENSE
├── Cargo.toml
├── contracts/
│   └── nftrental/
│       ├── Cargo.toml
│       ├── Makefile
│       └── src/
│           ├── lib.rs
│           └── test.rs
├── frontend/        # optional
└── docs/            # images, diagrams, guides
```

---

## Future work
- On‑chain payments and escrow
- Rental expiry enforcement and penalties
- Event logs & indexing for frontend
- React dashboard and improved tests/CI

---

## Contributing
1. Fork the repo.
2. Create a branch: git checkout -b feat/your-feature
3. Add tests and run: cargo fmt && cargo test
4. Open a PR with description and tests.

---

## Troubleshooting
- "wasm target missing": rustup target add wasm32-unknown-unknown  
- "stellar / soroban CLI not found": install and add to PATH  
- Tests failing: run cargo test -v and include logs when filing issues

---

## License
MIT — see LICENSE file.

---

## Author
Your Name  
GitHub: https://github.com/your-username  
Email: your.email@example.com

---
```// filepath: c:\Users\ACER\Desktop\stellar project\NFTRENTALPLATFORM\README.md
# nftrentalplatform 🚀

A Soroban smart-contract for listing, renting, and returning NFTs on Stellar. Simple on‑chain rental lifecycle, rental tracking, and unit tests.

---

## Table of Contents
- [Tech stack](#tech-stack)
- [Features](#features)
- [Requirements](#requirements)
- [Quick install](#quick-install)
- [Build & test](#build--test)
- [Usage](#usage)
- [Screenshots](#screenshots)
- [Folder structure](#folder-structure)
- [Future work](#future-work)
- [Contributing](#contributing)
- [Troubleshooting](#troubleshooting)
- [License](#license)
- [Author](#author)

---

## Tech stack
- Rust (Soroban smart contracts)
- Soroban SDK / Stellar CLI
- Cargo, GNU Make (optional)
- Optional frontend: JavaScript / React

---

## Features
- List NFT for rent (owner, price, duration)
- Rent NFT (records renter and rental window)
- Return NFT (end rental)
- Query rental info by NFT ID
- Unit tests for contract logic

---

## Requirements
- Rust toolchain (stable)
- wasm target: wasm32-unknown-unknown
- Soroban / Stellar CLI on PATH
- GNU Make (optional)
- Node.js (only if using frontend)

---

## Quick install
Clone repository and enter project root:
```bash
git clone <REPOSITORY_URL>
cd nftrentalplatform
```

Add wasm target (once):
```bash
rustup target add wasm32-unknown-unknown
```

Install Soroban/stellar CLI per official docs.

---

## Build & test
Build contract (example):
```bash
cd contracts/nftrental
make build         # uses Makefile if present
# or
cargo build --release --target wasm32-unknown-unknown
```

Run tests:
```bash
cargo test
# or from repo root
make test
```

WASM artifact location (after build):
contracts/nftrental/target/wasm32-unknown-unknown/release/

---

## Usage
Deploy and call contract (example CLI commands — adapt args to your ABI):

Deploy:
```bash
stellar contract deploy --wasm contracts/nftrental/target/wasm32-unknown-unknown/release/nftrental.wasm --network local
```

Call examples:
```bash
# list an NFT
stellar contract invoke --id <CONTRACT_ID> --fn list_nft_for_rent --arg '("nft-123","owner","86400",100)' --network local

# rent an NFT
stellar contract invoke --id <CONTRACT_ID> --fn rent_nft --arg '("nft-123","renter")' --network local

# return an NFT
stellar contract invoke --id <CONTRACT_ID> --fn return_nft --arg '("nft-123")' --network local

# view rental info
stellar contract invoke --id <CONTRACT_ID> --fn view_rental_info --arg '("nft-123")' --network local
```

Refer to contracts/nftrental/src/lib.rs for exact signatures and auth requirements.

---

## Screenshots
Place images under docs/ and reference them with either Markdown or HTML for full-width display.

Full-width example (recommended for README):
```html
<p align="center">
  <img src="docs/screenshot.png" alt="Demo" width="100%">
</p>
```

Standard Markdown:
```markdown
![Demo screenshot](docs/screenshot.png)
```

Use relative paths so GitHub and local preview resolve images.

---

## Folder structure
```
.
├── README.md
├── LICENSE
├── Cargo.toml
├── contracts/
│   └── nftrental/
│       ├── Cargo.toml
│       ├── Makefile
│       └── src/
│           ├── lib.rs
│           └── test.rs
├── frontend/        # optional
└── docs/            # images, diagrams, guides
```

---

## Future work
- On‑chain payments and escrow
- Rental expiry enforcement and penalties
- Event logs & indexing for frontend
- React dashboard and improved tests/CI

---

## Contributing
1. Fork the repo.
2. Create a branch: git checkout -b feat/your-feature
3. Add tests and run: cargo fmt && cargo test
4. Open a PR with description and tests.

---

## Troubleshooting
- "wasm target missing": rustup target add wasm32-unknown-unknown  
- "stellar / soroban CLI not found": install and add to PATH  
- Tests failing: run cargo test -v and include logs when filing issues

---

## License
MIT — see LICENSE file.

---

## Author
Your Name  
GitHub: https://github.com/your-username  
Email: your.email@example.com

---