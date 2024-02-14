// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../contracts/RNGFrameGamePayForwarder.sol";
import "../contracts/TestToken.sol";

contract YourContractTest is Test {
    RNGFrameGamePayForwarder public yourContract;
    TestToken public testToken;

    function setUp() public {
        testToken = new TestToken();
        yourContract = new RNGFrameGamePayForwarder(payable(vm.addr(1)), address(testToken));
    }

    function testMessageOnDeployment() public view {
    }

    function testSetNewMessage() public {
    }
}
