# INFCoin (Inflation-Adjusted ERC-20 Token)

**INFCoin** is a conceptual ERC-20 token that adjusts holder balances according to changes in the Consumer Price Index (CPI). By periodically calling the `checkInflation` function with updated CPI data, the token supply is dynamically increased or decreased across all holders to maintain purchasing power. This is a proof-of-concept and not intended for production use without further development, auditing, and integration with data oracles.

## Key Features

- **Inflation Hedging:**  
  Balances adjust based on monthly CPI changes. If inflation rises, the contract mints additional tokens proportional to each holder’s balance. If inflation decreases, it burns tokens proportionally.
  
- **ERC-20 Standard Compliance:**  
  Built on OpenZeppelin’s ERC-20 implementation, ensuring compatibility with wallets, exchanges, and other DeFi protocols.

- **Future Oracle Integration (Planned):**  
  Currently, CPI data must be set manually by the owner. Future versions could integrate Chainlink or other oracles for automated CPI updates.

## Project Structure

Inflation_Rate_Coin/ ├─ contracts/ │ └─ INFCOin.sol // The inflation-adjusted token contract ├─ scripts/ │ └─ deploy.js // Script to deploy the contract ├─ test/ │ └─ INFCoin.test.js // Mocha/Chai tests using Hardhat and Ethers ├─ .env // Environment variables (e.g., PRIVATE_KEY, RPC URLs) ├─ .gitignore ├─ hardhat.config.js ├─ package.json └─ README.md


## Prerequisites

- **Node.js & npm:**  
  Install from [https://nodejs.org/](https://nodejs.org/).
  
- **Hardhat:**  
  Installed via `npm install` (as a dev dependency) in this project.

- **OpenZeppelin Contracts:**  
  Installed as a dependency, providing ERC-20 base implementations.

- **Ethers & Hardhat Toolbox:**  
  For deploying, testing, and interacting with the contracts.

## Future Improvements
Oracle Integration:
Implement an oracle (e.g., Chainlink) to fetch CPI data automatically, removing the need for manual input.

Additional Testing & Audits:
Add more test cases, especially around edge conditions and negative inflation (deflation). Consider a full audit for production readiness.

Governance & Adjustments:
Add governance mechanisms to control parameters like frequency of inflation checks or maximum cap adjustments.

License
This project is available under the MIT License.

Disclaimer
This contract is a proof-of-concept and is not audited. Use at your own risk. The mechanics described are purely experimental and may not reflect real-world economic conditions or guarantees.