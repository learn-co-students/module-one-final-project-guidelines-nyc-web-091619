# Welcome to your new pumpkin-spice life, it's real basic

## Instructions

1. run `bundle install`
2. execute rake using `bundle exec rake -T`
3. execute migrations in DB using `bundle exec rake db:migrate`
4. seed the database using `bundle exec rake db:seed`
5. open `pry` console using `bundle exec rake console`
6. run the app using `ruby bin/run.rb`

## CRUD functionality

### Create

* Users can be created
  1. `Cli#create_user` -- creates a user with their specified name, caffeine intake (quota used in User#affordable), and home location.
* Instances of Pumpkin Spice lattes can be created
  1. `CoffeeShop#order` -- creates an instance of Psl with the user determined attributes: dairy option, size, sweetener, sweetness, iced?, whip?, and shots.

### Read

Database of Coffee Shops can be viewed by the following methods:

* `Cli#browse`
  1. Find by Location, price-point, and minimum rating
  
  2. Top ten list populated at random using coffee shops whose PSLs are rated 4 or higher
* `Cli#portal`
  1. Find an affordable option -- This will find a coffee shop whose PSLs you can afford to meet the user's determined "daily quota" attribute using small PSLs with only 1 shot of espresso. This is calculated by dividing the User's wallet contents by (12 oz * daily quota) in order to determine the maximum cost per ounce of coffee that a user can afford, and then comparing it with the `cost_per_oz` attribute of coffee shops.

  2. Find by rating

  3. Find a cult-classic -- a cult classic is considered to be a $ coffee shop with relatively high ratings.

  4. Find a classic-bux -- Finds a starbucks in user's home location.

  5. Find a bistro -- Finds an expensive shop

  6. Browse -- See `Cli#Browse`
* `CoffeeShop#display`

  1. Displays name and location of coffee shop.

  2. Displays cost of standard 1-shot small, medium, and large PSLs.

  3. Displays how the shops PSLs have been rated through `CoffeeShop#how_good_are_my_psls`

### Update

* Users' wallet attribute can be updated
  1. User's can deposit money in `Cli#portal`

  2. User's wallet is updated on purchase of Psl through `CoffeeShop#order`

  3. User's wallet is updated on refunding of bad Psl
* Psl's track whether they've been paid or refunded through the paid? attribute
* Psl's are rated through `CoffeeShop#post_pay_rate`
  
### Destroy

* Users can delete their accounts through `Cli#portal`

## The magic of seeding

* Coffee Shop model was populated and tested using CSV data from the data.cityofnewyork.us/api, specifically [DOHMH New York City Restaurant Inspection Results](https://data.cityofnewyork.us/Health/DOHMH-New-York-City-Restaurant-Inspection-Results/43nn-pn8j), and a generic query for 'coffee' within type/name of institution. This CSV dataset is stored in the root directory of this app.

* User model was populated using the `faker` gem

* PSL model was populated using random values

Check out ./db/seeds.rb for more info!

## Prospective work

There are quite a few ways this code could be improved, namely in minor refactors. Good OOD principles can be better represented by refactoring read queries as individual methods within the Psl and CoffeeShop class as instance methods.

A *smart* readback function within `CoffeeShop#order` would be a great addition.

The gemfile can be improved upon by setting environments/groups, however in the *keep it simple* mentality, unless this app were to be expanded upon with an installer, it makes the initial user experience slightly worse with the requirement of additional flags in the `bundle install` statement.

DRYing out the code by including a few new classes and one-to-many relations by abstracting out locations (which would provide scalability) and coffee ingredients (so that all coffee shops don't provide the exact same options as far as dairy, sweetener, etc.).

## Concept

The original brainstorm can be found in CONCEPT.md.

## Created by

Turcan Cicek and Erica Basak
