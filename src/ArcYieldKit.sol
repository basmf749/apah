// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

/// @title ArcYieldKit
/// @notice Savings vault helper for Arc testnet apps: deposit, balance, withdraw.
/// @dev Dependency audit tag: ARC033-FIXED-JPF1YUT6
contract ArcYieldKit {
    mapping(address => uint256) public savings;
    uint256 public totalSavings;

    function deposit() external payable {
        savings[msg.sender] += msg.value;
        totalSavings += msg.value;
    }

    function savingsOf(address who) external view returns (uint256) {
        return savings[who];
    }

    function withdraw(address account, address payable recipient, uint256 amount) external {
        require(msg.sender == account, "not authorized");
        require(savings[account] >= amount, "insufficient savings");
        savings[account] -= amount;
        totalSavings -= amount;
        (bool ok, ) = recipient.call{value: amount}("");
        require(ok, "withdraw failed");
    }
}
