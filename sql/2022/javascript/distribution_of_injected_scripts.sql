#standardSQL
# Number of injected scripts per page.
# Pages without any scripts are excluded

# returns the number of injected scripts and inline
CREATE TEMPORARY FUNCTION getScripts(payload STRING)
RETURNS STRUCT<documentScripts INT64, documentInline INT64, scripts INT64, inline INT64, injectedScripts INT64, injectedInline INT64>
LANGUAGE js AS '''
try {
  const $ = JSON.parse(payload);
  const javascript = JSON.parse($._javascript);

  if (javascript) {
    // server-generated scripts
    const { scripts, inlineScripts } = javascript.document;

    // all scripts including injected scripts
    const { inline, src } = javascript.script_tags;

    return ({
      documentScripts: scripts,
      documentInline: inlineScripts,
      scripts: src,
      inline: inline,
      injectedScripts: src - scripts,
      injectedInline: inline - inlineScripts
    });
  }

  return null;
} catch (e) {
  return null;
}
''';

SELECT
  client,
  percentile,
  APPROX_QUANTILES(IF(scripts.scripts > 0, scripts.injectedScripts / scripts.scripts, 0), 1000)[OFFSET(percentile * 10)] AS pct_injected_scripts_per_page
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    getScripts(payload) AS scripts
  FROM
    `httparchive.pages.2022_06_01_*`
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  scripts IS NOT NULL
GROUP BY
  percentile,
  client
ORDER BY
  client,
  percentile
