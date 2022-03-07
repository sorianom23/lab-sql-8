
-- Lab | SQL Join (Part II) --

USE sakila;

-- 1. Write a query to display for each store its store ID, city, and country.

select s.store_id as 'Store ID', a.city_id as 'City', co.country as 'Country' from sakila.store as s
join sakila.address as a
on s.address_id = a.address_id
join city as ci
on a.city_id = ci.city_id
join country as co
on ci.country_id = co.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.

select s.store_id, count(p.amount) from sakila.store as s
join sakila.inventory as i
on s.store_id = i.store_id
join sakila.payment as p
group by s.store_id;

-- 3. Which film categories are longest?

select c.name, f.length from sakila.category as c
join sakila.film_category as fc
on c.category_id = fc.category_id
join sakila.film as f
on fc.film_id = f.film_id
group by c.name
order by length desc;

-- 4. Display the most frequently rented movies in descending order.

select * from sakila.rental;
select * from sakila.inventory;
select * from sakila.film;

select f.film_id as 'ID', f.title as 'Title', count(r.rental_id) as Count from sakila.rental as r
join sakila.inventory as i
on r.inventory_id = i.inventory_id
join sakila.film as f
on i.film_id = f.film_id
group by f.film_id
order by Count desc;


-- 5. List the top five genres in gross revenue in descending order.

select c.name, sum(amount) as Revenue from sakila.rental as r
join sakila.payment as p
on r.rental_id = p.rental_id
join sakila.inventory as i
on r.inventory_id = i.inventory_id
join sakila.film_category as fc
on i.film_id = fc.film_id
join sakila.category as c
on fc.category_id = c.category_id
group by c.name
order by Revenue desc
limit 5;


-- 6. Is "Academy Dinosaur" available for rent from Store 1?

select f.film_id, f.title, i.last_update from sakila.inventory as i
join sakila.film as f
on i.film_id = f.film_id
where (title = 'ACADEMY DINOSAUR') & (store_id = 1);

-- 7. Get all pairs of actors that worked together.

select f.title, a.first_name as ActorName, a.last_name as LastName
from sakila.film_actor as fc
join sakila.actor as a
on fc.actor_id = a.actor_id
join sakila.film as f
on fc.film_id = f.film_id
order by fc.film_id;

-- 9. For each film, list actor that has acted in more films.

select f.title, a.actor_id, a.first_name, a.last_name, count(f.film_id) over (partition by f.title) as "FilmCount"
from sakila.actor as a
join sakila.film_actor as fa
on a.actor_id = fa.actor_id
join sakila.film as f
on fa.film_id = f.film_id;

