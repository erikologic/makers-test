# Honeycomb Engineering Test - Makers Edition

## The challenge
From Honeycomb:  
"We have a system that delivers advertising materials to broadcasters.

Advertising Material is uniquely identified by a 'Clock' number e.g.

* `WNP/SWCL001/010`
* `ZDW/EOWW005/010`

Our sales team have some new promotions they want to offer so
we need to introduce a mechanism for applying Discounts to orders.

Promotions like this can and will change over time so we need the solution to be flexible."

## My approach
There were some example code provided by Honeycomb.  
My idea was to pretend this code was the one already in production.  

Therefore, I used the same approach that I would take in a real environment.  
I started with changing the implementation as less as possible, writing tests first, then 'go to green' and after refactor.

## The outcome
A Discount can be initialized and then used with several Orders.

Also, a DiscountManager can be initialized and many Discount objects can be registered within it.  
Then, the same DiscountManager can be used on several Order objects, thus making it easier to create a discount campaign and apply it to several Orders.  
Because DiscountManager share a similar interface to Discount, it's implementation doesn't add any extra levels of complexity on top the code.    

## Installation

- Download repo: `git clone git@github.com:mrenrich84/makers-test.git`
- You might need to install used Ruby version: `rvm install ruby-2.3.3`
- Install all dependencies: `bundle install`

## Running
You can either run it through:
- `rspec`
- `ruby run.rb`

## Backlog
Having more time I would have liked to:
- extrapolate abstract behaviours from PrinterOrder, so to have a more dynamic Printer system
- add name properties to the Discount objects in order to be able to show them in the order report
