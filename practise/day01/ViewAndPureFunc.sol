// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ViewAndPureFunctions {
    uint public num;

    function viewFunc() external view returns (uint) {
        return num;
    }

    function pureFunc() external pure returns (uint) {
        return 1;
    }

    function addToNum(uint x) external view returns (uint) {
        return num + x;
        //读取了状态变量，所以用view
    }

    function add(uint x, uint y) external pure returns (uint) {
        return x + y;
    }
}