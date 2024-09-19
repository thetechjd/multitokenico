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
            0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526
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



contract BNBReceiver is PriceConsumerV3{

    uint256 public tokenPrice = 0.01 * 10 ** 16;//0.01 USD
    address owner;

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

    function payWithBNB() external payable {
        require(msg.value > 0, "cannot send zero amount");
         // Get the latest BNB/USD price
        uint256 bnbPriceInUSD = getRoundedBNBPrice(); // 8 decimals

        // Convert BNB received (msg.value) to USD. BNB has 18 decimals, price has 8 decimals, so we scale up.
        uint256 bnbAmountInUSD = (msg.value * bnbPriceInUSD) / 10**8;

        // Now calculate how many tokens the user gets based on the token price in USD (18 decimals)
        uint256 tokensToBuy = (bnbAmountInUSD * 10**18) / tokenPrice;


        users.push(User({
            user: msg.sender, 
            amount: tokensToBuy
            }));
    }

    function getRoundedBNBPrice() public view returns (uint256) {
        uint256 rawPrice = uint256(getLatestPrice());
        uint256 ethPrice = rawPrice / 10**8;
        return ethPrice * 10**18;
    }


    function getTotalBNB() public view returns (uint256){
        uint256 total;
        for(uint8 i = 0; i < users.length; i++){
            total += users[i].amount;
        }
        return total;
    }

    function setTokenPrice(uint256 _newPrice) external onlyOwner {
        tokenPrice = _newPrice;
    }


}