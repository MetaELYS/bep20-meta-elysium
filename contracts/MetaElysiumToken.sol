// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract MetaElysiumToken is ERC20, ERC20Burnable, Ownable {
    uint256 public TRANSFER_BURN_PERCENT_ELYS = 5;

    mapping (address => bool) public noBurnElys;

    constructor() ERC20("Meta Elysium", "ELYS") {
        _mint(msg.sender, 10000000 * 10 ** decimals());
    }

    function addNoBurnAddress(address adr) public onlyOwner {
        noBurnElys[adr] = true;
    }

    function removeNoBurnAddress(address adr) public onlyOwner {
        noBurnElys[adr] = false;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal override {
        if (noBurnElys[from] || noBurnElys[to]) {
            super._transfer(from, to, amount);
        } else {
            uint256 burnElysAmount = amount * TRANSFER_BURN_PERCENT_ELYS / 100;
            super._transfer(from, to, amount - burnElysAmount);
            super._burn(from, burnElysAmount);
        }
    }
}
