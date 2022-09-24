pragma solidity ^0.8.17;

contract RateLimits {
    uint internal period; // how many blocks before limit resets
    uint internal limit; // max ether to withdraw per period
    uint internal currentPeriodEnd; // block which the current period ends at
    uint internal currentPeriodAmount; // amount already withdrawn this period

    constructor(uint _period, uint _limit) public {
        period = _period;
        limit = _limit;

        currentPeriodEnd = block.number + period;
    }

    function withdraw(uint amount) public {
        // Update period before proceeding
        updatePeriod();

        // Prevent overflow
        uint totalAmount = currentPeriodAmount + amount;
        require(totalAmount >= currentPeriodAmount, "overflow");

        // Disallow withdraws that exceed current rate limit
        require(currentPeriodAmount + amount < limit, "exceeds period limit");
        currentPeriodAmount += amount;
        msg.sender.transfer(amount);
    }

    function updatePeriod() internal {
        if (currentPeriodEnd < block.number) {
            currentPeriodEnd = block.number + period;
            currentPeriodAmount = 0;
        }
    }
}
