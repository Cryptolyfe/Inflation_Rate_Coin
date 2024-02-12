pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Mintable.sol";


contract INFCoin is ERC20, ERC20Detailed, ERC20Mintable {
   uint fakenow = now;
   uint public lastCPI = 100;
   uint unlock_time;
   //uint cpiDiff;
   //uint pctChange;
   address payable owner;
   address [] public tokenHolders;
   constructor(
        string memory name,
        string memory symbol,
        uint initial_supply
        //address payable _owner
    )
        ERC20Detailed(name, symbol, 18)
        public
    {
        // constructor can stay empty
        //owner = _owner;
    }

function fastforward() public {
    fakenow += 30 days;
}

modifier onlyOwner() {
    require(msg.sender == owner, "NO COINS FOR YOU! GAME OVER");
    _;
}

modifier dateValid() {
    require(unlock_time < fakenow, "NO COINS AT THIS TIME - TRY LATER");
    _;
}

function checkInflation(uint newCPI) public {
        unlock_time = fakenow + 30 days;
        uint cpiDiff = newCPI -lastCPI;
        uint pctChange = cpiDiff / lastCPI;
    for (uint i = 0; i < tokenHolders.length; i++){
        // obtain balance of account
        // calculate increase
        uint balance = balanceOf(tokenHolders[i]); // replace 0 with actu
        uint increase = pctChange * balance;
        // mint coins
        mint(tokenHolders[i], increase);
    }
    lastCPI = newCPI;
  }

  function addHolder(address holder) public {
    tokenHolders.push(holder);
  }
}
