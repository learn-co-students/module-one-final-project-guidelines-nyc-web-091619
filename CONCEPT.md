# Coffee transaction system WIP

Models    - Coffee Shop :name, :location, :opens_at, :closes_at, :cost/size(rep as $ - $$$), :rating( * - 5*)
          - Customer :username, :name, :home_location, :current_location, :wallet, :PSL_quota, :daily_intake (maybe instance methods)
Joined BY - PSL :coffee_shop_id, :customer_id, :dairy_or_substitute, :sweetness(ttyprompt), :iced?, :whip?, :shots=1, :size = 12oz, 16oz, 20oz. :cost = (:size * coffee_shop_cost)

Locations - boroughs

## Functionality

C - placing our orders
R - viewing of the order/viewing menu/order options
U - adding dairy, adding a shot, iced to hot?
D - "nevermind, next door's is better"

### Users

- Can rate their PSL after ordering
- should be able to deposit money
- can cancel a transaction

### Coffee Shops should be able to update their:

- availability of creamer options "Oat milk, almond, soy, half-n-half"
- availability of sweeteners "Honey, agave, stevia, syrup, sugar-in-the-row"

## User stories

As a user, I want to be able to order a PSL from the coffee shop at my desired location

As a user I want to know when my order is ready

As a user, I want to be able to find a coffee shop where I can afford X PSLs today

As a user, I want to find something near me(within my borough)

As a user, I want to find coffee shops near me, by rating, that are open

## Stretch-goals

- rating of coffee shops determined by avg of PSL orders' rating
- PSL-quota "Drink x more PSLs today, to get one free"
- Upselling merchandise or snacks
- ASCII art
- Sounds
  - Cash registers
  - Door opening
- Scraping Coffee shop locations
- geo-locations (lat/long)