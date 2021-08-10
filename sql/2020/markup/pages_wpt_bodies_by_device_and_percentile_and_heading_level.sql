#standardSQL
# M221

# returns all the data we need from _wpt_bodies
CREATE TEMPORARY FUNCTION get_heading_info(wpt_bodies_string STRING)
RETURNS ARRAY<STRUCT<
heading STRING,
total INT64
>> LANGUAGE js AS '''
var result = [];
try {
    var wpt_bodies = JSON.parse(wpt_bodies_string);

    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.headings && wpt_bodies.headings.rendered) {
      ["h1", "h2", "h3", "h4", "h5", "h6", "h7", "h8"].forEach(h => {
        if (wpt_bodies.headings.rendered[h]) result.push({heading: h, total: wpt_bodies.headings.rendered[h].total});
      });
    }
} catch (e) {}
return result;
''';

SELECT
  heading,
  percentile,
  client,
  COUNT(DISTINCT url) AS total,

  APPROX_QUANTILES(total, 1000)[OFFSET(percentile * 10)] AS heading_count

FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    percentile,
    heading_info.heading AS heading,
    heading_info.total AS total,
    url
  FROM
  `httparchive.pages.2020_08_01_*`,
  UNNEST([10, 25, 50, 75, 90]) AS percentile,
  UNNEST(get_heading_info(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies'))) AS heading_info
)
GROUP BY
  heading,
  percentile,
  client
ORDER BY
  heading,
  percentile,
  client
