pragma solidity ^0.8.17;

// Address: 0xDAFEA492D9c6733ae3d56b7Ed1ADB60692c98Bc5

contract Reentrancy {

    event LogDeposit(uint256 amount, address indexed sender);
    event LogWithdraw(uint256 amount, address indexed sender);

    mapping(address => uint256) private userBalances;

    function withdrawBalance() public {
        uint256 amountToWithdraw = userBalances[msg.sender];
        (bool success, ) = msg.sender.call{value: amountToWithdraw}("");
        require(success);
        userBalances[msg.sender] = 0;
        emit LogWithdraw(amountToWithdraw, msg.sender);
    }

    function deposit() payable public {
        userBalances[msg.sender] += msg.value;
        emit LogDeposit(msg.value, msg.sender);
    }
}
