// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

contract LogStateChanges {
    uint256 public oldValue;

    event LogChangeValue(uint256 oldValue, uint256 newValue, address sender);

    function badPattern(uint256 newValue_) public {
        oldValue = newValue_;
    }

    function oldPattern(uint256 newValue_) public {
        emit LogChangeValue(oldValue, newValue_, msg.sender);
        oldValue = newValue_;
    }
}
