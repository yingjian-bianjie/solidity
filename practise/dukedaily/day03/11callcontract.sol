/**
普通的交易，相当于在世界状态中修改原有的账户数据，更新到新状态。
一共有三种方式调用合约：
    1.使用合约实例调用合约（常规）：A.foo(argument)
    2.使用call调用合约: A.call(calldata)
    3.使用delegate调用合约：A.delegatecall(calldata)
*/

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.13;

contract Callee {
    uint public x;
    uint public value;

    function setX(uint _x) public returns (uint) {
        x = _x;
        return x;
    }

    function setXandSendEther() public payable returns (uint, uint) {
        x = _x;
        value = msg.value;

        return (x, value);
    }
}

contract Caller {
    // 直接在参数中进行实例化合约
    function setX(Callee _callee, uint _x) public {
        uint x = _callee.setX(_x);
    }

    // 传递地址，在内部实例化callee合约
    function setXFromAddress(address _addr, uint _x) public {
        Callee callee = Callee(_addr);
        callee.setX(_x);
    }

    // 调用方法，并转ether
    function setXandSendEther(Callee _callee, uint _x) public payable {
        (uint x, uint value) = _callee.setXandSendEther{value: msg.value}(_x);
    }
}