import { ethers } from "hardhat";

async function main() {
  const OnchainSVGNFT = await ethers.getContractFactory("OnchainSVGNFT");
  const nft = await OnchainSVGNFT.deploy();

  await nft.waitForDeployment();
  console.log("NFT Contract deployed to:", await nft.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
