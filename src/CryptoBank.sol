// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CryptoBank {
    uint256 public maxBalance;
    address public admin;
    mapping(address => uint256) public userBalance;

    error NotAdmin();
    error MaxBalanceReached();
    error NotEnoughBalance();
    error TransferFailed();

    event EtherDeposit(address indexed user_, uint256 etheramount_);
    event EtherWithdraw(address indexed user_, uint256 etheramount_);
    event MaxBalanceUpdated(uint256 newMax_);

    modifier onlyAdmin() {
        if (msg.sender != admin) revert NotAdmin();
        _;
    }

    constructor(uint256 maxBalance_, address admin_) {
        maxBalance = maxBalance_;
        admin = admin_;
    }

    function depositEther() external payable {
        if (userBalance[msg.sender] + msg.value > maxBalance) revert MaxBalanceReached();
        userBalance[msg.sender] += msg.value;
        emit EtherDeposit(msg.sender, msg.value);
    }

    function withdrawEther(uint256 amount_) external {
        if (amount_ > userBalance[msg.sender]) revert NotEnoughBalance();
        userBalance[msg.sender] -= amount_;
        (bool success,) = payable(msg.sender).call{value: amount_}("");
        if (!success) revert TransferFailed();
        emit EtherWithdraw(msg.sender, amount_);
    }

    function modifyMaxBalance(uint256 newMaxBalance_) external onlyAdmin {
        maxBalance = newMaxBalance_;
        emit MaxBalanceUpdated(newMaxBalance_);
    }

    receive() external payable {
        // Evitar envíos directos sin control
        revert MaxBalanceReached();
    }
}