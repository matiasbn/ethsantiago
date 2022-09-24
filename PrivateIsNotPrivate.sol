// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract PrivateIsNotPrivate {
    uint256 private info;

    function setInfo(uint256 _info) public {
        info = _info;
    }
}
