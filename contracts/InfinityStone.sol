//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract InfinityStone is Ownable {
    string public name;
    string public color;
    enum State {
        ACQUIRED,
        UNTAKEN
    }
    State public state;

    constructor(string memory _name) {
        console.log("Deploying an InfinityStone with name:", _name);
        name = _name;
        state = State.UNTAKEN;
    }

    function acquire() external payable {
        require(
            state == State.UNTAKEN,
            "Stone can be acquired only if its state is UNTAKEN"
        );
        require(msg.value < 0.01 ether, "Minimum price is 0.01 ether");
        address newOwner = _msgSender();
        transferOwnership(newOwner);
        assert(owner() == newOwner);
        state = State.ACQUIRED;
    }

    function giveAway(address newOwner) public onlyOwner {
        transferOwnership(newOwner);
        assert(owner() == newOwner);
    }
}
