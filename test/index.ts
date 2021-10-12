import { expect } from "chai";
import { ethers } from "hardhat";
import type { Signer } from "ethers";
import { InfinityGauntlet } from "../typechain";

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
    expect((await infinityGauntlet.getInfinityStones()).length).to.equal(6);
  });

  it("Should be possible to add new infinity stones", async function () {
    const tx = await infinityGauntlet
      .connect(signers[0])
      .addInfinityStones(["water", "fire"]);
    await tx.wait();
    expect((await infinityGauntlet.getInfinityStones()).length).to.equal(8);
  });

  it("Should be possible to aquire an infinity stone", async function () {
    const tx = await infinityGauntlet
      .connect(signers[1])
      .acquireStone("space", {
        value: ethers.utils.parseEther("0.01"),
      });
    await tx.wait();
  });

  it("Should be possible to give away an infinity stone", async function () {
    const InfinityStone = await ethers.getContractFactory("InfinityStone");
    const infinityStone = InfinityStone.attach(
      await infinityGauntlet.infinityStones(0)
    );
    const tx = await infinityStone
      .connect(signers[1])
      .giveAway(await signers[2].getAddress());
    await tx.wait();
  });
});
