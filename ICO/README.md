#MultiTokenICO

```solidity
contract ICO {
    // ...

    /**
     * @dev Allows users to purchase tokens.
     * 
     * @param _amount The amount of tokens to purchase.
     */
    function buyTokens() external payable {
        // ...
    }

    /**
     * @dev Allows users to purchase tokens with USDT.
     * 
     * @param _amount The amount of USDT to spend.
     */
    function buyTokenswithUSDT(uint256 _amount) external {
        // ...
    }

    /**
     * @dev Allows the owner to add new buyers.
     * 
     * @param _buyerAddress The address of the buyer.
     * @param _amount The amount of tokens to purchase.
     */
    function addBuyers(address [] calldata  _buyerAddress, uint256 [] calldata _amount ) external onlyOwner {
        // ...
    }

    /**
     * @dev Gets the claim period for a user.
     * 
     * @param _addr The address of the user.
     * @return The claim period in seconds.
     */
    function getClaimPeriod(address _addr) public view returns (uint256) {
        // ...
    }

    /**
     * @dev Gets the amount due for a user.
     * 
     * @param _addr The address of the user.
     * @return The amount due in tokens.
     */
    function getAmountDue(address _addr) public view returns (uint256) {
        // ...
    }

    /**
     * @dev Allows users to claim their tokens.
     * 
     * @notice The user must have already purchased tokens.
     */
    function claim() external nonReentrant {
        // ...
    }

    /**
     * @dev Sets the next round's end time and token price.
     * 
     * @param _endTime The end time of the next round in seconds.
     * @param _price The token price in tokens per USDT.
     */
    function nextRound(uint256 _endTime, uint256 _price) external onlyOwner {
        // ...
    }

    /**
     * @dev Sets the vesting period and percentage.
     * 
     * @param _newPeriod The new vesting period in months.
     * @param _newPercent The new vesting percentage.
     */
    function setVesting(uint8 _newPeriod, uint8 _newPercent) external onlyOwner {
        // ...
    }

    /**
     * @dev Sets the token price.
     * 
     * @param _newPrice The new token price in tokens per USDT.
     */
    function setTokenPrice(uint256 _newPrice) external onlyOwner {
        // ...
    }

    /**
     * @dev Sets the next claim period.
     * 
     * @param _nextClaim The next claim period in seconds.
     */
    function setNextClaim(uint256 _nextClaim) external onlyOwner {
        // ...
    }

    /**
     * @dev Starts or pauses the crowdsale.
     */
    function start_or_pause_crowdsale() external onlyOwner {
        // ...
    }

    /**
     * @dev Sets the TGE (Token-Generating-Event) time.
     * 
     * @param _tge The new TGE time in seconds.
     */
    function setTge(uint256 _tge) external onlyOwner {
        // ...
    }

    /**
     * @dev Sets the token contract.
     * 
     * @param _token The new token contract.
     */
    function setToken(address _token) external onlyOwner {
        // ...
    }

    /**
     * @dev Transfers ownership of the contract.
     * 
     * @param _newOwner The new owner.
     */
    function transferOwnership(address payable _newOwner) external onlyOwner {
        // ...
    }

    /**
     * @dev Withdraws the contract's balance.
     */
    function withdraw() external onlyOwner {
        // ...
    }

    /**
     * @dev Refunds a user's funds.
     * 
     * @param _addr The address of the user.
     */
    function refund(address _addr) private {
        // ...
    }
}
```