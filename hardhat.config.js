require("@nomicfoundation/hardhat-toolbox");
// require('@nomiclabs/hardhat-ethers');
require('@openzeppelin/hardhat-upgrades');

require("dotenv").config({ path: './.env' });


/** @type import('hardhat/config').HardhatUserConfig */

const ALCHEMY_URL = process.env.ALCHEMY_URL;
const MNEMONIC = process.env.MNEMONIC;

console.log(ALCHEMY_URL);
module.exports = {
  solidity: "0.8.21",

  defaultNetwork: "sepolia",
  networks: {
    hardhat: {
    },
    sepolia: {
      url: ALCHEMY_URL,
      accounts: [MNEMONIC]
    }
  }


};
