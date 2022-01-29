# Lesson 1

- Goal is to create a Zombie Factory to build an army of Zombies !

- Roles of the factory :

  - Act as a database for all the zombies creaed from our factory.
  - Create a new zombie with random and unique apperance.

- Zombie DNA : 16 Digit integer. Different parts of this number would give values to different characteristics of the zombies.

- Contracts : Fundamental building blocks of ETH application.

- Version Pragma : All solidity codes start with ther version pragma, which decalres the version of the Sol compiler the code should use.

- State Variables : permanently stored in contract storage, i.e. written to ETH block chain.

- Solidity Provides us Structs to create more complex dtypes from the ones that it provides us

- Arrays :

  - Fixed array : uint[2] fixedArray;
  - Dynamic array : uint[] dynamicArray;
  - Public array : uint[2] public publicFixedArray;

- If function parameter contain array, struct, string, mappings then they should have memory keyword for those parameters.

- Private functions only accessbile inside our contract.

  - Convention is to use underscore in names of private function

- Function Modifiers

  - view : when only viewing data and not writing to it
  - pure : neither write nor read any data;

- Keccak256

  - hash function, a version of SHA3
  - gives a 256-bit hexadecimal number
  - takes 1 parameter of type bytes, so we need to use abi.encodePacked ()

- Events are a way for your contract to communicate that something happened on the blockchain to your app front-end, which can be 'listening' for certain events and take action when they happen.
  - bavkedn to frontend communication.

# Lesson 2

- Goal is to make the app more game-like, add multi player functionality to it. Also make a fun way of creating zombies instead of creating them randomly.
