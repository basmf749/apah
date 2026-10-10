// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title  FeeRouter
/// @notice Abstract base that stores a fee rate in basis points and exposes
///         helpers for setting it and computing the fee portion of an amount.
abstract contract FeeRouter {
    /// @dev Fee basis points (1 = 0.01%).
    uint256 public feeBps;

    /// @dev Set the fee rate. Capped at 5% (500 bps).
    function _setFeeBps(uint256 bps) internal {
        require(bps <= 500, "fee too high");
        feeBps = bps;
    }

    /// @dev Compute the fee portion of `amount` at the current rate.
    function _feeOf(uint256 amount) internal view returns (uint256) {
        return (amount * feeBps) / 10000;
    }
}
