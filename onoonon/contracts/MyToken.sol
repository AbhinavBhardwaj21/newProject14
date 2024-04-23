// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Vesting.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("MyToken", "MYT") {
        _mint(msg.sender, initialSupply);
    }

    // Function to create vesting schedules (explained in Vesting.sol)
    function createVestingSchedule(address beneficiary, uint256 amount, uint256 cliffDuration, uint256 vestingDuration) public {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        Vesting(msg.sender).createSchedule(beneficiary, amount, cliffDuration, vestingDuration);
        _transfer(msg.sender, address(Vesting(msg.sender)), amount); // Transfer tokens to vesting contract
    }
}
