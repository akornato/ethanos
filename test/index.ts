import { expect } from "chai";
import { ethers, waffle } from "hardhat";
import type { Signer } from "ethers";
import { InfinityGauntlet } from "../typechain";

const provider = waffle.provider;

const zero = ethers.constants.AddressZero;

describe("InfinityGauntlet", function () {
  let infinityGauntlet: InfinityGauntlet;
  let signers: Signer[];

  before(async function () {
    const InfinityGauntlet = await ethers.getContractFactory(
      "InfinityGauntlet"
    );
    infinityGauntlet = await InfinityGauntlet.deploy();
    await infinityGauntlet.deployed();
    signers = await ethers.getSigners();
  });

  it("Should have six infinity stones on deploy", async function () {
    expect(await infinityGauntlet.infinityStones("space")).to.not.equal(zero);
    expect(await infinityGauntlet.infinityStones("reality")).to.not.equal(zero);
    expect(await infinityGauntlet.infinityStones("power")).to.not.equal(zero);
    expect(await infinityGauntlet.infinityStones("mind")).to.not.equal(zero);
    expect(await infinityGauntlet.infinityStones("soul")).to.not.equal(zero);
    expect(await infinityGauntlet.infinityStones("time")).to.not.equal(zero);
  });

  it("Should not have water and fire stones yet", async function () {
    expect(await infinityGauntlet.infinityStones("water")).to.equal(zero);
    expect(await infinityGauntlet.infinityStones("fire")).to.equal(zero);
  });

  it("Should be possible to add new infinity stones", async function () {
    const tx = await infinityGauntlet
      .connect(signers[0])
      .addInfinityStones(["water", "fire"]);
    await tx.wait();
    expect(await infinityGauntlet.infinityStones("water")).to.not.equal(zero);
    expect(await infinityGauntlet.infinityStones("fire")).to.not.equal(zero);
  });

  it("Should be possible to aquire an infinity stone", async function () {
    const tx = await infinityGauntlet
      .connect(signers[1])
      .acquireStone("space", {
        value: ethers.utils.parseEther("0.01"),
      });
    await tx.wait();
    const InfinityStone = await ethers.getContractFactory("InfinityStone");
    const infinityStoneAddress = await infinityGauntlet.infinityStones("space");
    const infinityStone = InfinityStone.attach(infinityStoneAddress);
    expect(await infinityStone.owner()).to.equal(await signers[1].getAddress());
    expect(await provider.getBalance(infinityStoneAddress)).to.equal(
      ethers.utils.parseEther("0.01")
    );
  });

  it("Should revert on stone not found", async function () {
    await expect(
      infinityGauntlet.connect(signers[1]).acquireStone("doesn't exist", {
        value: ethers.utils.parseEther("0.01"),
      })
    ).to.be.revertedWith("Infinity stone not found");
  });

  it("Should be possible to give away an infinity stone", async function () {
    const InfinityStone = await ethers.getContractFactory("InfinityStone");
    const infinityStone = InfinityStone.attach(
      await infinityGauntlet.infinityStones("space")
    );
    const tx = await infinityStone
      .connect(signers[1])
      .giveAway(await signers[2].getAddress());
    await tx.wait();
    expect(await infinityStone.owner()).to.equal(await signers[2].getAddress());
  });
});
