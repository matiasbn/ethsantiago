pragma solidity ^0.8.17;

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

    function deposit() public payable {
        userBalances[msg.sender] += msg.value;
        emit LogDeposit(msg.value, msg.sender);
    }
}
