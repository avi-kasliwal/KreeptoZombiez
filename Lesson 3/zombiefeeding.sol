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

    function setKittyContractAddress(address _address) external onlyOwner {
        kittyContract = KittyInterface(_address);
    }

    function feedAndMultiply(
        uint256 _zombieId,
        uint256 _targetDna,
        string memory _species
    ) public view {
        // To make sure that ownly the right owner can feed their zombie.
        require(msg.sender == zombieToOwner[_zombieId]);

        // Pointer to owner's zombie.
        Zombie storage myZombie = zombies[_zombieId];

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
    }

    function feedOnKitty(uint256 _zombieId, uint256 _kittyId) public {
        uint256 kittyDna;
        (, , , , , , , , , kittyDna) = kittyContract.getKitty(_kittyId);

        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }
}
