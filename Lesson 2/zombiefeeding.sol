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
    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    KittyInterface kittyContract = KittyInterface(ckAddress);

    function feedAndMultiply(uint256 _zombieId, uint256 _targetDna)
        public
        view
    {
        // To make sure that ownly the right owner can feed their zombie.
        require(msg.sender == zombieToOwner[_zombieId]);

        // Pointer to owner's zombie.
        Zombie storage myZombie = zombies[_zombieId];

        _targetDna = _targetDna % dnaModulus;
        uint256 newDna = (myZombie.dna + _targetDna) / 2;

        _createZombie("No Name", newDna);
    }

    function feedOnKitty(uint256 _zombieId, uint256 _kittyId) public {
        uint256 kittyDna;
        (, , , , , , , , , kittyDna) = kittyContract.getKitty(_kittyId);

        feedAndMultiply(_zombieId, kittyDna);
    }
}
