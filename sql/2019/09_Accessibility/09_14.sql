/*
09_15

10TB

only tested on the 1k sample response body samples and there are only 10 examples 
retrieves all sites with aria key shortcuts finds how many on each page.
*/

select url, array_length(ariakbShortcut) ariakbShortcut
from(
select
url, 
REGEXP_EXTRACT_ALL(lower(body),r'(aria-keyshortcuts=["\']*[^\s\'"]*["\']*)') ariakbShortcut

from `response_bodies.2019_07_01_mobile` 
where lower(body) like "%aria-keyshortcuts%"
) where array_length(ariakbShortcut) >0
order by array_length(ariakbShortcut) desc