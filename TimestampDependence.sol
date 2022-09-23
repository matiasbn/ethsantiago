// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

contract TimestampDependence {
    uint256 private constant salt = block.timestamp;

    function random(uint Max) public returns (uint256 result) {
        //get the best seed for randomness
        uint256 x = (salt * 100) / Max;
        uint256 y = (salt * block.number) / (salt % 5);
        uint256 seed = block.number / 3 + (salt % 300) + Last_Payout + y;
        uint256 h = uint256(block.blockhash(seed));

        return (uint256((h / x)) % Max) + 1; //random number between 1 and Max
    }
}
