// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/Test.sol";
import "../src/CryptoBank.sol";

contract CryptoBankTest is Test {
    CryptoBank bank;
    address admin = makeAddr("admin");
    address user = makeAddr("user");

    function setUp() public {
        bank = new CryptoBank(10 ether, admin);
        vm.deal(user, 20 ether);
    }

    function testDeposit() public {
        vm.prank(user);
        bank.depositEther{value: 1 ether}();
        assertEq(bank.userBalance(user), 1 ether);
    }

    function testRevertIfExceedsMax() public {
        vm.prank(user);
        vm.expectRevert(CryptoBank.MaxBalanceReached.selector);
        bank.depositEther{value: 11 ether}();
    }

    function testWithdraw() public {
        vm.prank(user);
        bank.depositEther{value: 5 ether}();
        vm.prank(user);
        bank.withdrawEther(2 ether);
        assertEq(bank.userBalance(user), 3 ether);
    }

    function testOnlyAdminCanModify() public {
        vm.prank(user);
        vm.expectRevert(CryptoBank.NotAdmin.selector);
        bank.modifyMaxBalance(20 ether);
    }
}