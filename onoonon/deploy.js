// deploy.js
const hre = require('hardhat');
const { ethers } = require('ethers');

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log('Deploying contracts with the account:', deployer.address);

  // Deploy MyToken contract (assuming it's defined elsewhere)
  const MyTokenFactory = await hre.contracts.factory('MyToken');
  const myToken = await MyTokenFactory.deploy();
  const myTokenAddress = myToken.address;
  console.log('MyToken deployed to:', myTokenAddress);

  // Deploy Vesting contract with deployer as owner
  const VestingFactory = await hre.contracts.factory('Vesting', deployer.address);
  const vesting = await VestingFactory.deploy(deployer.address);
  const vestingAddress = vesting.address;
  console.log('Vesting deployed to:', vestingAddress);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
