// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./zombiehelper.sol";

contract ZombieAttack is ZombieHelper {
    uint256 randNonce = 0;

    // attackVictoryProbability
    uint256 attackVictoryProbability = 70;

    function randMod(uint256 _modulus) internal returns (uint256) {
        randNonce++;
        return
            uint256(keccak256(abi.encodePacked(now, msg.sender, randNonce))) %
            _modulus;
    }

    function attack(uint256 _zombieId, uint256 _targetId) external {}
}