CREATE TEMP FUNCTION GET_SHADOWROOT_ATTR(templates STRING) RETURNS ARRAY<STRING> LANGUAGE js AS r'''
try {
  templates = JSON.parse(templates);
  return templates.filter(t => {
    return 'shadowroot' in t;
  }).map(t => {
    return t.shadowroot;
  });
} catch {
  return [];
}
''';

WITH templates AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    JSON_EXTRACT(JSON_VALUE(payload, '$._wpt_bodies'), '$.web_components.raw.hyphenatedElements.templates') AS template
  FROM
    `httparchive.pages.2022_06_01_*`
)

SELECT
  client,
  url,
  attr
FROM
  templates,
  UNNEST(GET_SHADOWROOT_ATTR(template)) AS attr
