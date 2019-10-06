# clerksmovies

Welcome to ClerksBuster

What do you want to do
1a. Search for a movie
1b.. View all the movies available
2a. Check your active rentals
2b. Check you membership
2c. Close your membership
3. Become a new member
4. Exit
---
1a. Search for a movie
* What movie do you want to rent
* Enter the movie title
* Movies - Available Copies

1b. View all the movies available
* We have all these movies available
* List of movies

2a. Check your active movie rentals
* Enter you membership number or user name

2b. Check your membership
* Enter you membership or username

2c. Become a new member
* Enter your name and birth day

3. Close your membership
* Delete user

4. Exit
* Close the program

---

```

1. Welcome screen/msg

2. Checkout Movie
    + opens 2nd menu
        - choice: search by title
        - choice: view all movies
    + List results 
        + show all movies, with quantity
    + Select one movie with tty prompt
    + Confirm and user accepts selection
    + enter account id and name
    + Create rental instance
    + Change quantity available
    + Show receipt (rental-id and due-date)
    + End / Thank you 

3. New member
    + enter info
    + create membership instance
    + give id number
    + Welcome to clerkbusters! 

4. Check your membership
    + Enter name and ID to access
    + opens 2nd menu
        + Check movies currently rented by current member (check rental instance belongs to member and not completed/"returned")
        + Check history of rented movies (check rental instance belongs to member and completed/"returned")
        + active status
        + delete membership
        
5. Return Movie
    + Enter rental instance ID
    + Change the rental instance status to complete
    + Quantity goes up on inventory

6. Exit!  !!!
```

## Minimum Viable Product (MVP)

CREATE:
------
* Create membership
* Create movie	
* Create rental

READ:
----
* Membership information
* List of movies
* Due date of movies

UPDATE:	
------
* Update whether membership is active/inactive 
* Update a movie rental 
* Update movie rental (multiple copies of movies)
		
DELETE:	
------
* Delete a membership
* Delete a movie

---

## Stretch Goals (SG)

1.	Member’s rental history
2.	Link to IMDB API and retrieve reviews and/or ratings
3.	Allow members to add their own rating
4.	Add graphics - welcome screen/clerks movie reference
5.	Add sound effects for different actions (rental, denied rentals, late fees, create membership)
6.  Add rewind (boolean) check
7.  Add * rating (integer) to movie

User Stories:
------------
1. 	As a member I want to know if a movie is available.
2. 	As a member I want to know if I my account is active/has late fees.
3. 	As a member I want to know how many (or which) movies I have rented
4.	As a movie clerk, I want to checkout a movie for a customer

---

## DOMAIN MODELLING
```
MEMBERS
  |
 /|\
/ | \
RENTAL 
\ | /
 \|/
  |
MOVIE
```
---
## Tables and Columns

#### MEMBERS:
* id (integer) 
* name (text)
* age (integer)
* active (boolean)

#### RENTAL:
* member_id (integer)
* movie_id (integer)
* rental_date (date-time)
* due_date (date-time)

#### MOVIE:
* id (integer)
* title (text)
* copies (integer)
