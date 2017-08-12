### Summary
This project is the OEC 2018 Programming Challenge.

Competitors will be required to implement a BrokerBot, which is is
responsible for trying to make the most amount of $$$ by trading stocks

### How it works?
Stock prices are simulated using a process adapted from
[Brownian Motion](https://en.wikipedia.org/wiki/Brownian_motion).

Endpoints are exposed to get current and historical prices of a stock.
Competitors can then use this data to make a decision on when to buy
or sell a stock.

Each transaction is logged, and the value of each BrokerBots portfolio
is compared

### TODO
 - [x] implement stock price generation
 - [x] implement and test buy method for broker
 - [x] implement and test sell method for broker
 - [ ] implement simulate background job
 - [ ] implement broker api
 - [ ] load test broker api
 - [ ] make a pretty dashboard
