pragma solidity ^0.8.17;

contract SpeedBumps {
    struct RequestedWithdrawal {
        uint amount;
        uint time;
    }

    mapping(address => uint) private balances;
    mapping(address => RequestedWithdrawal) private requestedWithdrawals;
    uint constant withdrawalWaitPeriod = 28 days; // 4 weeks

    function requestWithdrawal() public {
        if (balances[msg.sender] > 0) {
            uint amountToWithdraw = balances[msg.sender];
            balances[msg.sender] = 0;

            requestedWithdrawals[msg.sender] = RequestedWithdrawal({
                amount: amountToWithdraw,
                time: block.timestamp
            });
        }
    }

    function withdraw() public {
        if (
            requestedWithdrawals[msg.sender].amount > 0 &&
            block.timestamp >
            requestedWithdrawals[msg.sender].time + withdrawalWaitPeriod
        ) {
            uint amountToWithdraw = requestedWithdrawals[msg.sender].amount;
            requestedWithdrawals[msg.sender].amount = 0;

            require(msg.sender.send(amountToWithdraw));
        }
    }
}
