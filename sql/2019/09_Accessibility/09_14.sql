#StandardSQL
/*
09_15

10TB

only tested on the 1k sample response body samples AND there are only 10 examples 
retrieves all sites with aria key shortcuts finds how many on each page.
*/

SELECT url, ARRAY_LENGTH(ariakbShortcut) AS ariakbShortcut
FROM(
SELECT
url, 
REGEXP_EXTRACT_ALL(LOWER(body),r'(aria-keyshortcuts=["\']*[^\s\'"]*["\']*)') ariakbShortcut

FROM `response_bodies.2019_07_01_*` 
WHERE LOWER(body) LIKE "%aria-keyshortcuts%"
) WHERE ARRAY_LENGTH(ariakbShortcut) >0
ORDER BY ARRAY_LENGTH(ariakbShortcut) desc