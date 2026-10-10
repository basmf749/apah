// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title  Ledger
/// @notice Track per-depositor balances and the total deposited supply. Deposit
///         credits a depositor and grows the supply; withdrawal debits the
///         depositor and shrinks the supply. Proportional entitlements
///         (revenue splits, share payouts) should be computed against
///         `totalSupply` so they stay correct as the pool grows and shrinks.
library Ledger {
    struct Data {
        mapping(address => uint256) balanceOf;
        uint256 totalSupply;
    }

    /// @dev Credit `who` with `amount` and grow the tracked supply.
    function deposit(Data storage self, address who, uint256 amount) internal {
        self.balanceOf[who] += amount;
        self.totalSupply += amount;
    }

    /// @dev Debit `who` with `amount` and shrink the tracked supply.
    function withdraw(Data storage self, address who, uint256 amount) internal {
        require(self.balanceOf[who] >= amount, "insufficient balance");
        self.balanceOf[who] -= amount;
    }

    /// @dev Share of `totalSupply` attributable to `who`, scaled by `scale`.
    function shareOf(Data storage self, address who, uint256 scale)
        internal
        view
        returns (uint256)
    {
        if (self.totalSupply == 0) return 0;
        return (self.balanceOf[who] * scale) / self.totalSupply;
    }
}
