# Welcome to the Bucket List!

Welcome all to the Bucket List, where you can go to destinations that were only thought to be dreams.

This project is a simple CLI application:

- You can create a Traveller(User) account
- The Traveller(User) can choose it's destination
- The Traveller(User) and Destination tables are joined by the Traveller-Destination join table
- These are all stored into the SQLite3 database


## Our Process

Using ActiveRecord, we were able to store our domain models and convert them into database tables.
Each table has their own attributes and are linked by the join table to help facilitate the needs of our application.


## CRUD (Create, Read, Update, Delete/Detroy)

### Create

We began with creating a Traveller(User) and had him/her stored into the Traveller table. The Traveller(User) is assigned with a unique identifier (Foreign Key) and a name. After the Traveller(User) is established, he/she is able to choose from a list of destinations (our seed data), and add it to their Bucket List. The Destination table also has it's own unique identifier (Foreign Key) and a city.

### Read

Once the Traveller(User) has chosen it's destination to add to their Bucket List, they are able to retrieve a list of all their destination(s).
The Traveller and Destination tables are connected through the Traveller-Destination join table.

### Update

The Traveller(User) is able to update their check-in status, by selecting the "Check In" option from the menu. Once they have confirmed their check-in, the Traveller-Destination table is updated.

### Delete/Destroy

If the Traveller(User) decides to cancel their trip, he/she is able to do so with no hassle!
The Traveller(User) can cancel their last booked trip, if desired. By doing so, this will delete the connection of that Traveller(User) with it's associated destination(s).


#### Intructions

Please don't forget to 'Bundle Install' to install all required gems to run the application.


#### P.S.

The Faker gem: is an awesome tool for creating fake seed data in a flash!

Thank you all for reading!
