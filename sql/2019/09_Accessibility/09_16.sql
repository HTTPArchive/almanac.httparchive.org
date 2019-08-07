#standardsql
/*
09_15

10TB

only tested on the 10k sample response body samples
look for all input fields.
then also look for input fields with 'aria-required' OR  'aria-invalid'
get quantiles AND SUM of total inputs

*/
SELECT APPROX_QUANTILES(ariarequired, 5) AS ariareqquantiles,
       APPROX_QUANTILES(ariainvalid, 5)  AS  ariainvalidquantiles,
       APPROX_QUANTILES(allinputs, 5)  AS  allinputsquantiles,
       SUM(ariarequired)  AS requiredSUM,
       SUM(ariainvalid)  AS ariainvalidSUM,
       SUM(allinputs)  AS allinputsSUM

FROM(
SELECT url, ARRAY_LENGTH(ariarequired)  AS ariarequired,
            ARRAY_LENGTH(ariainvalid)  AS ariainvalid,
            ARRAY_LENGTH(allinputs) AS  allinputs
FROM(
SELECT
url, 
REGEXP_EXTRACT_ALL(LOWER(body),r'(<input.*aria-required.*/>)')  AS ariarequired,
REGEXP_EXTRACT_ALL(LOWER(body),r'(<input.*aria-invalid.*/>)')  AS ariainvalid,
REGEXP_EXTRACT_ALL(LOWER(body),r'(<input.*/>)')  AS allinputs
FROM `response_bodies.2019_07_01_*` 
WHERE LOWER(body) LIKE "%<input%"
))