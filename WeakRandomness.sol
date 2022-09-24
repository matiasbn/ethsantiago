// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

contract WeakRandomness {
    function randomNumber() internal view returns (uint) {
        return uint(blockhash(block.number - 1));
    }
}
