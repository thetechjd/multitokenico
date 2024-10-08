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
    /**
     * Network: BSC Mainnet
     * Aggregator: ETH/USD
     * Address: 0x0567F2323251f0Aab15c8dFb1967E4e8A7D42aeE
     */
    /**
     * Network: BSC Testnet
     * Aggregator: BNB/USD
     * Address: 0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526
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
    uint8 public tgePercent = 10; // 1% 

    uint public bronze = 1000; //in usd
    uint public silver = 5000;
    uint public gold = 10000;
    uint public platinum = 25000;
    uint public diamond = 100000;

    uint8 public bronzePct = 1;
    uint8 public silverPct = 3;
    uint8 public goldPct = 6;
    uint8 public platinumPct = 8;
    uint8 public diamondPct = 10;


    struct Buyer {
        address buyer;
        uint256 amountFunded;
        uint256 amountDue;
        uint256 amountClaimed;
        uint256 nextClaim;
        uint8 timesClaimed;
    }

   

    mapping(address => Buyer) public contributions;
    mapping(uint256 => address) public referrers;
    mapping(address => uint256) public refByAddr;
    

    uint256 public sold;
    uint256 public tokenPrice = 1 * 10 ** 16;//0.01 USD
    uint256 public endTime;
    uint256 public nextClaim = 86400; //1 day; change this depending on how many rounds there will be
    uint256 public tge; //Token-Generating-Event (TGE) when you plan to release the tokens, in epoch time (seconds)
   

    bool public saleActive = false;

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

    //create random referral code

function random(address i) private view returns(uint256){
        return uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, i))) % 10000000000;
    }

function addReferralAddress(address _addr) private {

        uint256 _referralCode = random(_addr);
        referrers[_referralCode] = _addr;
        refByAddr[_addr] = _referralCode;
        
    }

function getRefByAddr(address _addr) public view returns (uint256){
    return refByAddr[_addr];
}

function generateRefCode(address _addr) public {
    addReferralAddress(_addr);
}


    function buyTokens(uint256 _refCode) external payable {
        require(msg.value >= tokenPrice, "Insufficient amount sent");
        require(block.timestamp < endTime, "Current round has already ended!");
        require(referrers[_refCode] != msg.sender, "Can't refer yourself");
        require(saleActive, "Crowdsale is not active or has concluded");


         // Get the latest ETH/USD price
        uint256 bnbPriceInUSD = getRoundedBNBPrice(); // 8 decimals

        // Convert BNB received (msg.value) to USD.BNB has 18 decimals, price has 8 decimals, so we scale up.
        uint256 bnbAmountInUSD = (msg.value * bnbPriceInUSD) / 10**8;

        uint256 tokensToBuy;

        if(referrers[_refCode] != address(0)){
            tokensToBuy = (bnbAmountInUSD * 10**18) / tokenPrice ;
            tokensToBuy = (tokensToBuy * 5 / 100) + tokensToBuy;
        } else {
            tokensToBuy = (bnbAmountInUSD * 10**18) / tokenPrice ;
        }

        tokensToBuy = processTiers(tokensToBuy);
        

        // Record the contribution
        contributions[msg.sender].buyer = msg.sender;
        contributions[msg.sender].amountFunded += msg.value;
        contributions[msg.sender].amountDue += tokensToBuy;
        contributions[msg.sender].nextClaim = tge;

        // Update total tokens sold
        sold += tokensToBuy;
    }
    function buyTokenswithUSDT(uint256 _amount, uint256 _refCode) external {
        require(_amount * 10 ** 18 >= tokenPrice, "Insufficient amount sent");
        require(block.timestamp < endTime, "Current round has already ended!");
        require(referrers[_refCode] != msg.sender, "Can't refer yourself");
        require(saleActive, "Crowdsale is not active or has concluded");


        uint256 tokensToBuy;

        if(referrers[_refCode] != address(0)){
            tokensToBuy = (_amount * 10**18) / tokenPrice ;
            tokensToBuy = (tokensToBuy * 5 / 100) + tokensToBuy;
        } else {
            tokensToBuy = (_amount * 10**18) / tokenPrice ;
        }

        tokensToBuy = processTiers(tokensToBuy);

       

        // Record the contribution
        contributions[msg.sender].buyer = msg.sender;
        contributions[msg.sender].amountFunded += _amount * 10 ** 18;
        contributions[msg.sender].amountDue += tokensToBuy;
        contributions[msg.sender].nextClaim = tge;

        // Update total tokens sold
        sold += tokensToBuy;
    }

    function addBuyers(address [] calldata  _buyerAddress, uint256 [] calldata _amount ) external onlyOwner {
         // Get the latest BNB/USD price
        uint256 bnbPriceInUSD = getRoundedBNBPrice(); // 8 decimals

       
        for(uint8 i = 0; i < _buyerAddress.length; i++){

            uint256 amountInUSD = _amount[i] * tokenPrice;
            
        uint256 value = (amountInUSD * 10 ** 8) / bnbPriceInUSD;

            contributions[msg.sender].buyer = _buyerAddress[i];
            contributions[msg.sender].amountFunded += value;
            contributions[msg.sender].amountDue += _amount[i];
            contributions[msg.sender].nextClaim = tge;

        }

    }

    function getRoundedBNBPrice() public view returns (uint256) {
        uint256 rawPrice = uint256(getLatestPrice());
        uint256 bnbPrice = rawPrice / 10**8;
        return bnbPrice * 10**18;
    }

    function processTiers(uint256 _amount) public view returns (uint256) {
        uint256 amount = _amount;

        if((amount * 10 ** 16) / 10 ** 18  >= bronze){
            amount = (amount * bronzePct / 100) + amount;
        }
        else if((amount * 10 ** 16) / 10 ** 18 >= silver){
            amount = (amount * silverPct / 100) + amount;
        }
        else if((amount * 10 ** 16) / 10 ** 18 >= gold){
            amount = (amount * goldPct / 100) + amount;
        }
        else if((amount * 10 ** 16) / 10 ** 18 >= platinum){
            amount = (amount * platinumPct / 100) + amount;
        }
        else if((amount * 10 ** 16) / 10 ** 18 >= diamond){
            amount = (amount * diamondPct / 100) + amount;
        }

        return amount;
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
    function setUSDT(address _token) external onlyOwner{
        usdt = IERC20(_token);
    }

    function setTiers(
        uint256 _bronze,
        uint256 _silver,
        uint256 _gold,
        uint256 _platinum,
        uint256 _diamond,
        uint8 _bronzePct,
        uint8 _silverPct,
        uint8 _goldPct,
        uint8 _platinumPct,
        uint8 _diamondPct
    ) external onlyOwner {
        require(_bronzePct < 100 && _silverPct < 100 && _goldPct < 100 && _platinumPct < 100 && _diamondPct < 100, "Percentage cannot be greater than 100");
        bronze = _bronze;
        silver = _silver;
        gold = _gold;
        platinum = _platinum;
        diamond = _diamond;
        bronzePct = _bronzePct;
        silverPct = _silverPct;
        goldPct = _goldPct;
        platinumPct = _platinumPct;
        diamondPct = _diamondPct;
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

    
}
