
// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract Lottery {
    address public owner;
    address[] public participants;
    uint256 public ticketPrice;
    uint256 public prizePool;

    constructor(uint256 _ticketPrice) {
        owner = msg.sender;
        ticketPrice = _ticketPrice;
    }

    function buyTicket() public payable {
        require(msg.value == ticketPrice, "Incorrect ticket price");
        participants.push(msg.sender);
        prizePool += msg.value;
    }

    function drawWinner() public {
        require(msg.sender == owner, "Only the owner can draw a winner");
        require(participants.length > 0, "No participants");

        // Insecure randomness
        uint256 randomIndex = uint256(blockhash(block.number - 1)) % participants.length;
        address winner = participants[randomIndex];

        // reentrancy = any user could win if they call drawWinner and repeats it
        // mitigation:
        
        delete participants; 
        prizePool = 0;

        // unchecked external call
        // mitigation:
        (bool success, ) = winner.call{value: prizePool}(""); // Send prize
        require(success, "Sending prize failed");
        
    }

    function setTicketPrice(uint256 _newPrice) public {
        // incorrect access control = any user could update the ticket price
        require(msg.sender == owner, "Only owner could update the ticket price");
        ticketPrice = _newPrice; // No access control
    }
}
