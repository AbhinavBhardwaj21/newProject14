// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Airdrop {
    address public tokenAddress;
    mapping(address => bool) public claimed;

    constructor(address _tokenAddress) {
        tokenAddress = _tokenAddress;
    }

    function claim(uint256 amount) public {
        require(!claimed[msg.sender], "Already claimed");
        IERC20(tokenAddress).transfer(msg.sender, amount);
        claimed[msg.sender] = true;
    }
}
