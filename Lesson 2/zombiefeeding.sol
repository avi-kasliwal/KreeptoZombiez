// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./zombiefactory.sol";

// ZombieFeeding inherits ZombieFactory
contract ZombieFeeding is ZombieFactory {
    function feedAndMultiply(uint256 _zombieId, uint256 _targetDna)
        public
        view
    {
        // To make sure that ownly the right owner can feed their zombie.
        require(msg.sender == zombieToOwner[_zombieId]);

        // Pointer to owner's zombie.
        Zombie storage myZombie = zombies[_zombieId];
    }
}
