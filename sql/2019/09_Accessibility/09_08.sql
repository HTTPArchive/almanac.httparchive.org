#StandardSQL
/*
standard sql
09_09

10TB

only tested on the sample response body samples
presence of lang attribute
this grabs the lang tag hout o fthe html header, AND then works to remove the lang=, AND "" FROM the language.
then it ORDERs the languages by appearance in the dataset

_09_08 is looking for a cations track... added to this query  
*/

SELECT LOWER(langtag), COUNT(*) cnt FROM(
SELECT url, trim(ltrim(regexp_extract(htmlopentag, r'(lang=.*? )'),"lang="), '"') langtag
FROM(
SELECT
url, REGEXP_EXTRACT(LOWER(body),r'(<html.*?lang=.*?>)') htmlopentag
FROM `response_bodies.2019_07_01_mobile` videotagset
WHERE LOWER(body) LIKE "%lang=%"
))
GROUP BY langtag
ORDER BY cnt desc