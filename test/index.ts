import { expect } from "chai";
import { ethers } from "hardhat";

describe("InfinityGauntlet", function () {
  it("Should have six infinity stones on deploy", async function () {
    const InfinityGauntlet = await ethers.getContractFactory(
      "InfinityGauntlet"
    );
    const infinityGauntlet = await InfinityGauntlet.deploy();
    await infinityGauntlet.deployed();

    expect((await infinityGauntlet.getInfinityStones()).length).to.equal(6);
  });
});
