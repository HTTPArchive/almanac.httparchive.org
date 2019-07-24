#standardSQL
CREATE TEMP FUNCTION analyse(almanacPayload STRING)
RETURNS INT64
LANGUAGE js AS """
var arr = JSON.parse(almanacPayload);
if(arr && arr['link-nodes']) {
    var meta = arr['meta-nodes'].find(node => {
        if(node.name && node.name.toLowerCase() == 'description') {
            return true;
        }
    });
    return meta && meta.content ? meta.content.length : 0;
}
return 0;
""";


SELECT
    COUNT(url) AS `total`,
    COUNT(DISTINCT url) AS `distinct_total`,

    #title
    SUM(CAST(JSON_EXTRACT(report, '$.audits.document-title.score') as NUMERIC)) AS `titleScoreSum`,
    AVG(CAST(JSON_EXTRACT(report, '$.audits.document-title.score') as NUMERIC)) AS `titleScoreAverage`,
    (SUM(CAST(JSON_EXTRACT(report, '$.audits.document-title.score') as NUMERIC)) / COUNT(url)) as `titleScorePercentage`,

    #description
    SUM(CAST(JSON_EXTRACT(report, '$.audits.meta-description.score') as NUMERIC)) AS `descriptionScoreSum`,
    AVG(CAST(JSON_EXTRACT(report, '$.audits.meta-description.score') as NUMERIC)) AS `descriptionScoreAverage`,
    (SUM(CAST(JSON_EXTRACT(report, '$.audits.meta-description.score') as NUMERIC)) / COUNT(url)) as `descriptionScorePercentage`,

    #length (only when length > 0)
    (SUM(analyse(JSON_EXTRACT(payload, '$._almanac'))) / COUNTIF(analyse(JSON_EXTRACT(payload, '$._almanac')) > 0)) as `metaLengthAverage`

    # todo, length average length <title>
FROM
    `httparchive.lighthouse.2019_07_01_mobile`

/* result: scorePercentage =  0.xxx% */
