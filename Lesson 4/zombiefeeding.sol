// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./zombiefactory.sol";

// Interface to connect ot cryptoKitties to read cryptoKittie's dna
contract KittyInterface {
    function getKitty(uint256 _id)
        external
        view
        returns (
            bool isGestating,
            bool isReady,
            uint256 cooldownIndex,
            uint256 nextActionAt,
            uint256 siringWithId,
            uint256 birthTime,
            uint256 matronId,
            uint256 sireId,
            uint256 generation,
            uint256 genes
        );
}

// ZombieFeeding inherits ZombieFactory
contract ZombieFeeding is ZombieFactory {
    KittyInterface kittyContract;

    modifier ownerOf(uint256 _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        _;
    }

    function setKittyContractAddress(address _address) external onlyOwner {
        kittyContract = KittyInterface(_address);
    }

    // `_triggerCooldown` function
    function _triggerCooldown(Zombie storage _zombie) internal {
        _zombie.readyTime = uint32(block.timestamp + cooldownTime);
    }

    // 2. Define `_isReady` function here
    function _isReady(Zombie storage _zombie) internal view returns (bool) {
        return (_zombie.readyTime <= block.timestamp);
    }

    function feedAndMultiply(
        uint256 _zombieId,
        uint256 _targetDna,
        string memory _species
    ) internal ownerOf(_zombieId) {
        // Pointer to owner's zombie.
        Zombie storage myZombie = zombies[_zombieId];

        // Checking if it has cooldown or not
        require(_isReady(myZombie));

        _targetDna = _targetDna % dnaModulus;
        uint256 newDna = (myZombie.dna + _targetDna) / 2;

        // if zombies eats kitty we add special change to its dna -> last 2 digits = 99
        if (
            keccak256(abi.encodePacked(_species)) ==
            keccak256(abi.encodePacked("kitty"))
        ) {
            newDna = newDna - (newDna % 100) + 99;
        }

        _createZombie("No Name", newDna);

        // Give it a cooldown for 1 day.
        _triggerCooldown(myZombie);
    }

    function feedOnKitty(uint256 _zombieId, uint256 _kittyId) public {
        uint256 kittyDna;
        (, , , , , , , , , kittyDna) = kittyContract.getKitty(_kittyId);

        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }
}
