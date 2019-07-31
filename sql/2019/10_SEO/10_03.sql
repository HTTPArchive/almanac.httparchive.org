#standardSQL

# note: this looks like a very low count (error?)

# sample: `httparchive.almanac.pages_desktop_1k`
# dataset: `httparchive.pages.2019_07_01_desktop`

CREATE TEMP FUNCTION analyse(payload STRING)
RETURNS INT64
LANGUAGE js AS """
try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    if(almanac && almanac['link-nodes']) {
        var found = almanac['link-nodes'].findIndex(node => {
            if(node.rel && node.rel.toLowerCase() == 'amphtml') {
                return true;
            }
        });
        return found >= 0 ? 1 : 0;
    }
    return 0;
} catch (e) {
  return 0;
}
""";

SELECT
    SUM(analyse(payload)) AS `scoreSum`,
    AVG(analyse(payload)) AS `scoreAverage`,
    (SUM(analyse(payload)) / COUNT(url)) as `scorePercentage`
FROM
    `httparchive.almanac.pages_desktop_1k`
