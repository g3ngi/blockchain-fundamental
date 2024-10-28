pragma solidity ^0.8.0;


// kita library contract / "class" 
contract Test {
    // external = tidak bisa di akses secara internal, hanya bisa diacces dr luar

    // nerima semua transferan duit
    receive() external payable{} 

    // public = dapat diakses secara internal contract dan external contract
    function send(uint amount) public {
        // require() = fungsi "if" dan wajib dilakukan
        require(amount >= 1000);

        msg.sender.transfer(amount);
    }
}