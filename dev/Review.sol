// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Review{
    // bikin mapping
    // mapping([data type key] => [data type value]) [nama var]
    mapping(string => uint) map;
    address owner;

    constructor() public {
        owner = msg.sender;
    }

    // bikin modifier, utk access control
    modifier onlyOwner {
        require(msg.sender == owner);
        _; // wajib diakhiri dgn ini
    }

    function baz() public onlyOwner {
        // logic baz()
    }

    function foo() public {
        // bikin variable = [data type] [nama var]
        uint num; 

        // bikin array = {data type}[{jumlah slot}] {nama var}
        uint8[5] memory arr_1 = [1, 2, 3, 4, 5]; // setelah dipakai akan hilang
        uint8[5] storage arr_2;                  // tidak akan hilang selamanya

    }
}