import { CONTRACTS_NAMES } from "../constants";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  await deploy(CONTRACTS_NAMES.REENTRANCY, {
    from: deployer,
    log: true,
  });
  await deploy(CONTRACTS_NAMES.ATTACKER, {
    from: deployer,
    log: true,
  });
};

func.tags = [CONTRACTS_NAMES.REENTRANCY];
export default func;
