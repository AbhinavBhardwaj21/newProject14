
module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.8.24",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
    ],
    solidity: {
      sources: {
        contracts: ['contracts/Vesting.sol', 'contracts/MyToken.sol'],
      },
    },
    networks: {
      hardhat: {
        // Hardhat Network configuration (replace with your accounts)
        chainId: 1337, // Customize if needed
        accounts: {
          count: 10, // Number of local accounts to generate
        },
      },    
  },
  
}
}
