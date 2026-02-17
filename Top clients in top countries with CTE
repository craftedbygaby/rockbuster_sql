/* Identification of the top 5 customers within the top 10 countries and cities */

/* Step 1: Identify the top 10 countries by number of customers */
WITH country_cte (country) AS				
	(SELECT D. country			
		FROM customer A		
		INNER JOIN address B ON A.address_id = B.address_id 		
		INNER JOIN city C ON B.city_id = C.city_id		
		INNER JOIN country D ON C.country_id = D.country_id		
		GROUP BY country		
		ORDER BY COUNT (customer_id) DESC		
		LIMIT 10),		

/* Step 2: Identify the top 10 cities within those top countries */
	city_cte (country, city) AS			
	(SELECT D.country, C.city			
	FROM customer A			
	INNER JOIN address B ON A.address_id = B.address_id 			
	INNER JOIN city C ON B.city_id = C.city_id			
	INNER JOIN country D ON C.country_id = D.country_id			
	WHERE D.country IN 			
		(SELECT country FROM country_cte)		
	GROUP BY D.country, C.city			
	ORDER BY COUNT (customer_id) DESC			
	LIMIT 10)			

/* Step 3: Select top 5 customers by total spending in those top cities */
SELECT 				
		A. customer_id,		
		A. first_name,		
		A. last_name,		
		C. city,		
		D. country,		
	SUM (amount) 			
	FROM customer A			
	INNER JOIN address B ON A.address_id = B.address_id 			
	INNER JOIN city C ON B.city_id = C.city_id			
	INNER JOIN country D ON C.country_id = D.country_id			
	INNER JOIN payment E ON A.customer_id = E.customer_id			
	WHERE EXISTS 			
 		(SELECT *		
        FROM city_cte F				
        WHERE F.country = D.country				
        AND F.city = C.city)				
	GROUP BY A. customer_id, C. city, D. country			
	ORDER BY SUM(amount) DESC			
	LIMIT 5			
