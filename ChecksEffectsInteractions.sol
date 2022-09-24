pragma solidity ^0.8.17;

contract ChecksEffectsInteractions {
    event LogDeposit(uint256 amount, address indexed sender);
    event LogWithdraw(uint256 amount, address indexed sender);

    mapping(address => uint256) public userBalances;

    function withdrawBalanceBad() public {
        uint256 amountToWithdraw = userBalances[msg.sender];
        (bool success, ) = msg.sender.call{value: amountToWithdraw}("");
        require(success, "transfer failed");
        userBalances[msg.sender] = 0;
        emit LogWithdraw(amountToWithdraw, msg.sender);
    }

    function withdrawBalanceGood() public {
        uint256 amountToWithdraw = userBalances[msg.sender];
        userBalances[msg.sender] = 0;
        emit LogWithdraw(amountToWithdraw, msg.sender);
        (bool success, ) = msg.sender.call{value: amountToWithdraw}("");
        require(success, "transfer failed");
    }

    function deposit() public payable {
        userBalances[msg.sender] += msg.value;
        emit LogDeposit(msg.value, msg.sender);
    }

    receive() external payable {}
}
