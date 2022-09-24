pragma solidity ^0.8.17;

contract CircuitBreakers {
    bool private stopped = false;
    address private owner;

    modifier isAdmin() {
        require(msg.sender == owner);
        _;
    }

    function toggleContractActive() public isAdmin {
        stopped = !stopped;
    }

    modifier stopInEmergency() {
        if (!stopped) _;
    }
    modifier onlyInEmergency() {
        if (stopped) _;
    }

    function deposit() public stopInEmergency {
        // some code
    }

    function withdraw() public onlyInEmergency {
        // some code
    }
}
