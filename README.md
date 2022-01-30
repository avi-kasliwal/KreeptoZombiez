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

- msg.sender

  - Global variable, available to all functions
  - address of the person or contract who called the current function.
  - _Note_: In Solidity, function execution always needs to start with an external caller. A contract will just sit on the blockchain doing nothing until someone calls one of its functions. So there will always be a msg.sender

- Storage Vs Memory

  - Storage refers to variables stored permanently on the blockchain. Memory variables are temporary, and are erased between external function calls to your contract. Think of it like your computer's hard disk vs RAM.
  - Storage -> pointer to that address
  - Memory -> creates a copy.

- Function Visibility

  - Public
  - Private
  - Internal : Similar as private but also accesible to contracts that inherit it.
  - External : Similar as Public but can only be called from outside the contract - i.e. cannot be called from functions inside the contract.

- For our contract to talk to another contract on the blockchain that we don't own, first we need to define an interface.
  - Can communicate with public and external funcions from the contracts owned by others.

# Lesson 3

- Goal is to update out code so that key portions of the app can be updated via some functions as the contract is immutable.

- Ownable : make contract ownable so that only we can call functions to update key parts of the contract. In this tutorial we are doing so using Oqnable contract from OpenZeppelin library. This contract allows :

  - set owner to msg.sender with the help of the custroctor
  - adds onlyOwner modifier, which restricts certain functions to only the owner
  - allows to transfer ownership.

- constructor : special function that exectues only once, at the time of contract creation.

- Modifiers : These are like half-functions and are used to modify other functions, usually used to check some requirements prior to function execution.

- [Understand the working of onlyOwner modifier](https://cryptozombies.io/en/lesson/3/chapter/3)

- In Solidity, your users have to pay every time they execute a function on your DApp using a currency called gas. Users buy gas with Ether (the currency on Ethereum), so your users have to spend ETH in order to execute functions on your DApp.

- Solidity reserves 256 bits of storage regardless of the uint size. For example, using uint8 instead of uint (uint256) won't save you any gas.

  - But there's an exception to this: inside structs.
  - cluster identical data types together (i.e. put them next to each other in the struct) so that Solidity can minimize the required storage space. For example, a struct with fields uint c; uint32 a; uint32 b; will cost less gas than a struct with fields uint32 a; uint c; uint32 b; because the uint32 fields are clustered together.

- The keyword `now` [*`now` is now depreciated, need to use block.timestamp*] will return the current unix timestamp of the latest block (the number of seconds that have passed since January 1st 1970).

  - Unix time is traditionally stored in a 32-bit number. This will lead to the "Year 2038" problem, when 32-bit unix timestamps will overflow and break a lot of legacy systems

- Little more on function modifiers :

  - modifier can also take arguments.

- `view` functions don't cost any gas when they're called externally by a user.
  - This is because view functions don't actually change anything on the blockchain – they only read the data.

# Lesson 4

- Goal is to create zombie battle functions. Learn how to get and send money between accounts.

- Refresher on function modifiers :

  - We have visibility modifiers that control when and where the function can be called from: private means it's only callable from other functions inside the contract; internal is like private but can also be called by contracts that inherit from this one; external can only be called outside the contract; and finally public can be called anywhere, both internally and externally.

  - We also have state modifiers, which tell us how the function interacts with the BlockChain: view tells us that by running the function, no data will be saved/changed. pure tells us that not only does the function not save any data to the blockchain, but it also doesn't read any data from the blockchain. Both of these don't cost any gas to call if they're called externally from outside the contract (but they do cost gas if called internally by another function).

  - Then we have custom modifiers, which we learned about in Lesson 3: onlyOwner and aboveLevel, for example. For these we can define custom logic to determine how they affect a function.

- Paybale modifier :

  - Special types of functions that can Receive Ether.
  - When you call an API function on a normal web server, you can't send US dollars along with your function call — nor can you send Bitcoin. But in Ethereum, because both the money (Ether), the data (transaction payload), and the contract code itself all live on Ethereum, it's possible for you to call a function and pay money to the contract at the same time.
  - We use `msg.value` to see how much Ether was sent to the contract.

- You can use `transfer` function to send funds to any Ethereum _address_

- Random number generation via keccak256
  - The best source of randomness we have in Solidity is the keccak256 hash function.
  - `uint(keccak256(abi.encodePacked(now, msg.sender, randNonce)))`
  - This is vulnerable, [In detail explanation here...](https://cryptozombies.io/en/lesson/4/chapter/4)
