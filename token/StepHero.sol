//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract StepHero is ERC20, Ownable {
    //Sun Aug 15 2021 21:30:00 GMT+0700 (Indochina Time)
    uint256 constant startTime = 1629037800;
    uint256 constant endTime = startTime + 60;

    mapping(address => bool) public whitelist;

    constructor() ERC20("StepHero", "HERO") {
        _mint(msg.sender, 100000000 * 10**18);
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     * - Allow whitelist only for 1 minute after listing PancakeSwap
     */
    function transfer(address recipient, uint256 amount)
        public
        virtual
        override
        returns (bool)
    {
        if (block.timestamp >= startTime && block.timestamp <= endTime) {
            require(whitelist[recipient], "StepHero: not in whitelist");
        }

        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * @dev Add whitelist token addresses
     *
     */
    function setupWhitelist(address[] memory whitelistAddresses, bool status)
        public
        onlyOwner
    {
        for (uint256 i = 0; i < whitelistAddresses.length; i++) {
            whitelist[whitelistAddresses[i]] = status;
        }
    }
}
