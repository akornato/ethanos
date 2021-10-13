//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./InfinityStone.sol";

contract InfinityGauntlet {
    mapping(string => address) public infinityStones;

    constructor() {
        console.log("Deploying an InfinityGauntlet");
        infinityStones["space"] = address(new InfinityStone("space"));
        infinityStones["reality"] = address(new InfinityStone("reality"));
        infinityStones["power"] = address(new InfinityStone("power"));
        infinityStones["mind"] = address(new InfinityStone("mind"));
        infinityStones["soul"] = address(new InfinityStone("soul"));
        infinityStones["time"] = address(new InfinityStone("time"));
    }

    function addInfinityStones(string[] memory names) public {
        for (uint256 i = 0; i < names.length; i++) {
            infinityStones[names[i]] = address(new InfinityStone(names[i]));
        }
    }

    function acquireStone(string memory _name) public payable {
        address infinityStoneAddress = infinityStones[_name];
        if (infinityStoneAddress != address(0)) {
            InfinityStone infinityStone = InfinityStone(infinityStoneAddress);
            infinityStone.acquire{value: msg.value}(msg.sender);
            assert(infinityStone.owner() == msg.sender);
            return;
        }
        revert("Infinity stone not found");
    }

    function giveAwayStone(string memory _name, address newOwner) public {
        address infinityStoneAddress = infinityStones[_name];
        if (infinityStoneAddress != address(0)) {
            InfinityStone infinityStone = InfinityStone(infinityStoneAddress);
            infinityStone.giveAway(newOwner);
            assert(infinityStone.owner() == newOwner);
            return;
        }
        revert("Infinity stone not found");
    }

    function memcmp(bytes memory a, bytes memory b)
        internal
        pure
        returns (bool)
    {
        return (a.length == b.length) && (keccak256(a) == keccak256(b));
    }

    function strcmp(string memory a, string memory b)
        internal
        pure
        returns (bool)
    {
        return memcmp(bytes(a), bytes(b));
    }
}
