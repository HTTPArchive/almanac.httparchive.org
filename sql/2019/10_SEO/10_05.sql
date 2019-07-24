#standardSQL

#ld+json, microformatting, schema.org + what @type

CREATE TEMP FUNCTION analyse(almanacPayload STRING)
RETURNS INT64
LANGUAGE js AS """
var arr = JSON.parse(almanacPayload);
if(arr && arr['10.5']) {

}
return 0;
""";

# UNNEST and count :)

SELECT
    analyse(JSON_EXTRACT(payload, '$._almanac')) AS `analyseResult`
FROM
    `httparchive.pages.2019_07_01_desktop`
GROUP BY
    JSON_EXTRACT(JSON_EXTRACT(payload, '$._almanac'), '$."10.05"')
