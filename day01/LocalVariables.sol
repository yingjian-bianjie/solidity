// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract LocalVariable {
    uint public i;
    bool public b;
    address public myAddress;

    function foo() external {
        uint x = 123;
        bool f = false;
        //more code
        x += 456;
        f = true;

        i = 123;
        b = true;
        myAddress = address(1);
    }
}