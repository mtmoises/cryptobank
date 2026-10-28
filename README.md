# 🏦 CryptoBank Smart Contract & Vault

A secure, gas-optimized decentralized banking vault built with **Solidity ^0.8.20** and thoroughly tested using **Foundry**. 

This smart contract manages native Ether deposits and withdrawals with strict balance caps, role-based administration, custom gas-efficient error handling, and complete Checks-Effects-Interactions (CEI) pattern compliance.

---

## 📌 Architecture & Features

- **Gas-Efficient Custom Errors:** Replaces traditional string-based `require` statements with Solidity custom errors (`NotAdmin`, `MaxBalanceReached`, `NotEnoughBalance`, `TransferFailed`) to minimize deployment and execution gas costs.
- **Deposit Cap Enforcement:** Implements a strict protocol-wide maximum balance ceiling (`maxBalance`) per user or deposit rule, managed securely by the admin.
- **Reentrancy Protection via CEI:** Core withdrawal paths strictly follow the Checks-Effects-Interactions pattern, updating state balances before transferring funds via low-level `.call`.
- **Role-Based Administration (`onlyAdmin`):** Restricts protocol configuration changes—such as modifying the maximum balance limit—to the authorized admin account.
- **Robust Test Suite:** Fully tested using Foundry, validating positive flows, boundary conditions, access controls, and custom error selectors.

---

## 🛠 Tech Stack & Tools

- **Language:** Solidity `^0.8.20`
- **Framework:** Foundry (Forge & Cast)
- **Target Network:** EVM Compatible Chains

---

## 🚀 Smart Contract Overview

### Core Functions

1. **`depositEther()`**
   - External payable function that allows users to deposit native Ether into their vault balance, enforcing the `maxBalance` limit.

2. **`withdrawEther(uint256 amount_)`**
   - Allows users to safely withdraw funds. Validates user balances, updates state, and transfers ETH using a secure `.call` wrapper.

3. **`modifyMaxBalance(uint256 newMaxBalance_)` *(Admin Only)***
   - Protected by `onlyAdmin`. Allows the administrator to update the global deposit threshold.

---

## ⚡ Quickstart & Testing (Foundry)

### 1. Clone Repository & Install Dependencies
```bash
git clone [https://github.com/mtmoises/cryptobank-smart-contract.git](https://github.com/mtmoises/cryptobank-smart-contract.git)
cd cryptobank-smart-contract
forge install
