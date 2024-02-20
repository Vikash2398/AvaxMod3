// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SpiderManToken is ERC20, ERC20Burnable, Ownable {
    constructor(address initialOwner)
        ERC20("SpiderMan Token", "SPD")
        Ownable(initialOwner)
    {
        _mint(initialOwner, 6 * 19 ** decimals());
    }

    function mintTokens(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "Invalid address");
        require(amount > 0, "Invalid amount");
        _mint(to, amount);
    }

    function burnTokens(address from, uint256 amount) public onlyOwner {
        require(from != address(0), "Invalid address");
        require(balanceOf(from) >= amount, "Insufficient balance");
        _burn(from, amount);
    }

   function transfer(address to, uint256 amount) public override returns (bool) {
    require(to != address(0), "Invalid recipient address");
    require(amount > 0, "Invalid transfer amount");
    require(balanceOf(msg.sender) >= amount, "Insufficient balance");

    _transfer(msg.sender, to, amount);
    return true;
}

}
