//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./InfinityStone.sol";

contract InfinityGauntlet {
    address[] public infinityStones;

    constructor() {
        console.log("Deploying an InfinityGauntlet");
        infinityStones = [
            address(new InfinityStone("space")),
            address(new InfinityStone("reality")),
            address(new InfinityStone("power")),
            address(new InfinityStone("mind")),
            address(new InfinityStone("soul")),
            address(new InfinityStone("time"))
        ];
        assert(infinityStones.length == 6);
    }

    function getInfinityStones() external view returns (address[] memory) {
        return infinityStones;
    }

    function addInfinityStones(string[] memory names) public {
        uint256 initialGauntletLength = infinityStones.length;
        for (uint256 i = 0; i < names.length; i++) {
            infinityStones.push(address(new InfinityStone(names[i])));
        }
        assert(infinityStones.length == initialGauntletLength + names.length);
    }

    function acquireStone(string memory _name) public payable {
        for (uint256 i = 0; i < infinityStones.length; i++) {
            InfinityStone infinityStone = InfinityStone(infinityStones[i]);
            if (strcmp(infinityStone.name(), _name)) {
                infinityStone.acquire{value: msg.value}(msg.sender);
                assert(infinityStone.owner() == msg.sender);
                return;
            }
        }
        revert("Infinity stone not found");
    }

    function giveAwayStone(string memory _name, address newOwner) public {
        for (uint256 i = 0; i < infinityStones.length; i++) {
            InfinityStone infinityStone = InfinityStone(infinityStones[i]);
            if (strcmp(infinityStone.name(), _name)) {
                infinityStone.giveAway(newOwner);
                assert(infinityStone.owner() == newOwner);
                return;
            }
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
