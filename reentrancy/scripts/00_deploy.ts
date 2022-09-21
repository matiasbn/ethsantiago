import { CONTRACTS_NAMES } from "../constants";

// @ts-ignore
module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  await deploy(CONTRACTS_NAMES.REENTRANCY, {
    from: deployer,
    log: true,
  });
};

module.exports.tags = [CONTRACTS_NAMES.REENTRANCY];
