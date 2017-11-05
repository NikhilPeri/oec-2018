# Competition
Your challenge is to develop a trading bot, that makes the most $$$.
You will be given a $100,000 of starting capital.  You can choose from
100 stocks on the market, to buy sell or hold.  

Interacting with the market will cost you

- $3 for every stock quote
- $10 for every sell operation
- $20 for account status

Every minute of realife is one hour on the market, you can see the current
standings [here](/)

>__Rules__

There are not many rules for the competition, but violating any of them
will result in immediate disqualification

- NO HACKING the admin user (me)
- NO DDoS attacks on the server or other competitors

Everything else is fair game, if you are unsure ask the organizer.
Keep your code safe, especially your access token!

# Account Setup
Remember _Compound Intrest_ your goals should be to start trading A$AP.

 1. Get an Access Token from your competition organizer
 2. Head over to this link to [register]('/broker/register') to register your broker
 3. You should see your API Key here, this will allow you to make trades

If your bot is ever compromised, you should [login]('/broker/login') and to generate a new token

# API
Now that your are setup you can start trading using the following endpoints.
If this is your first time making web requests; checkout the following language docs:

 - [Ruby]()
 - [Python]()
 - [Java]()

Or feel free to ask your organizer for help

>#### Get Current Price

`GET /api/stock?ticker=[stock_identifier]&key=[api_key]`

```
stock_identifier
:  A three letter code to identify a stock (ex. AAPL)
```
This will cost $3 and will return the current stock price, along with
the last 10 prices of the stock

_Example Response_

```
{
  ticker: 'OTT',
  price: 394.22,
  historical_prices: [ ... ],
  success: true,
  errors: null
}
```

>#### Buy Stock

`GET /api/buy?ticker=[stock_identifier]&shares=[num_shares]&key=[api_key]`

```
stock_identifier
:  A three letter code to identify a stock
num_shares
:  An integer value for the number of shares to buy at current market price
```

This will add the specified number of shares to your account removing the
appropriate amount of cash from your account, with no fees.  
The request will fail if you do not have sufficient funds.

_Example Response_

```
{
  ticker: 'OTT',
  success: true,
  errors: null
}
```


>#### Sell Stock

`GET /api/sell?ticker=[stock_identifier]&shares=[num_shares]key=[api_key]`

```
stock_identifier
:  A three letter code to identify a stock
num_shares
:  An integer value for the number of shares to buy at current market price
```

This will sell the specified number of shares from your account, depositing
the appropriate amount of cash in your account, with a $10 fee.
The request will fail if you do not have sufficient funds

_Example Response_

```
{
  ticker: 'OTT',
  success: true,
  errors: null
}
```

>#### Account Status

`GET /api/account?key=[api_key]`

key
:  Your api key

This will return your account value in dollars, along all your current holdings.
This will charge a $20 fee

_Example Response_

```
{
  cash: 100000.00,
  holdings: [
    {
      ticker: 'OTT',
      shares: 100,
      price: 394.22,
    },
    {
      ticker: 'HAT',
      shares: 590,
      price: 20.19,
    }
  ]
}
```
