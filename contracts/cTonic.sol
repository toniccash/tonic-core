// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./ERC20Tonic.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract cTonic is ERC20Tonic {
    address public immutable governance = 0x5efda50f22d34F262c29268506C5Fa42cB56A1Ce;
    IERC20 public immutable comp;

    constructor(
        IERC20 _comp,
        IVerifier _verifier,
        IHasher _hasher,
        uint256 _denomination,
        uint32 _merkleTreeHeight,
        IERC20 _token,
        address payable _feePolicyManagerAddress
    ) ERC20Tonic(_verifier, _hasher, _denomination, _merkleTreeHeight, _token, _feePolicyManagerAddress) {
        require(address(_comp) != address(0), "Invalid COMP token address");
        comp = _comp;
    }

    /// @dev Moves earned yield of the COMP token to the tonic governance contract
    /// To make it work you might need to call `comptroller.claimComp(cPoolAddress)` first
    function claimComp() external {
        comp.transfer(governance, comp.balanceOf(address(this)));
    }
}
