# ETHanos

ETHanos is back and he is in the Ethereum universe. He is searching for all 6 infinity stones
(space, reality, power, mind, soul and time) on the Ethereum blockchain.

The `InfinityStone` contract has an owner, a name and a color. The stone also has a state which
can be `ACQUIRED` or `UNTAKEN`. Default state is `UNTAKEN`. The stone can be `acquire`d, and whoever acquires it must pay a price (in ETH). In
order to be acquired, the stone must have the status `UNTAKEN`. The stone can also be `give`(n)`Away`. Only the owner can call this function and the
stone must have the status ACQUIRED.

The `InfinityGauntlet` contract on construction creates (via factory pattern) and owns 6 infinity stones and stores them on the contract. The contract is
able to `addStones` to the gauntlet. The contract is also able to `acquireStone` and `giveAwayStone`.

## Hardhat

[Hardhat](https://hardhat.org/) Network is used to run and debug Solidity locally, along with [Typechain](https://github.com/ethereum-ts/TypeChain) to provide TypeScript bindings for Ethereum smart contracts.

## Solidity

`InfinityStone` is OpenZeppelin's `Ownable`.

Patterns applied:

- [Checks Effects Interactions](https://fravoll.github.io/solidity-patterns/checks_effects_interactions.html)

## Waffle

External & public contract functions are covered by [Waffle](https://ethereum-waffle.readthedocs.io) tests.

## Local dev

1. `npm i`
2. `npm run node` starts Hardhat Network
3. `npm run deploy` deploys the contracts & makes some transactions for testing

# Advanced Sample Hardhat Project

This project demonstrates an advanced Hardhat use case, integrating other tools commonly used alongside Hardhat in the ecosystem.

The project comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts. It also comes with a variety of other tools, preconfigured to work with the project code.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
npx hardhat help
REPORT_GAS=true npx hardhat test
npx hardhat coverage
npx hardhat run scripts/deploy.ts
TS_NODE_FILES=true npx ts-node scripts/deploy.ts
npx eslint '**/*.{js,ts}'
npx eslint '**/*.{js,ts}' --fix
npx prettier '**/*.{json,sol,md}' --check
npx prettier '**/*.{json,sol,md}' --write
npx solhint 'contracts/**/*.sol'
npx solhint 'contracts/**/*.sol' --fix
```

# Etherscan verification

To try out Etherscan verification, you first need to deploy a contract to an Ethereum network that's supported by Etherscan, such as Ropsten.

In this project, copy the .env.example file to a file named .env, and then edit it to fill in the details. Enter your Etherscan API key, your Ropsten node URL (eg from Alchemy), and the private key of the account which will send the deployment transaction. With a valid .env file in place, first deploy your contract:

```shell
hardhat run --network ropsten scripts/sample-script.ts
```

Then, copy the deployment address and paste it in to replace `DEPLOYED_CONTRACT_ADDRESS` in this command:

```shell
npx hardhat verify --network ropsten DEPLOYED_CONTRACT_ADDRESS "Hello, Hardhat!"
```

# Performance optimizations

For faster runs of your tests and scripts, consider skipping ts-node's type checking by setting the environment variable `TS_NODE_TRANSPILE_ONLY` to `1` in hardhat's environment. For more details see [the documentation](https://hardhat.org/guides/typescript.html#performance-optimizations).
