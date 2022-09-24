# ETHSantiago 2022

## Reentrancy PoC

### How to run

Install the hardhat shorthand:

https://hardhat.org/hardhat-runner/docs/guides/command-line-completion

Move into the `reentrancy` folder.

Then install the dependencies:

```
npm i
```

Then run the tests:

```
npm run test
```

### Files description

Inside the `reentrancy/tests` exists 1 file with the PoC of the Reentrancy attack

The contracts are inside the `reentrancy/contracts` folder.

The deploy script is inside the `reentrancy/deploy` folder.

### Deployment explanation

1. Deploy the Reentrancy vulnerable contract
2. Deploy the Attacker contract with the Reentrancy address

### Attack explanation

<img src="./Reentrancy%20-%20Frame%201.jpeg"></img>

Repeat the 3-4 flow until the contract is drained, calculate the correct amount of loops to not fail the transaction for lack of funds
