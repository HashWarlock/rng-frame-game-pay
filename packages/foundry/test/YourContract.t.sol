// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../contracts/RNGFrameGamePayForwarder.sol";

contract YourContractTest is Test {
    RNGFrameGamePayForwarder public yourContract;

    function setUp() public {
        yourContract = new RNGFrameGamePayForwarder(payable(vm.addr(1)));
    }

    function testMessageOnDeployment() public view {
    }

    function testSetNewMessage() public {
    }
}
