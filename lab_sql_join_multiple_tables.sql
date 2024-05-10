-- Write a query to display for each store its store ID, city, and country.
select st.store_id, ct.city, co.country
from sakila.store st
left join sakila.address ad
on st.address_id = ad.address_id
left join sakila.city ct
on ad.city_id = ct.city_id
left join sakila.country co
on ct.country_id = co.country_id;

-- Write a query to display how much business, in dollars, each store brought in.
select st.store_id, sum(p.amount) as 'business_dollars'
from sakila.payment p
left join sakila.staff sf
on p.staff_id = sf.staff_id
left join sakila.store st
on sf.store_id = st.store_id
group by 1
order by 2;

-- What is the average running time of films by category?
select ca.category_id, ca.name as 'category', avg(f.length) as 'average running time' 
from sakila.category ca
left join sakila.film_category fc
on ca.category_id = fc.category_id
left join sakila.film f
on fc.film_id = f.film_id
group by 1, 2
order by 1;

-- Which film categories are longest?
select ca.category_id, ca.name as 'category', sum(f.length) as 'total running time' 
from sakila.category ca
left join sakila.film_category fc
on ca.category_id = fc.category_id
left join sakila.film f
on fc.film_id = f.film_id
group by 1, 2
order by 3 desc;

select ca.category_id, ca.name as 'category', max(f.length) as 'longest film length' 
from sakila.category ca
left join sakila.film_category fc
on ca.category_id = fc.category_id
left join sakila.film f
on fc.film_id = f.film_id
group by 1, 2
order by 3 desc;

-- Display the most frequently rented movies in descending order.
select f.film_id, f.title, count(r.rental_id) as 'number of rentals'
from sakila.film f
left join sakila.inventory inv
on f.film_id = inv.film_id
left join sakila.rental r
on inv.inventory_id = r.inventory_id
group by 1, 2
order by 3 desc;

-- List the top five genres in gross revenue in descending order.
select ca.category_id, ca.name as 'category', sum(p.amount) as 'total gross revenue' 
from sakila.category ca
left join sakila.film_category fc
on ca.category_id = fc.category_id
left join sakila.film f
on fc.film_id = f.film_id
left join sakila.inventory inv
on f.film_id = inv.film_id
left join sakila.rental r
on inv.inventory_id = r.inventory_id
left join sakila.payment p
on r.rental_id = p.rental_id
group by 1, 2
order by 3 desc
limit 5;

-- Is "Academy Dinosaur" available for rent from Store 1? -- YES
select f.title, st.store_id, count(inv.inventory_id) as 'copies available'
from sakila.film f
left join sakila.inventory inv
on f.film_id = inv.film_id
left join sakila.store st
on inv.store_id = st.store_id
where f.title = 'Academy Dinosaur'
group by 1,2;