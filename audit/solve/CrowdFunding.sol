// arithmetic overflow / underflow
// Mitigation: Changing the solidity compiler version
pragma solidity ^0.8.0;

contract Crowdfunding {
    address public manager;
    uint256 public goal;
    uint256 public raisedAmount;
    uint256 public deadline;

    mapping(address => uint256) public contributions;

    constructor(uint256 _goal, uint256 _duration) public {
        manager = msg.sender;
        goal = _goal;
        deadline = block.timestamp + _duration; 
    }

    function contribute() public payable {
        require(block.timestamp < deadline, "Campaign has ended");
        contributions[msg.sender] += msg.value;
        raisedAmount += msg.value;
    }

    function withdrawFunds() public {
        require(block.timestamp > deadline, "Campaign still ongoing");
        require(raisedAmount >= goal, "Goal not reached");
        
        // Exploit: i could transfer the raised money from the campaign for me
        
        // Mitigation: fix the logic by changing the raisedAmount reset before the function call
        raisedAmount = 0; //reentrancy

        (bool success, ) = manager.call{value: raisedAmount}("");
        require(success, "Transfer failed");
        
    }

    function refund() public {
        uint256 amount = contributions[msg.sender];
        require(amount > 0, "No contributions to refund");

        contributions[msg.sender] = 0;

        (bool success, ) = msg.sender.call{value: amount}("");// Refund
        require(success, "Refund failed")
    }

    function changeDeadline(uint256 _newDeadline) public {
        // Exploit: i could change the deadline even im a user privilege
        
        // Mitigation:
        require(msg.sender == manager, "You're not the manager");
        deadline = _newDeadline; // incorrect access control
    }

    function calculateReward(uint256 _amount) public view returns (uint256) {
        // Exploit: i could fake the reward by making the value minus
        uint256 reward = _amount * 10**18 / raisedAmount; // arithmetic overflow / underflow
        return reward;
    }
}
