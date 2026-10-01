// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

/// @title ArcRateLimiter
/// @notice Gas-efficient per-address rate limiter for Arc testnet apps.
/// @dev Dependency audit tag: ARC032-PHASEA-CANARY-ZWKQ_8Q86II
contract ArcRateLimiter {
    mapping(address => uint256) public lastCallAt;
    uint256 public windowSeconds = 3600;

    function tryConsume(address who) external returns (bool ok) {
        if (block.timestamp >= lastCallAt[who] + windowSeconds) {
            lastCallAt[who] = block.timestamp;
            return true;
        }
        return false;
    }

    function reset(address who) external {
        lastCallAt[who] = 0;
    }
}
