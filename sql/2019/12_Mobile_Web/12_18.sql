#standardSQL

# <link rel="manifest">

# dataset: `httparchive.lighthouse.2019_07_01_mobile`
# sample: `httparchive.almanac.lighthouse_mobile_1k`

CREATE TEMP FUNCTION analyse(payload STRING)
RETURNS BOOL
LANGUAGE js AS """
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  if(almanac && almanac['link-nodes']) {
        var manifestFound = almanac['link-nodes'].findIndex(node => {
            if(node.rel && node.rel.toLowerCase() == 'manifest') {
                return true;
            }
        });
        return manifestFound >= 0 ? true : false
  }
  return null;
} catch (e) {
  return null;
}
""";


SELECT
    COUNT(url) as url,
    COUNTIF(analyse(payload)) as manifestDefined,
    (COUNTIF(analyse(payload)) / COUNT(url)) as `scorePercentage`
FROM
    `httparchive.almanac.pages_desktop_1k`
