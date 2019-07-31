#standardSQL

# dataset: `httparchive.lighthouse.2019_07_01_mobile`
# sample: `httparchive.almanac.lighthouse_mobile_1k`
# todo: APPROX_QUANTILES title + description length but must come from pages response (not lighthouse below)

CREATE TEMP FUNCTION analyse(payload STRING)
RETURNS INT64
LANGUAGE js AS """
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  if(almanac && almanac['link-nodes']) {
        var descriptionFound = almanac['meta-nodes'].find(node => {
            if(node.name && node.name.toLowerCase() == 'description') {
                return true;
            }
        });
        return descriptionFound && descriptionFound.content ? descriptionFound.content.length : 0;
  }
  return 0;
} catch (e) {
  return 0;
}
""";


SELECT
    COUNT(url) AS `total`,
    COUNT(DISTINCT url) AS `distinct_total`,

    #title
    SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.document-title.score') as NUMERIC)) AS `titleScoreSum`,
    AVG(SAFE_CAST(JSON_EXTRACT(report, '$.audits.document-title.score') as NUMERIC)) AS `titleScoreAverage`,
    (SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.document-title.score') as NUMERIC)) / COUNT(url)) as `titleScorePercentage`,

    #description
    SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.meta-description.score') as NUMERIC)) AS `descriptionScoreSum`,
    AVG(SAFE_CAST(JSON_EXTRACT(report, '$.audits.meta-description.score') as NUMERIC)) AS `descriptionScoreAverage`,
    (SUM(SAFE_CAST(JSON_EXTRACT(report, '$.audits.meta-description.score') as NUMERIC)) / COUNT(url)) as `descriptionScorePercentage`

FROM
    `httparchive.almanac.lighthouse_mobile_1k`

/* result: scorePercentage =  0.xxx% */
