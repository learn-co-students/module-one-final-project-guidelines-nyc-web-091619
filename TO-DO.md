1. Create Seed Data (movies, members)
2. Create tables (members, rentals, movies)

```
INSERT into members (name, age, active)
INSERT into rentals (member_id, movie_id, rental_date, due_date)
INSERT into movies (title, year, no_of_copies)
```
---

### Members methods:
* #create - create a new member
* #member_info/check_balance - 
* #delete_member
* #suspend_account
* .members (list @@all)

### Rental methods:
* #return_movie
* #checkout_movie
* .overdue - lists overdue movies
* .rentals (list @@all)

### Movies methods:
* #create_movie - new entry
* #delete_movie
* #update_movie - edit current entry
* .movies (list @@all)

---
