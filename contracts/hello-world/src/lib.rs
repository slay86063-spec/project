#![no_std]

use soroban_sdk::{contract, contracttype, contractimpl, log, Env, Address, Symbol, symbol_short};

// Struct to store rental information
#[contracttype]
#[derive(Clone)]
pub struct RentalInfo {
    pub nft_id: u64,
    pub owner: Address,
    pub renter: Address,
    pub rental_start: u64,
    pub rental_end: u64,
    pub price: i128,
    pub is_active: bool,
}

// Mapping NFT ID to rental information
#[contracttype]
pub enum RentalBook {
    Rental(u64),
}

// Counter for total rentals
const RENTAL_COUNT: Symbol = symbol_short!("R_COUNT");

#[contract]
pub struct NFTRentalContract;

#[contractimpl]
impl NFTRentalContract {
    
    // Function to list an NFT for rent
    pub fn list_nft_for_rent(
        env: Env,
        nft_id: u64,
        owner: Address,
        rental_duration: u64,
        price: i128,
    ) -> u64 {
        // Verify the owner
        owner.require_auth();

        let current_time = env.ledger().timestamp();
        let rental_end = current_time + rental_duration;

        // Create rental record
        let rental_info = RentalInfo {
            nft_id: nft_id.clone(),
            owner: owner.clone(),
            renter: owner.clone(),
            rental_start: 0,
            rental_end: rental_end,
            price,
            is_active: false,
        };

        // Store the rental information
        env.storage()
            .instance()
            .set(&RentalBook::Rental(nft_id.clone()), &rental_info);

        // Update rental count
        let mut count: u64 = env.storage().instance().get(&RENTAL_COUNT).unwrap_or(0);
        count += 1;
        env.storage().instance().set(&RENTAL_COUNT, &count);

        env.storage().instance().extend_ttl(5000, 5000);

        log!(&env, "NFT ID: {} listed for rent", nft_id);
        nft_id
    }

    // Function to rent an NFT
    pub fn rent_nft(env: Env, nft_id: u64, renter: Address) {
        // Verify the renter
        renter.require_auth();

        // Get rental information
        let mut rental_info = Self::view_rental_info(env.clone(), nft_id.clone());

        // Check if NFT is available for rent
        if rental_info.is_active == false && rental_info.nft_id == nft_id {
            let current_time = env.ledger().timestamp();

            // Update rental information
            rental_info.renter = renter.clone();
            rental_info.rental_start = current_time;
            rental_info.is_active = true;

            // Store updated rental information
            env.storage()
                .instance()
                .set(&RentalBook::Rental(nft_id.clone()), &rental_info);

            env.storage().instance().extend_ttl(5000, 5000);

            log!(&env, "NFT ID: {} rented successfully", nft_id);
        } else {
            log!(&env, "NFT is not available for rent");
            panic!("NFT is not available for rent");
        }
    }

    // Function to return a rented NFT
    pub fn return_nft(env: Env, nft_id: u64) {
        // Get rental information
        let mut rental_info = Self::view_rental_info(env.clone(), nft_id.clone());

        // Verify the renter is returning the NFT
        rental_info.renter.require_auth();

        // Check if rental is active
        if rental_info.is_active == true {
            // Mark rental as inactive
            rental_info.is_active = false;

            // Store updated rental information
            env.storage()
                .instance()
                .set(&RentalBook::Rental(nft_id.clone()), &rental_info);

            env.storage().instance().extend_ttl(5000, 5000);

            log!(&env, "NFT ID: {} returned successfully", nft_id);
        } else {
            log!(&env, "No active rental found for this NFT");
            panic!("No active rental found for this NFT");
        }
    }

    // Function to view rental information
    pub fn view_rental_info(env: Env, nft_id: u64) -> RentalInfo {
        let key = RentalBook::Rental(nft_id.clone());

        env.storage().instance().get(&key).unwrap_or(RentalInfo {
            nft_id: 0,
            owner: Address::from_string(&soroban_sdk::String::from_str(&env, "GAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWHF")),
            renter: Address::from_string(&soroban_sdk::String::from_str(&env, "GAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWHF")),
            rental_start: 0,
            rental_end: 0,
            price: 0,
            is_active: false,
        })
    }
}
