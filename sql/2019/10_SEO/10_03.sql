#standardSQL
CREATE TEMP FUNCTION analyse(almanacPayload STRING)
RETURNS INT64
LANGUAGE js AS """
var arr = JSON.parse(almanacPayload);
if(arr && arr['link-nodes']) {
    var found = arr['link-nodes'].findIndex(node => {
        if(node.rel && node.rel.toLowerCase() == 'amphtml') {
            return true;
        }
    });
    return found > 0 ? 1 : 0;
}
return 0;
""";

SELECT

    SUM(analyse(JSON_EXTRACT(payload, '$._almanac'))) AS `scoreSum`,
    AVG(analyse(JSON_EXTRACT(payload, '$._almanac'))) AS `scoreAverage`,
    (SUM(analyse(JSON_EXTRACT(payload, '$._almanac'))) / COUNT(url)) as `scorePercentage`
FROM
    `httparchive.pages.2019_07_01_desktop`
