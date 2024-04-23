// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Import the IERC20 interface
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Vesting {
    address public owner;
    mapping(address => VestingSchedule) public schedules;

    struct VestingSchedule {
        address beneficiary;
        uint256 totalAmount;
        uint256 cliff; // Timestamp for cliff (90 days in seconds)
        uint256 vestingDuration; // Duration (1 year in seconds)
        uint256 releasedAmount;
    }

    constructor(address _owner) {
        owner = _owner;
    }

    function createSchedule(address beneficiary, uint256 amount, uint256 cliffDuration, uint256 vestingDuration) public {
        require(msg.sender == owner, "Only owner can create schedules");
        require(schedules[beneficiary].totalAmount == 0, "Schedule already exists");

        uint256 cliff = block.timestamp + cliffDuration;
        schedules[beneficiary] = VestingSchedule(beneficiary, amount, cliff, vestingDuration, 0);
    }

    function release() public {
        VestingSchedule storage schedule = schedules[msg.sender];
        require(block.timestamp >= schedule.cliff, "Cliff period not yet reached");

        uint256 vestedAmount = calculateVestedAmount(schedule);
        require(vestedAmount > schedule.releasedAmount, "No vested tokens available");

        schedule.releasedAmount = vestedAmount;
        IERC20(address(this)).transfer(msg.sender, vestedAmount); // Use interface to avoid type errors
    }

    function calculateVestedAmount(VestingSchedule storage schedule) private view returns (uint256) {
        uint256 elapsedTime = block.timestamp - schedule.cliff;
        uint256 vestingPeriod = schedule.vestingDuration;

        if (elapsedTime >= vestingPeriod) {
            return schedule.totalAmount;
        } else {
            return (schedule.totalAmount * elapsedTime) / vestingPeriod;
        }
    }
}
