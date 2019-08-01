/*
standard sql
09_09

10TB

only tested on the sample response body samples
presence of lang attribute
this grabs the lang tag hout o fthe html header, and then works to remove the lang=, and "" from the language.
then it orders the languages by appearance in the dataset

_09_08 is looking for a cations track... added to this query  
*/

select lower(langtag), count(*) cnt from(
select url, trim(ltrim(regexp_extract(htmlopentag, r'(lang=.*? )'),"lang="), '"') langtag
from(
select
url, REGEXP_EXTRACT(lower(body),r'(<html.*?lang=.*?>)') htmlopentag
from `response_bodies.2019_07_01_mobile` videotagset
where lower(body) like "%lang=%"
))
group by langtag
order by cnt desc