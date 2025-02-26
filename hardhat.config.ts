
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";

dotenv.config();
const { PRIVATE_KEY } = process.env;
const config: HardhatUserConfig = {
  solidity: "0.8.20",
  networks: {
    baseLima: {
      url: "https://sepolia.base.org",
      accounts: PRIVATE_KEY ? [`0x${PRIVATE_KEY}`] : [],  // Your MetaMask private key
    },
  },
  etherscan: {
    apiKey: {
      baseLima: '4C5M15VZWBGG72KM1FG9QMK8R4VBTB6XJF',  // Add your BaseScan API Key
    },
    customChains: [
      {
        network: "baseLima",
        chainId: 84532,
        urls: {
          apiURL: "https://api-sepolia.basescan.org/api",
          browserURL: "https://sepolia.basescan.org/",
        },
      },
    ],
  },
  sourcify: {
    enabled: true
  }
};

export default config;
