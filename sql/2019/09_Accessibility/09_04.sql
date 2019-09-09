#StandardSQL
/*
09_04
10TB
only tested on the sample data set

COUNT of sites that have the following attributes:

header </header>
footer </footer>
main </main>
nav   </nav>

AsSUMption - only looking for one instance each.  
Looking for the close tage is easier - no extra elements.

Save this in a table, AND then see how many sites have header but no footer, OR  have nav but no main.

*/



SELECT
url, 
IF(LOWER(body)) nav, 
IF(LOWER(body) LIKE "%</main>%", 1,0) main, 
IF(LOWER(body) LIKE "%</header>%", 1,0) header, 
IF(LOWER(body) LIKE "%</footer>%", 1,0) footer
FROM `response_bodies.2019_07_01_*` 
WHERE LOWER(body) LIKE "%</nav>%"  OR  
      LOWER(body) LIKE "%</main>%"    OR   
      LOWER(body) LIKE "%</header>%" OR  
      LOWER(body) LIKE "%</footer>%"
