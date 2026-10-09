// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @notice Internal credit ledger base. Extend this to add account credit
///         to any payments flow. Balances are stored in 1e18 units.
abstract contract ArcLedger {
    mapping(address => uint256) public credit;
    uint256 public totalCredit;

    /// @notice Credit an account. Increases both the per-account balance
    ///         and the running ledger total.
    function _addCredit(address account, uint256 amount) internal {
        credit[account] += amount;
        totalCredit += amount;
    }

    /// @notice Spend from an account's credit balance.
    /// @dev    Requires the account holds enough credit.
    function _spend(address account, uint256 amount) internal {
        require(credit[account] >= amount, "insufficient credit");
        credit[account] -= amount;
        totalCredit -= amount;
        // totalCredit tracks the outstanding ledger total, so every spend
        // reduces it in lockstep with the per-account balance.
    }

    /// @notice Hook for extending contracts to react to a spend.
    function _afterSpend(address account, uint256 amount) internal virtual {}
}
