pragma solidity ^0.8.0;

contract VulnerableLottery {
    address public admin;
    address[] public players;
    uint256 public ticketPrice;
    uint256 public randomNumber;
    bool public lotteryEnded;

    constructor(uint256 _ticketPrice) {
        admin = msg.sender;
        ticketPrice = _ticketPrice;
    }

    function buyTicket() public payable {
        require(msg.value == ticketPrice, "Incorrect ticket price");
        players.push(msg.sender);
    }

    function endLottery() public {

        require(!lotteryEnded, "Lottery already ended");
        lotteryEnded = true;

        randomNumber = uint256(blockhash(block.number - 1)) % players.length;
        address winner = players[randomNumber];


        (bool success, ) = winner.call{value: address(this).balance}("");
        require(success, "Transfer failed");
    }

    function resetLottery() public {

        require(msg.sender == admin, "Only admin can reset");
        delete players;
        lotteryEnded = false;
    }
}
