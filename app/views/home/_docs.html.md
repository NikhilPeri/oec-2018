# Competition
Your challenge is to develop a trading bot, that makes the most $$$.
You will be given a $100,000 of starting capital.  You can choose from
100 stocks on the market, to buy sell or hold.  

Interacting with the market will cost you $10 for every buy & sell operation

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
 2. Head over to this link to [register](/broker/register) to register your broker
 3. You should see your API Key here, this will allow you to make trades

If your bot is ever compromised, you should [login](/broker/login) and to generate a new token
If you have any questions please comment in our group [chat](https://github.com/NikhilPeri/resume/issues/1)
this is also my resume, and I am looking for a summer internship.

# Judging & Submission
All Teams must submit code via a private github repository inviting @NikhilPeri as a collaborator
or by sending a zip to nperi104@uottawa.ca no late submissions or commits accepted.

All Teams must prepare a 10 min presentation with a 5 minute question period.


| Criteria             | Max Points | Description                                                                                                                                                                                                                |
|----------------------|------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Code Quality         | 30         |  <ul><li>Readability of the code</li><li> Functionality of the code </li><li>This score is based entirely on judges</li></ul>|
| System Performance   | 20         |<ul><li>Minimization of the number of requests </li><li>Reliance to data outages and failures </li><li>Minimize computational time and memory complexity</li><li>Techniques for deploying and iterating on Algorithms in realtime</li></ul>|
| Presentability         | 5          |<ul><li>Building or utilizing reliable technologies to deploy your solution</li><li>Product Quality for client, in terms of usability</li></ul>|
| Prediction Algorithm | 35         | <ul><li>The understanding and ability to explain the Prediction Algorithm used</li><li>The quality of features selected for algorithm </li><li>Presentation of intresting research and findings about simulation</li></ul>|
| Making That Money    | 10         |  `score = 10 / overall_rank`  where the highest ranking player made the most money                                                                                                                                         |

# API
Now that your are setup you can start trading using the following endpoints.
The entire API is based on GET requests for ease of use, this way you can play around
in the browser without typing a line of code.
If this is your first time making get requests; checkout the following language docs:

 - [Ruby](https://github.com/httprb/http)
 - [Python](http://docs.python-requests.org/en/master/)
 - [Java](http://hc.apache.org/httpclient-3.x/)

Or feel free to ask your organizer for help

>#### Get Stock List

`GET /api/stock/list?key=[api_key]`

_Example Response_

```
{
  success: true,
  errors: [],
  stock_tickers: [ ... ]
}
```

This will return a list

>#### Get Current Price

`GET /api/stock?ticker=[stock_identifier]&key=[api_key]`

```
stock_identifier
:  A three letter code to identify a stock (ex. AAPL)
```
This will return the current stock price in cents, along with
the last historical prices of the stock in cents sorted from oldest
to newest (ie. the last price in the list is the most recent)

_Example Response_

```
{
  success: true,
  errors: [],
  ticker: 'OTT',
  price: 39422,
  historical_prices: [ ... ]
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
  success: true,
  errors: [],
  ticker: 'OTT'
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
  success: true,
  errors: [],
  ticker: 'OTT'
}
```

>#### Account Status

`GET /api/account?key=[api_key]`

key
:  Your api key

This will return your account value in cents, along all your current holdings.
Each holding will list the ticker, number of shares,
[book cost](https://www.accountingtools.com/articles/what-is-the-difference-between-book-value-and-market-value.html)
and [market value](https://www.accountingtools.com/articles/what-is-the-difference-between-book-value-and-market-value.html)
This will charge a $20 fee

_Example Response_

```
{
  success: true,
  errors: [],
  cash: 10000000,
  holdings: [
    {
      ticker: 'OTT',
      shares: 100,
      book_cost: 10232,
      market_value: 18827,
    },
    {
      ticker: 'HAT',
      shares: 590,
      book_cost: 10232,
      market_value: 18827,
    }
  ]
}
```

>#### Error Messages

Error responses come in the form

```
{
  success: true,
  errors: [InvalidAPIKey, InvalidStockTicker],
}
```

There are four types of errors to expect:

```
InvalidAPIKey
:  There is no broker with the requested api key
InvalidStockTicker
:  There is no stock with the requested ticker symbol
InsufficientFunds
:  Your account does not have the required amount of cash
InsufficientShares
:  Your account does not have the required number of shares
```
