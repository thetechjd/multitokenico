# BNB Receiver

This is a Solidity contract that consumes prices from the AggregatorV3Interface and uses them to calculate the value of BNB tokens received in exchange. The contract has the following functions:

1. `getLatestPrice()`: Returns the latest ETH/USD price from the AggregatorV3Interface.
2. `getUsers()`: Returns an array of users who have received BNB tokens.
3. `payWithBNB()`: Allows users to pay with BNB and receive tokens in exchange. The function calculates the value of BNB received and uses the latest ETH/USD price to determine how many tokens to give.
4. `getTotalBNB()`: Returns the total amount of BNB tokens that have been received.
5. `setTokenPrice()`: Allows the owner to set a new token price.

Here is the NatSpec documentation for the functions:


## payWithBNB

### Description

Allows users to pay with BNB and receive tokens in exchange.

### Parameters

* `msg.value`: The amount of BNB paid.

### Returns

The amount of tokens received.

### Requirements

* `msg.value > 0`: The user must pay a non-zero amount.

### Effects

* Stores the user's address and the amount of tokens received in the `users` array.

## getRoundedBNBPrice

### Description

Returns the rounded BNB price based on the latest ETH/USD price.

### Parameters

None

### Returns

The rounded BNB price.

## getTotalBNB

### Description

Returns the total amount of BNB tokens that have been received.

### Parameters

None

### Returns

The total amount of BNB tokens.

## setTokenPrice

### Description

Allows the owner to set a new token price.

### Parameters

* `_newPrice`: The new token price.

### Requirements

* `msg.sender == owner`: Only the owner can set a new token price.

### Effects

* Updates the `tokenPrice` variable.
