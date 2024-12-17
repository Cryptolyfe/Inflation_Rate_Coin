// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";

/**
 * @title INFCoin (Inflation Rate Coin)
 * @notice A token that adjusts holder balances based on changes in the CPI (inflation).
 *         If inflation is positive, new tokens are minted and distributed proportionally.
 *         If inflation is negative (deflation), tokens are burned from holder balances.
 *         This is a conceptual demo and not production-ready.
 */
contract INFCoin is ERC20Capped, ERC20Burnable, Ownable {
    // Last recorded CPI value
    uint256 public lastCPI = 100 * 1e18; // Storing CPI as scaled by 1e18 for precision

    // Array of token holders; this method is simplistic and not scalable
    address[] public tokenHolders;

    // Event for transparency
    event InflationAdjusted(int256 pctChange, uint256 newCPI);

    /**
     * @dev Constructor sets token details and initial supply.
     * @param name Name of the token.
     * @param symbol Symbol of the token.
     * @param initialSupply Initial supply of the token (in whole units).
     * @param cap Maximum cap on the total supply.
     */
    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply,
        uint256 cap
    ) 
        ERC20(name, symbol) 
        ERC20Capped(cap)
    {
        // Mint initial supply to owner
        _mint(_msgSender(), initialSupply * 10**decimals());
        tokenHolders.push(_msgSender());
    }

    /**
     * @notice Add a new holder to the array.
     * @dev In a real system, this might be automatically handled whenever tokens are transferred.
     *      For simplicity, this function can be manually called when someone new buys the token.
     */
    function addHolder(address holder) external onlyOwner {
        // In production, checks to ensure we don't add duplicates would be necessary.
        tokenHolders.push(holder);
    }

    /**
     * @notice Adjust token balances based on a new CPI value.
     * @param newCPI The updated CPI, scaled by 1e18 for decimal precision.
     * 
     * @dev pctChange = (newCPI - lastCPI) / lastCPI
     *      If pctChange > 0 => Inflation increased: Mint and distribute tokens.
     *      If pctChange < 0 => Inflation decreased: Burn tokens proportionally.
     * 
     *      In practice, integer math is tricky for percentages. Here we scale
     *      CPI values by 1e18 and do fixed-point arithmetic to get a more accurate pctChange.
     * 
     *      This function is restricted to owner for now, but in a real system,
     *      you would integrate a Chainlink oracle or other data feeds.
     */
    function checkInflation(uint256 newCPI) external onlyOwner {
        require(newCPI > 0, "CPI must be greater than zero");

        int256 cpiDiff = int256(newCPI) - int256(lastCPI);
        int256 pctChange = (cpiDiff * 1e18) / int256(lastCPI);

        // If pctChange is zero, no changes needed
        if (pctChange == 0) {
            lastCPI = newCPI;
            emit InflationAdjusted(pctChange, newCPI);
            return;
        }

        // Loop through all holders to adjust balances
        for (uint256 i = 0; i < tokenHolders.length; i++) {
            address holder = tokenHolders[i];
            uint256 balance = balanceOf(holder);

            if (balance == 0) {
                continue;
            }

            // adjusted = balance * pctChange / 1e18
            // Using absolute value and sign checking to handle mint or burn
            int256 adjustment = (int256(balance) * pctChange) / int256(1e18);

            if (adjustment > 0) {
                // Positive inflation: Mint new tokens
                // Ensure the new mint does not exceed cap
                uint256 mintAmount = uint256(adjustment);
                require(totalSupply() + mintAmount <= cap(), "Cap exceeded");
                _mint(holder, mintAmount);
            } else {
                // Negative inflation (deflation): Burn tokens
                uint256 burnAmount = uint256(-adjustment);
                // Ensure burnAmount doesn't exceed the holder's balance (it shouldn't if logic is correct)
                if (burnAmount > 0 && burnAmount <= balanceOf(holder)) {
                    _burn(holder, burnAmount);
                }
            }
        }

        lastCPI = newCPI;
        emit InflationAdjusted(pctChange, newCPI);
    }

    /**
     * @notice Placeholder for Oracle Integration
     * @dev In a real-world scenario, this would use an oracle (like Chainlink) to fetch CPI data automatically.
     *      For now, the `checkInflation` function is manually fed the CPI value by the owner.
     */
    function updateCPIFromOracle() external onlyOwner {
        // Example Pseudocode:
        // uint256 externalCPI = IOracle(cpiOracleAddress).latestCPI();
        // checkInflation(externalCPI);
    }

    /**
     * @dev Override _mint to respect the cap of ERC20Capped.
     */
    function _mint(address account, uint256 amount) internal virtual override(ERC20, ERC20Capped) {
        super._mint(account, amount);
    }
}
