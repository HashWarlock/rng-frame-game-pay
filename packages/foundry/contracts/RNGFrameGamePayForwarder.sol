// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract RNGFrameGamePayForwarder is Ownable {
    address payable public forwarder;

    // Event to emit when a payment is forwarded
    event PaymentForwarded(address indexed sender, address indexed recipient, uint256 amount);
    // Event to emit when the owner is changed
    event ForwarderChanged(address indexed oldOwner, address indexed newOwner);
    // Event to emit when a withdrawal is made
    event Withdrawal(address indexed to, uint256 amount);

    // Modifier to restrict execution to the contract's owner
    modifier onlyForwarder() {
        require(msg.sender == forwarder, "Only the forwarder can call this function.");
        _;
    }

    // Constructor to set the initial forwarder of the contract
    constructor(address payable _forwarder) Ownable(msg.sender) {
        forwarder = _forwarder;
    }

    // Function to change the forwarder of the contract
    function changeForwarder(address payable newForwarder) external onlyOwner {
        require(newForwarder != address(0), "New forwarder cannot be the zero address.");
        emit ForwarderChanged(forwarder, newForwarder);
        forwarder = newForwarder;
    }

    // Fallback function to receive ETH
    receive() external payable {
        // Optionally, you can add logic here if you want to perform any actions when receiving ETH
    }

    // Function to forward the received ETH to a specified address
    function forwardPayment(address payable recipient) external payable onlyForwarder {
        require(msg.value > 0, "No ETH sent to forward.");
        require(recipient != address(0), "Cannot forward to the zero address.");

        // Forward the received ETH to the recipient
        (bool success, ) = recipient.call{value: msg.value}("");
        require(success, "Failed to forward payment.");

        // Emit the payment forwarded event
        emit PaymentForwarded(msg.sender, recipient, msg.value);
    }

    // Function to withdraw the contract's balance to a specified address
    function withdraw(address payable to) external onlyForwarder {
        uint256 balance = address(this).balance;
        require(balance > 0, "Contract balance is zero.");
        require(to != address(0), "Withdrawal address cannot be the zero address.");

        (bool success, ) = to.call{value: balance}("");
        require(success, "Withdrawal failed.");

        // Emit the withdrawal event
        emit Withdrawal(to, balance);
    }
}
