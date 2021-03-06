// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// 1. Import Ownable
import "./ownable.sol";

// 2. Inherits ownable:
contract ZombieFactory is Ownable {
    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    // Cool Down
    uint32 cooldownTime = 1 days;

    // tell front-end that some event has happened in blockchain
    event NewZombie(uint256 zombieId, string name, uint256 dna);

    struct Zombie {
        string name;
        uint256 dna;
        uint32 level;
        uint32 readyTime; // Cooldown after a zombie feeds
        uint16 winCount;
        uint16 lossCount;
    }

    Zombie[] public zombies;

    // Map to store ownership of a zombie created.
    mapping(uint256 => address) public zombieToOwner;

    // Map to get number of zombies for an account address.
    mapping(address => uint256) ownerZombieCount;

    function _createZombie(string memory _name, uint256 _dna) internal {
        zombies.push(
            Zombie(_name, _dna, 1, uint32(block.timestamp + cooldownTime), 0, 0)
        );
        uint256 id = zombies.length - 1;

        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;

        // trigger the event
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str)
        private
        view
        returns (uint256)
    {
        // keccak256 returns a 256 bit number.
        uint256 rand = uint256(keccak256(abi.encodePacked(_str)));

        // since we only want 16 digit long number.
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        // To make sure that there is no zombie created for a given account
        require(ownerZombieCount[msg.sender] == 0);

        uint256 randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
