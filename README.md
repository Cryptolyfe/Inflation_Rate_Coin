# INFCoin (Inflation-Adjusted Token)

INFCoin is a conceptual ERC-20 token that adjusts its holders’ balances based on changes in the Consumer Price Index (CPI). The token is meant as a proof-of-concept for a crypto asset that maintains purchasing power by minting or burning tokens according to monthly inflation data.

## Key Features

- **Inflation Hedging:**  
  Each month, you can call `checkInflation(newCPI)` to adjust token balances.  
  - If inflation is positive, additional tokens are minted and distributed to holders.  
  - If inflation is negative (deflation), tokens are burned proportionally from each holder’s balance.

- **ERC-20 Standard:**  
  INFCoin is an ERC-20 token, compatible with wallets, exchanges, and DeFi protocols.

- **Future Integration with Oracles:**  
  Currently, CPI must be set manually by the owner. In the future, a Chainlink or other oracle integration can automatically update CPI values and trigger inflation adjustments.


