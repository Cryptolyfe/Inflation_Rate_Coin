// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract INFCoin is ERC20Capped, ERC20Burnable, Ownable {
    uint256 public lastCPI = 100 * 1e18;
    address[] public tokenHolders;

    event InflationAdjusted(int256 pctChange, uint256 newCPI);

    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply,
        uint256 cap
    )
        ERC20(name, symbol)
        ERC20Capped(cap)
        Ownable()
    {
        _mint(msg.sender, initialSupply * 10**decimals());
        tokenHolders.push(msg.sender);
    }

    // Override the _mint function to resolve the conflict
    function _mint(address account, uint256 amount)
        internal
        virtual
        override(ERC20, ERC20Capped)
    {
        super._mint(account, amount);
    }

    function addHolder(address holder) external onlyOwner {
        tokenHolders.push(holder);
    }

    function checkInflation(uint256 newCPI) external onlyOwner {
        require(newCPI > 0, "CPI must be greater than zero");

        int256 cpiDiff = int256(newCPI) - int256(lastCPI);
        int256 pctChange = (cpiDiff * 1e18) / int256(lastCPI);

        if (pctChange == 0) {
            lastCPI = newCPI;
            emit InflationAdjusted(pctChange, newCPI);
            return;
        }

        for (uint256 i = 0; i < tokenHolders.length; i++) {
            address holder = tokenHolders[i];
            uint256 balance = balanceOf(holder);
            if (balance == 0) continue;

            int256 adjustment = (int256(balance) * pctChange) / int256(1e18);

            if (adjustment > 0) {
                uint256 mintAmount = uint256(adjustment);
                require(totalSupply() + mintAmount <= cap(), "Cap exceeded");
                _mint(holder, mintAmount);
            } else if (adjustment < 0) {
                uint256 burnAmount = uint256(-adjustment);
                if (burnAmount > 0 && burnAmount <= balanceOf(holder)) {
                    _burn(holder, burnAmount);
                }
            }
        }

        lastCPI = newCPI;
        emit InflationAdjusted(pctChange, newCPI);
    }
}
