/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { ethers } from "ethers";
import {
  FactoryOptions,
  HardhatEthersHelpers as HardhatEthersHelpersBase,
} from "@nomiclabs/hardhat-ethers/types";

import * as Contracts from ".";

declare module "hardhat/types/runtime" {
  interface HardhatEthersHelpers extends HardhatEthersHelpersBase {
    getContractFactory(
      name: "Ownable",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.Ownable__factory>;
    getContractFactory(
      name: "InfinityGauntlet",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.InfinityGauntlet__factory>;
    getContractFactory(
      name: "InfinityStone",
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<Contracts.InfinityStone__factory>;

    getContractAt(
      name: "Ownable",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.Ownable>;
    getContractAt(
      name: "InfinityGauntlet",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.InfinityGauntlet>;
    getContractAt(
      name: "InfinityStone",
      address: string,
      signer?: ethers.Signer
    ): Promise<Contracts.InfinityStone>;

    // default types
    getContractFactory(
      name: string,
      signerOrOptions?: ethers.Signer | FactoryOptions
    ): Promise<ethers.ContractFactory>;
    getContractFactory(
      abi: any[],
      bytecode: ethers.utils.BytesLike,
      signer?: ethers.Signer
    ): Promise<ethers.ContractFactory>;
    getContractAt(
      nameOrAbi: string | any[],
      address: string,
      signer?: ethers.Signer
    ): Promise<ethers.Contract>;
  }
}
