/* Rental duration and rental rate summary for top 10 countries by total payment */

/* Step 1: Identify the top 10 countries by total customer payments */
WITH country_top_cte AS 		
	(SELECT country,	
      	COUNT(DISTINCT A.customer_id) AS customer_count,	
      	SUM(amount) AS total_payment	
	FROM customer A	
	INNER JOIN address B ON A.address_id = B.address_id	
	INNER JOIN city C ON B.city_id = C.city_id	
	INNER JOIN country D ON C.country_ID = D.country_ID	
	INNER JOIN payment E ON a.customer_id = E.customer_id	
	GROUP BY country	
	ORDER BY total_payment DESC	
	LIMIT 10)	

/* Step 2: Calculate rental and rate summary for these top countries */
SELECT		
/* rental_duration summary */		
	MIN (F.rental_duration) AS rental_duration_min,	
	MAX (F.rental_duration) AS rental_duration_max,	
	AVG (F.rental_duration) AS rental_duration_avg,	
	COUNT (F.film_id) AS rental_duration_count,	

/* rental_rate summary */		
	MIN (F.rental_rate) AS rental_rate_min,	
	MAX (F.rental_rate) AS rental_rate_max,	
	AVG (F.rental_rate) AS rental_rate_avg,	
	COUNT (F.rental_rate) AS rental_rate_count	

FROM film F		
INNER JOIN inventory G ON G.film_id = F.film_id		
INNER JOIN rental I ON I.inventory_id = G.inventory_id		
INNER JOIN customer J ON I.customer_id = J.customer_id		
INNER JOIN address K ON J.address_id = K.address_id		
INNER JOIN city L ON K.city_id = L.city_id		
INNER JOIN country M ON L.country_id = M.country_id		
	WHERE M.country IN 	
		(SELECT country FROM country_top_cte)
