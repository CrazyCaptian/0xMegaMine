pragma solidity ^0.8;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


contract AMock is ERC20 {
	constructor() public ERC20("NFTNFT, "NFT", 18) {
        
    }
    function withdrawToken(uint256 _amount) external {
        // transfer the token from address of this contract
        // to address of the user (executing the withdrawToken() function)
                _mint(msg.sender, _amount);
    }
}
