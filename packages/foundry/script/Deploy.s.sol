//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../contracts/RNGFrameGamePayForwarder.sol";
import "../contracts/TestToken.sol";
import "./DeployHelpers.s.sol";

contract DeployScript is ScaffoldETHDeploy {
    error InvalidPrivateKey(string);

    function run() external {
        uint256 deployerPrivateKey = setupLocalhostEnv();
        if (deployerPrivateKey == 0) {
            revert InvalidPrivateKey(
                "You don't have a deployer account. Make sure you have set DEPLOYER_PRIVATE_KEY in .env or use `yarn generate` to generate a new random account"
            );
        }
        vm.startBroadcast(deployerPrivateKey);
        TestToken testToken = new TestToken();
        console.logString(
            string.concat(
                "TestToken deployed at: ",
                vm.toString(address(testToken))
            )
        );

        RNGFrameGamePayForwarder yourContract = new RNGFrameGamePayForwarder(
            payable(0x5b73bA6277A5122dcc415F32Bdcf25377D0fe1F4),//0xeD9AC573FdCEa785ED254E38306899952e180Af3),
            address(testToken)//0x036CbD53842c5426634e7929541eC2318f3dCF7e
        );
        console.logString(
            string.concat(
                "YourContract deployed at: ",
                vm.toString(address(yourContract))
            )
        );
        vm.stopBroadcast();

        /**
         * This function generates the file containing the contracts Abi definitions.
         * These definitions are used to derive the types needed in the custom scaffold-eth hooks, for example.
         * This function should be called last.
         */
        exportDeployments();
    }

    function test() public {}
}
