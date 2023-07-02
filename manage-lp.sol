pragma solidity ^0.8.0;

// Import required ERC-20 interfaces
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// The contract that will manage LP tokens
contract LPManagement {
    // Declare the ERC-20 token address
    address public tokenAddress;
    
    // Declare the mapping to store LP balances
    mapping(address => uint256) public lpBalances;
    
    // Declare author information
    string public authorGitHubUsername;
    address public authorWalletAddress;
    
    // Constructor to set the ERC-20 token address
    constructor(address _tokenAddress) {
        tokenAddress = _tokenAddress;
        
        // Set the author information
        authorGitHubUsername = "@Anashaneef";
        authorWalletAddress = 0xC44cb74d0ced94120332D697065494131692E979;
    }
    
    // Function to add LP tokens to an address
    function addLiquidityProvider(address lpAddress, uint256 amount) external {
        // Transfer LP tokens from the sender to the contract
        IERC20(tokenAddress).transferFrom(msg.sender, address(this), amount);
        
        // Update the LP balance for the provided address
        lpBalances[lpAddress] += amount;
    }
    
    // Function to remove LP tokens from an address
    function removeLiquidityProvider(uint256 amount) external {
        // Retrieve the LP tokens from the sender's balance
        uint256 lpBalance = lpBalances[msg.sender];
        
        // Ensure the sender has sufficient LP tokens
        require(lpBalance >= amount, "Insufficient LP tokens");
        
        // Transfer LP tokens from the contract to the sender
        IERC20(tokenAddress).transfer(msg.sender, amount);
        
        // Update the LP balance for the sender
        lpBalances[msg.sender] -= amount;
    }
}
