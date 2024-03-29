pragma solidity ^0.5.0;

import "./INFCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

// @TODO: Inherit the crowdsale contracts
contract INFCoinCrowdsale is Crowdsale, MintedCrowdsale /* CappedCrowdsale, /*TimedCrowdsale, RefundablePostDeliveryCrowdsale */ {
    //INFCoin INFToken;
    constructor(
        // @TODO: Fill in the constructor parameters!
        uint rate, // rate in INF tokens
        INFCoin token,  // name of the token
        address payable wallet, // sale beneficiary
        uint goal, // goal for crowdsale
        uint open,
        uint close
        //uint cap
    )
    Crowdsale(rate, wallet, token)
    //TimedCrowdsale(now, now + 4 weeks) /* closing time is in 4 weeks */
    /*CappedCrowdsale(goal)
    RefundableCrowdsale(goal)*/
        // @TODO: Pass the constructor parameters to the crowdsale contracts.
        public
    {
        // constructor can stay empty
    }
}
contract INFCoinSaleDeployer {
    address public token_sale_address;
    address public token_address;
    constructor(
        // @TODO: Fill in the constructor parameters!
        string memory name,
        string memory symbol,
        address payable wallet, // sale beneficiary
        uint goal
    )
        public
    {
        // @TODO: create the INFCoin and keep its address handy
        INFCoin token = new INFCoin(name, symbol, 0);
        token_address = address(token);
        // @TODO: create the INFCoinSale and tell it about the token, set the goal, and set the open and close times to now and now + 4 weeks.
        INFCoinCrowdsale token_sale = new INFCoinCrowdsale(1, token, wallet, goal, now, now + 4 weeks);
        token_sale_address = address(token_sale);
        // make the INFCoinSale contract a minter, then have the INFCoinSaleDeployer renounce its minter role
        token.addMinter(token_sale_address);
        token.addMinter(msg.sender);
        //token.renounceMinter();
    }
}
