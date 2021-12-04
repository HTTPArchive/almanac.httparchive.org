#standardSQL
# percientile data from almanac per device

# live run estimated $4.08 and took 2 min 28 sec

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION get_almanac_info(almanac_string STRING)
RETURNS STRUCT<
  scripts_total INT64,
  none_jsonld_scripts_total INT64,
  src_scripts_total INT64,
  inline_scripts_total INT64
> LANGUAGE js AS '''
var result = {};
try {
    var almanac = JSON.parse(almanac_string);

    if (Array.isArray(almanac) || typeof almanac != 'object') return result;

    if (almanac.scripts) {
      result.scripts_total = almanac.scripts.total;
      if (almanac.scripts.nodes) {
        result.none_jsonld_scripts_total = almanac.scripts.nodes.filter(n => !n.type || n.type.trim().toLowerCase() !== 'application/ld+json').length;
        result.src_scripts_total = almanac.scripts.nodes.filter(n => n.src && n.src.trim().length > 0).length;

        result.inline_scripts_total = result.none_jsonld_scripts_total - result.src_scripts_total;
      }
    }

} catch (e) {}
return result;
''';

SELECT
  percentile,
  client,
  COUNT(DISTINCT url) AS total,

  # scripts per page
  APPROX_QUANTILES(almanac_info.none_jsonld_scripts_total, 1000)[OFFSET(percentile * 10)] AS none_jsonld_scripts_count_m205,

  # inline scripts ex jsonld
  APPROX_QUANTILES(almanac_info.inline_scripts_total, 1000)[OFFSET(percentile * 10)] AS inline_scripts_count_m207,

  # src scripts
  APPROX_QUANTILES(almanac_info.src_scripts_total, 1000)[OFFSET(percentile * 10)] AS src_scripts_count_m209

FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    percentile,
    url,
    get_almanac_info(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS almanac_info
  FROM
    `httparchive.pages.2020_08_01_*`,
    UNNEST([10, 25, 50, 75, 90]) AS percentile
)
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
