// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface AggregatorV3Interface {
    function decimals() external view returns (uint8);

    function description() external view returns (string memory);

    function version() external view returns (uint256);

    function getRoundData(uint80 _roundId)
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );

    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );
}

abstract contract PriceConsumerV3 {
    AggregatorV3Interface internal priceFeed;

    /**
     * Network: Mainnet
     * Aggregator: ETH/USD
     * Address: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
     */

    /**
     * Network: Sepolia
     * Aggregator: ETH/USD
     * Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
     */
    constructor() {
        priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
    }

    /**
     * Returns the latest price
     */
    function getLatestPrice() public view returns (int256) {
        (
            ,
            /*uint80 roundID*/
            int256 price, /*uint startedAt*/ /*uint timeStamp*/ /*uint80 answeredInRound*/
            ,
            ,

        ) = priceFeed.latestRoundData();
        return price;
    }
}

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}






abstract contract ReentrancyGuard {
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() {
        _status = _NOT_ENTERED;
    }

    modifier nonReentrant() {
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");
        _status = _ENTERED;

        _;
        _status = _NOT_ENTERED;
    }
}

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    function decimals() external view returns (uint8);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}



contract ICO is PriceConsumerV3, ReentrancyGuard {
    using SafeMath for uint256;

    IERC20 public token;
    IERC20 public usdt;

    address payable owner;

    uint8 public vestingPeriods = 90;
    uint8 public vestingPercent = 1;
    uint8 public tgePercent = 10;

    struct Buyer {
        address buyer;
        uint256 amountFunded;
        uint256 amountDue;
        uint256 amountClaimed;
        uint256 nextClaim;
        uint8 timesClaimed;
    }

   

    mapping(address => Buyer) public contributions;
    

    uint256 public sold;
    uint256 public tokenPrice = 0.01 * 10 ** 16;//0.01 USD
    uint256 public endTime;
    uint256 public nextClaim = 86400; //1 day; change this depending on how many rounds there will be
    uint256 public tge; //Token-Generating-Event (TGE) when you plan to release the tokens, in epoch time (seconds)
   

    bool public saleActive = true;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor(address _token, address _usdt, address payable _owner, uint256 _tge) {
        token = IERC20(_token);
        usdt = IERC20(_usdt);
        owner = _owner;
        tge = _tge;
    }

    
    //Added getclaim period function to let people know they can claim their next batch
    function getClaimPeriod(address _addr) public view returns (uint256) {
        return contributions[_addr].nextClaim;
    }

    function getAmountDue(address _addr) public view returns (uint256) {
        return contributions[_addr].amountDue;
    }

    function buyTokens() external payable {
        require(msg.value >= tokenPrice, "Insufficient amount sent");
        require(block.timestamp < endTime, "Current round has already ended!");
        require(saleActive, "Crowdsale is not active or has concluded");
        

         // Get the latest ETH/USD price
        uint256 ethPriceInUSD = getRoundedETHPrice(); // 8 decimals

        // Convert ETH received (msg.value) to USD. ETH has 18 decimals, price has 8 decimals, so we scale up.
        uint256 ethAmountInUSD = (msg.value * ethPriceInUSD) / 10**8;

        // Now calculate how many tokens the user gets based on the token price in USD (18 decimals)
        uint256 tokensToBuy = (ethAmountInUSD * 10**18) / tokenPrice;

        // Record the contribution
        contributions[msg.sender].buyer = msg.sender;
        contributions[msg.sender].amountFunded += msg.value;
        contributions[msg.sender].amountDue += tokensToBuy;
        contributions[msg.sender].nextClaim = tge;

        // Update total tokens sold
        sold += tokensToBuy;
    }
    function buyTokenswithUSDT(uint256 _amount) external {
        require(_amount >= tokenPrice, "Insufficient amount sent");
        require(block.timestamp < endTime, "Current round has already ended!");
        require(saleActive, "Crowdsale is not active or has concluded");
        

        // Now calculate how many tokens the user gets based on the token price in USD (18 decimals)
        uint256 tokensToBuy = (_amount * 10**18) / tokenPrice;

        // Record the contribution
        contributions[msg.sender].buyer = msg.sender;
        contributions[msg.sender].amountFunded += _amount * 10 ** 18;
        contributions[msg.sender].amountDue += tokensToBuy;
        contributions[msg.sender].nextClaim = tge;

        // Update total tokens sold
        sold += tokensToBuy;
    }

    function addBuyers(address [] calldata  _buyerAddress, uint256 [] calldata _amount ) external onlyOwner {
         // Get the latest ETH/USD price
        uint256 ethPriceInUSD = getRoundedETHPrice(); // 8 decimals

       
        for(uint8 i = 0; i < _buyerAddress.length; i++){

            uint256 amountInUSD = _amount[i] * tokenPrice;
            
        uint256 value = (amountInUSD * 10 ** 8) / ethPriceInUSD;

            contributions[msg.sender].buyer = _buyerAddress[i];
            contributions[msg.sender].amountFunded += value;
            contributions[msg.sender].amountDue += _amount[i];
            contributions[msg.sender].nextClaim = tge;

        }

    }

    function getRoundedETHPrice() public view returns (uint256) {
        uint256 rawPrice = uint256(getLatestPrice());
        uint256 ethPrice = rawPrice / 10**8;
        return ethPrice * 10**18;
    }

    

    function claim() external nonReentrant {
        require(
            msg.sender == contributions[msg.sender].buyer,
            "No contributions found!"
        );
        require(
            block.timestamp > contributions[msg.sender].nextClaim,
            "Not time for next vesting"
        );
        require(
            contributions[msg.sender].timesClaimed < vestingPeriods,
            "You're already fully vested!"
        );
        require(
            contributions[msg.sender].amountDue > 0,
            "You are not due to collect anymore."
        );
        require(block.timestamp > tge, "Final crowdsale has not concluded");

        
        if (contributions[msg.sender].timesClaimed == 0) {
            uint256 amountReceived = (contributions[msg.sender].amountDue *
                tgePercent) / 1000;
            require(
                token.balanceOf(address(this)) >= amountReceived,
                "Insufficient balance of TLB held in contract to complete claim"
            );

            token.transfer(msg.sender, amountReceived);

            contributions[msg.sender].nextClaim = block.timestamp + nextClaim; //1 month 2629743
            contributions[msg.sender].amountClaimed += amountReceived;
            contributions[msg.sender].timesClaimed++;
        } else if (
            contributions[msg.sender].timesClaimed == (vestingPeriods - 1)
        ) {
            uint256 remainder = contributions[msg.sender].amountDue -
                contributions[msg.sender].amountClaimed;
            require(
                token.balanceOf(address(this)) >= remainder,
                "Insufficient balance of TLB held in contract to complete claim"
            );

            token.transfer(msg.sender, remainder);

            contributions[msg.sender].amountClaimed += remainder;
            contributions[msg.sender].timesClaimed++;
        } else if (
            (contributions[msg.sender].amountDue -
                contributions[msg.sender].amountClaimed) <
            (contributions[msg.sender].amountDue * vestingPercent) / 1000
        ) {
            uint256 remainder = contributions[msg.sender].amountDue -
                contributions[msg.sender].amountClaimed;
            require(
                token.balanceOf(address(this)) >= remainder,
                "Insufficient balance of TLB held in contract to complete claim"
            );

            token.transfer(msg.sender, remainder);

            contributions[msg.sender].amountClaimed += remainder;
            contributions[msg.sender].timesClaimed++;
        } else {
            uint256 amountReceived = (contributions[msg.sender].amountDue *
                vestingPercent) / 1000;
            require(
                token.balanceOf(address(this)) >= amountReceived,
                "Insufficient balance of TLB held in contract to complete claim"
            );

            token.transfer(msg.sender, amountReceived);

            contributions[msg.sender].nextClaim = block.timestamp + nextClaim; //2592000;
            contributions[msg.sender].amountClaimed += amountReceived;
            contributions[msg.sender].timesClaimed++;
        }
    }

    function nextRound(uint256 _endTime, uint256 _price) external onlyOwner {
        endTime = _endTime;
        tokenPrice = _price;
    }

    // Vesting percent cannot use a decimal. Multiply the percent value by 10. 
    // E.g. 6.7 * 10 = 67
    function setVesting(uint8 _newPeriod, uint8 _newPercent)
        external
        onlyOwner
    {
        vestingPeriods = _newPeriod;
        vestingPercent = _newPercent;
    }

    function setTokenPrice(uint256 _newPrice) external onlyOwner {
        tokenPrice = _newPrice;
    }

    function setNextClaim(uint256 _nextClaim) external onlyOwner{
        // set time to next claim in seconds
        // 1 month equals 2629743
        nextClaim = _nextClaim;
    }

    function start_or_pause_crowdsale() external onlyOwner{
        saleActive = !saleActive;
    }

    
    function setTge(uint256 _tge) external onlyOwner{
        tge = _tge;
    }

    function setToken(address _token) external onlyOwner{
        token = IERC20(_token);
    }



    function transferOwnership(address payable _newOwner) external onlyOwner {
        owner = _newOwner;
    }

    function withdraw() external onlyOwner {
        require(
            block.timestamp > tge,
            "Cannot withdraw funds until after the TGE"
        );
        // This will payout the owner the contract balance.
        // Do not remove this otherwise you will not be able to withdraw the funds.
        // =============================================================================
        (bool os, ) = payable(owner).call{value: address(this).balance}("");
        require(os);
        // =============================================================================
    }

    function refund(address _addr) private {
        uint256 amountFunded = contributions[_addr].amountFunded;
        delete contributions[_addr];
        (bool os, ) = payable(_addr).call{value: amountFunded}("");
        require(os);
    }
}
