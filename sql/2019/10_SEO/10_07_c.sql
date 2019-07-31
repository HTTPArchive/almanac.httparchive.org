#standardSQL

# <meta description> length

# dataset: `httparchive.lighthouse.2019_07_01_mobile`
# sample: `httparchive.almanac.lighthouse_mobile_1k`

CREATE TEMP FUNCTION analyse(payload STRING)
RETURNS STRING
LANGUAGE js AS """
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  if(almanac && almanac['meta-nodes']) {
        var descriptionFound = almanac['meta-nodes'].find(node => {
            if(node.name && node.name.toLowerCase() == 'description') {
                return true;
            }
        });
        return descriptionFound && descriptionFound.content ? descriptionFound.content : null;
  }
  return null;
} catch (e) {
  return null;
}
""";


SELECT
    APPROX_QUANTILES(CHAR_LENGTH(analyse(payload)), 1000)[OFFSET(250)] as quantP25TitleLength,
    APPROX_QUANTILES(CHAR_LENGTH(analyse(payload)), 1000)[OFFSET(500)] as quantMedianTitleLength,
    APPROX_QUANTILES(CHAR_LENGTH(analyse(payload)), 1000)[OFFSET(750)] as quantP75TitleLength,
    AVG(CHAR_LENGTH(analyse(payload))) as avgTitleLength
FROM
    `httparchive.almanac.pages_desktop_1k`

/* result: scorePercentage =  0.xxx% */
