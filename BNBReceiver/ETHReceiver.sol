// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity 0.8.20;

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



contract ETHReceiver is PriceConsumerV3{

    uint256 public tokenPrice = 1 * 10 ** 16;//0.01 USD
    address owner;


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


    struct User {
        address user;
        uint256 amount;
    }

    User [] public users; 

    modifier onlyOwner(){
        require(msg.sender == owner, "not authorized");
        _;
    }

    constructor(){
        owner = msg.sender;
    }

    function getUsers() public view returns (User[] memory ){
        return users;
    }

    function payWithETH() external payable {
        require(msg.value > 0, "cannot send zero amount");
         // Get the latest BNB/USD price
        uint256 ethPriceInUSD = getRoundedETHPrice(); // 8 decimals

        // Convert BNB received (msg.value) to USD. BNB has 18 decimals, price has 8 decimals, so we scale up.
        uint256 ethAmountInUSD = (msg.value * ethPriceInUSD) / 10**8;

        // Now calculate how many tokens the user gets based on the token price in USD (18 decimals)
        uint256 tokensToBuy = (ethAmountInUSD * 10**18) / tokenPrice;


        users.push(User({
            user: msg.sender, 
            amount: tokensToBuy
            }));
    }

    function getRoundedETHPrice() public view returns (uint256) {
        uint256 rawPrice = uint256(getLatestPrice());
        uint256 ethPrice = rawPrice / 10**8;
        return ethPrice * 10**18;
    }


    function getTotalETH() public view returns (uint256){
        uint256 total;
        for(uint8 i = 0; i < users.length; i++){
            total += users[i].amount;
        }
        return total;
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

    



    function setTokenPrice(uint256 _newPrice) external onlyOwner {
        tokenPrice = _newPrice;
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


}