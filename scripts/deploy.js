const { ethers } = require("hardhat");
const { parseEther } = require("ethers");

async function main() {
  const INFCoin = await ethers.getContractFactory("INFCoin");
  
  // Deploy with desired parameters:
  // name: "INFCoin"
  // symbol: "INF"
  // initialSupply: 1000000 (1 million)
  // cap: 2000000 (2 million) converted via parseEther for decimals
  const infCoin = await INFCoin.deploy("INFCoin", "INF", 1000000, parseEther("2000000"));
  
  await infCoin.waitForDeployment();
  console.log("INFCoin deployed to:", await infCoin.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
