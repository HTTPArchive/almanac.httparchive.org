almanac.js queries are identified by rendered_ and body queries by raw_.

I've tried to merge as many queries as possible based on the data source and format of the results. This should make it a lot easier to manage as well as save on the number of queries made $$$

lighthouse.sql - all data from lighthouse
rendered_by_device.sql - rendered data from almanac.js grouped by device
rendered_percentiles_by_device.txt - rendered data from almanac.js reported by percentiles and grouped by device
raw_by_device.sql - data from the raw html - very expensive query when done on the real data - does not gather much at the moment. This could become our raw/rendered comparison query.

Other scripts are ones that have a unique output so can't be merged. Typically because they group by the field they are analysing.

At the moment most are pointing to test tables. But be careful. Always double check the cost before making a query as some old ones are still pointing to live tables. We could do with a test table for httparchive.almanac.summary_response_bodies as the table I'm currently testing with is in a different format.
