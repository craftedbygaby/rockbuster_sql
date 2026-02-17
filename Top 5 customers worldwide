/* Top 5 customers by total spending */

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
GROUP BY A. customer_id, C. city, D. country		
ORDER BY SUM(amount) DESC		
LIMIT 5		
