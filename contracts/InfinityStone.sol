//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract InfinityStone {
    string public name;
    address public owner;
    enum State {
        ACQUIRED,
        UNTAKEN
    }
    State public state;

    constructor(string memory _name) {
        name = _name;
        owner = msg.sender;
        state = State.UNTAKEN;
        console.log(
            "Deployed an InfinityStone with name:",
            _name,
            "| Owner:",
            owner
        );
    }

    function acquire(address newOwner) external payable {
        require(
            state == State.UNTAKEN,
            "Stone can be acquired only if its state is UNTAKEN"
        );
        require(msg.value >= 0.01 ether, "Minimum price is 0.01 ether");
        owner = newOwner;
        state = State.ACQUIRED;
        console.log("InfinityStone with name:", name, "acquired by:", newOwner);
    }

    function giveAway(address newOwner) public {
        require(
            state == State.ACQUIRED,
            "Stone can be given away only if its state is ACQUIRED"
        );
        require(owner == msg.sender, "Stone can be given away only by its owner");
        owner = newOwner;
        console.log(
            "InfinityStone with name:",
            name,
            "given away to:",
            newOwner
        );
    }
}
