//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./InfinityStone.sol";
import "@openzeppelin/contracts/utils/Context.sol";

contract InfinityGauntlet is Context {
    address[] public gauntlet;

    constructor() {
        console.log("Deploying an InfinityGauntlet");
        gauntlet = [
            address(new InfinityStone("space")),
            address(new InfinityStone("reality")),
            address(new InfinityStone("power")),
            address(new InfinityStone("mind")),
            address(new InfinityStone("soul")),
            address(new InfinityStone("time"))
        ];
        assert(gauntlet.length == 6);
    }

    function addStones(string[] memory names) public {
        uint256 initialGauntletLength = gauntlet.length;
        for (uint256 i = 0; i < names.length; i++) {
            gauntlet.push(address(new InfinityStone(names[i])));
        }
        assert(gauntlet.length == initialGauntletLength + names.length);
    }

    function acquireStone(string memory _name) public payable {
        for (uint256 i = 0; i < gauntlet.length; i++) {
            InfinityStone infinityStone = InfinityStone(gauntlet[i]);
            if (strcmp(infinityStone.name(), _name)) {
                infinityStone.acquire();
                assert(infinityStone.owner() == _msgSender());
                break;
            }
        }
    }

    function giveAwayStone(string memory _name, address newOwner) public {
        for (uint256 i = 0; i < gauntlet.length; i++) {
            InfinityStone infinityStone = InfinityStone(gauntlet[i]);
            if (strcmp(infinityStone.name(), _name)) {
                infinityStone.giveAway(newOwner);
                assert(infinityStone.owner() == newOwner);
                break;
            }
        }
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
