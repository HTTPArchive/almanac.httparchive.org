/*
09_04
10TB
only tested on the sample data set

count of sites that have the following attributes:

header </header>
footer </footer>
main </main>
nav   </nav>

Assumption - only looking for one instance each.  
Looking for the close tage is easier - no extra elements.

Save this in a table, and then see how many sites have header but no footer, or have nav but no main.

*/



select
url, 
if(lower(body)) nav, 
if(lower(body) like "%</main>%", 1,0) main, 
if(lower(body) like "%</header>%", 1,0) header, 
if(lower(body) like "%</footer>%", 1,0) footer
from `response_bodies.2019_07_01_mobile` 
where lower(body) like "%</nav>%"  or 
      lower(body) like "%</main>%"    or  
      lower(body) like "%</header>%" or 
      lower(body) like "%</footer>%"
