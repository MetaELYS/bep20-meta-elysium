const hre = require("hardhat");

async function main() {
  const MetaElysiumToken = await hre.ethers.getContractFactory("MetaElysiumToken");
  const metaElysiumToken = await MetaElysiumToken.deploy();

  await metaElysiumToken.deployed();

  console.log("MetaElysiumToken deployed to:", metaElysiumToken.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
