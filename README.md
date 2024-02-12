# Inflation Rate Coin or INFR

In the last year alone, inflation has risen by a staggering 7% according to the Consumer Price Index(CPI).
<br>
<br>
INFCoin, or Inflation Coin, uses the percent change (pct_change) of the CPI to adjust the amount of the holder's tokens. The tokens are added or subtracted monthly, depending on if inflation increases or decreases.
<br>
<br>
We created an ERC20 token that includes a check inflation function, that checks for the percent change in inflation(CPI) and then loops though an array of the current token holders, to add or subtract the tokens based on the inflation rate, to each token holder’s balance, essentially acting as a hedge against inflation.

INFR is currently a proof of concept, as we still need to add an oracle to check inflation programmatically instead of manually. 


 ## Update: COINBASE realeased the exact same concept over a year after this repo was published.  They deemed the tokens "flat coins" and called it a "critical innovation"


<br>
<br>
To demonstrate:
<br>
<br>
First, we deployed the INFCoin sale. INFCoin sale is inherited from crowdsale.  The CrowdSale contract uses the interface of ERC20 to sell the token, and for our token's unique requirement of storing every owner address in an array, we had to modify the ERC20 interface to implement a function for adding to that array.
<br>
<br>
<img width="1429" alt="INFCoin Deployer" src="https://user-images.githubusercontent.com/87285522/149602309-bd6daffd-556d-4e04-891a-e51aadb78f01.png">
<br>
<br>
Then, we deployed the contract for the crowdsale using the token sale address generated by the coin sale contract.
<br>
<br>
<img width="1433" alt="INFCoin Crowdsale w:Token sale address" src="https://user-images.githubusercontent.com/87285522/149603764-3ef5531c-46f5-4fa2-a573-b951707bca65.png">
<br>
<br>
Following this, we purchased 1 ether's worth of tokens on Ganache's local network which has been added to Metamask.
<br>
<br>
<img width="1432" alt="Buy Tokens at Ganache Address" src="https://user-images.githubusercontent.com/87285522/149603880-ccfaa5ef-bc33-45e5-b156-b7d4d08e704b.png">
<br>
<br>
Next, we deployed our INFCoin contract using our token address.
<br>
<br>
<img width="1435" alt=" INFCOIN contract w:token address" src="https://user-images.githubusercontent.com/87285522/149603964-be6c4b31-a067-4cd6-a7af-096edb3beab2.png">
<br>
<br>
Once the INFCoin contract was deployed, we checked our Ganache account balance.
<br>
<br>
<img width="1434" alt="check balance of Ganache acct" src="https://user-images.githubusercontent.com/87285522/149603985-632991f2-429d-4cfa-94c9-e34f471f0c02.png">
<br>
<br>
In the next step we checked the inflation rate and then confirmed our tokens increased.
<br>
<br>
<img width="1431" alt="check inflation and check adjusted balance" src="https://user-images.githubusercontent.com/87285522/149604092-b83b3ecc-5a7d-4083-8134-7ead5a2c987b.png">
<br>
<br>
Finally, we added INFCoin to our metamask wallet.
<br>
<br>
<img width="1297" alt="Add INF to Metamask " src="https://user-images.githubusercontent.com/87285522/149604588-f9386d85-fef5-4b4b-a560-7576d14433a3.png">
<br>
<br>
Inflation Coin is a store of value that hedges against inflation, by maintaining the purchasing power of your investment.  Something your bank currently does not do!
<br>
<br>

