import { expect } from "chai";
import { Attacker, Reentrancy } from "../typechain-types";
import { CONTRACTS_NAMES } from "../constants";
import { formatUnits, parseEther } from "ethers/lib/utils";

const hre = require("hardhat");
const { ethers, deployments, getNamedAccounts } = hre;
const { provider } = ethers;

type Fixture = {
  reentrancyContract: Reentrancy;
  attackerContract: Attacker;
};

const setup = deployments.createFixture(async (): Promise<Fixture> => {
  await deployments.fixture(CONTRACTS_NAMES.REENTRANCY);
  const reentrancyContract = await ethers.getContract(
    CONTRACTS_NAMES.REENTRANCY
  );
  const attackerContract = await ethers.getContract(CONTRACTS_NAMES.ATTACKER);
  return {
    reentrancyContract,
    attackerContract,
  };
});

describe(CONTRACTS_NAMES.REENTRANCY, function () {
  let deployer: any;
  let attacker: any;
  let fixture: Fixture;

  before(async () => {
    ({ deployer, attacker } = await getNamedAccounts());
    fixture = await setup();
  });

  it("should deposit with deployer", async function () {
    const { reentrancyContract } = fixture;
    const depositAmount = parseEther("40");
    await reentrancyContract.deposit({
      value: depositAmount,
      from: deployer,
    });

    let filter = reentrancyContract.filters.LogDeposit(null, deployer);
    const events = await reentrancyContract.queryFilter(filter);

    // sender is the attacker contract, not the signer
    expect(events[0].args.sender).to.be.eql(deployer);
    expect(events[0].args.amount).to.be.eql(depositAmount);
  });

  it("should deposit from Attacker contract", async function () {
    const { attackerContract, reentrancyContract } = fixture;
    const depositAmount = parseEther("10");
    await attackerContract.deposit({
      value: depositAmount,
    });

    let filter = reentrancyContract.filters.LogDeposit(
      null,
      attackerContract.address
    );
    const events = await reentrancyContract.queryFilter(filter);

    // sender is the attacker contract, not the signer
    expect(events[0].args.sender).to.be.eql(attackerContract.address);
    expect(events[0].args.amount).to.be.eql(depositAmount);
  });

  it("should withdraw multiple times with reentrancy", async function () {
    const { attackerContract, reentrancyContract } = fixture;
    const reentrancyContractBalance = await provider.getBalance(
      reentrancyContract.address
    );

    expect(formatUnits(reentrancyContractBalance)).to.be.eql("50.0");
    const attackerContractBalance = await reentrancyContract.userBalances(
      attackerContract.address
    );
    expect(formatUnits(attackerContractBalance)).to.be.eql("10.0");
    // amount of times that we can loop on the reentrancy vuln
    const limit =
      Number(formatUnits(reentrancyContractBalance)) /
      Number(formatUnits(attackerContractBalance));
    expect(limit).to.be.eql(5);
    await attackerContract.withdraw(limit - 1);
    let filter = attackerContract.filters.LogReceived();
    let events = await attackerContract.queryFilter(filter);
    expect(events.length).to.be.eql(5);
    filter = reentrancyContract.filters.LogWithdraw(
      null,
      attackerContract.address
    );
    events = await reentrancyContract.queryFilter(filter);
    expect(events.length).to.be.eql(5);
  });
});
