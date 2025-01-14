
// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

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

        uint256 randomIndex = uint256(blockhash(block.number - 1)) % participants.length;
        address winner = participants[randomIndex];

        // Uncheck external call
        winner.call{value: prizePool}(""); // Send prize
        

        // Reset for next round
        delete participants;
        prizePool = 0;
    }

    function setTicketPrice(uint256 _newPrice) public {
        ticketPrice = _newPrice; // No access control
    }
}
