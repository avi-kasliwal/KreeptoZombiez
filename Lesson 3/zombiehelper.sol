// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {
    modifier aboveLevel(uint256 _level, uint256 _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _; // calls the reset of the function
    }

    // calldata is somehow similar to memory, but it's only available to external functions.
    // Change name if lvl > 1
    function changeName(uint256 _zombieId, string calldata _newName)
        external
        aboveLevel(2, _zombieId)
    {
        require(msg.sender == zombieToOwner[_zombieId]);

        zombies[_zombieId].name = _newName;
    }

    // Change DNA if lvl > 20
    function changeDna(uint256 _zombieId, uint256 _newDna)
        external
        aboveLevel(20, _zombieId)
    {
        require(msg.sender == zombieToOwner[_zombieId]);

        zombies[_zombieId].dna = _newDna;
    }

    // Get Zombies for an account
    function getZombiesByOwner(address _owner)
        external
        view
        returns (uint256[] memory)
    {
        uint256[] memory result = new uint256[](ownerZombieCount[_owner]);
        return result;
    }
}
