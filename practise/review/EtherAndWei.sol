// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


contract EtherUnits {
    //1eth = 10 ** 18 wei. wei是以太坊上的Gas的最小单位
    uint public oneWei = 1 wei;

    bool public isOneWei = (1 wei == 1);


    uint public oneEther = 1 ether;

    bool public isOneEther = (1 ether == 10**18 wei);
}