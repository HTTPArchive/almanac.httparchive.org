#standardSQL
CREATE TEMPORARY FUNCTION getCustomPropertyUsage(payload STRING)
RETURNS ARRAY<STRUCT<name STRING, freq INT64>>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(vars) {
    let ret = {
      get_only: 0,
      set_only: 0,
      get_set: 0
    };

    for (let property in vars.summary) {
      let rw = vars.summary[property];

      if (rw.get.length > 0) {
        if (rw.set.length > 0) {
          ret.get_set++;
        }
        else {
          ret.get_only++;
        }
      }
      else {
        ret.set_only++;
      }
    }

    return ret;
  }
  var $ = JSON.parse(payload);
  var vars = JSON.parse($['_css-variables']);
  var custom_properties = compute(vars);
  return Object.entries(custom_properties).map(([name, freq]) => ({name, freq}))
} catch (e) {
  return null;
}
''';

SELECT
  client,
  name AS usage,
  SUM(freq) AS freq,
  SUM(SUM(freq)) OVER (PARTITION BY client) AS total,
  SUM(freq) / SUM(SUM(freq)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    usage.name,
    usage.freq
  FROM
    `httparchive.pages.2020_08_01_*`,
    UNNEST(getCustomPropertyUsage(payload)) AS usage
)
GROUP BY
  client,
  usage
ORDER BY
  pct DESC
