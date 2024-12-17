const { expect } = require("chai");
const { ethers } = require("hardhat");
const { parseEther, parseUnits } = require("ethers");

describe("INFCoin", function () {
  let infCoin, owner, addr1;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();

    const INFCoin = await ethers.getContractFactory("INFCoin");
    // Deploy the contract with initial supply and cap, using parseEther for consistency
    infCoin = await INFCoin.deploy("INFCoin", "INF", 1000000, parseEther("2000000"));
    await infCoin.waitForDeployment();
  });

  it("Should have the correct initial supply", async function () {
    const supply = await infCoin.totalSupply();
    // Initial supply was given as 1,000,000 tokens, each with 18 decimals
    expect(supply).to.equal(parseEther("1000000"));
  });

  it("Owner can add a holder", async function () {
    // The owner adds addr1 as a token holder
    await infCoin.addHolder(addr1.address);
    const holder = await infCoin.tokenHolders(1);
    expect(holder).to.equal(addr1.address);
  });

  it("Owner can check inflation and adjust balances", async function () {
    // Add addr1 as a holder
    await infCoin.addHolder(addr1.address);

    // Give addr1 some tokens so inflation can actually increase their balance
    await infCoin.transfer(addr1.address, parseEther("100"));

    // Simulate a 5% inflation increase:
    // lastCPI = 100 * 1e18, newCPI = 105 * 1e18, so we use parseUnits("105", 18)
    await infCoin.checkInflation(parseUnits("105", 18));

    const balance = await infCoin.balanceOf(addr1.address);
    // After a 5% increase, addr1 should have more than 100 tokens
    expect(balance).to.be.gt(parseEther("100"));
  });
});
