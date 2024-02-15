//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../contracts/GuessANumberPayForwarder.sol";
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
//        TestToken testToken = new TestToken();
//        console.logString(
//            string.concat(
//                "TestToken deployed at: ",
//                vm.toString(address(testToken))
//            )
//        );

        GuessANumberPayForwarder yourContract = new GuessANumberPayForwarder(
            payable(0x3217270ff5d11B3865C402FB49f8F77dC433c5f9),
            0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
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
