#StandardSQL
/*
09_06
10TB
only tested on the sample data set

extracts all id="*" fields FROM every website.  
flattens the dataset, AND then COUNTs for duplicates.
The final result shows how many IDs appear COUNTer times on the page
using the sample_data.response_bodies_mobile_10k
there are 777,252 ids that occur just once
           51,450 ids that appear twice (on one page)
           13,978 appear 3x
           AND so on
           
           a googlead ID appears 5560 times on 3 different sides

*/

SELECT COUNTer, COUNT (*) FROM(

SELECT url, flat_ids , COUNT(flat_ids) COUNTer FROM(
SELECT
url, regexp_extract_all(LOWER(body),r'(id=["\']*[^\s\'"]*["\']*)') ids
FROM `response_bodies.2019_07_01_*` 
WHERE LOWER(body) LIKE "%id=%"  )
CROSS JOIN UNNEST(ids) flat_ids
GROUP BY url, flat_ids
ORDER BY COUNTer desc

)
GROUP BY COUNTer
ORDER BY COUNTer asc