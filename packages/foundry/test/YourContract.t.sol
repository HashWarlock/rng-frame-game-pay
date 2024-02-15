// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../contracts/GuessANumberPayForwarder.sol";
import "../contracts/TestToken.sol";

contract YourContractTest is Test {
    GuessANumberPayForwarder public yourContract;
    TestToken public testToken;

    function setUp() public {
        testToken = new TestToken();
        yourContract = new GuessANumberPayForwarder(payable(vm.addr(1)), address(testToken));
    }

    function testMessageOnDeployment() public view {
    }

    function testSetNewMessage() public {
    }
}
