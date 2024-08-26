#standardSQL
# Section: Security misconfigurations and oversights - (Missing) suppression of 'Server-Timing' header
# Question: Which are the most common server-timing headers and how often are they used in total?
# Note: Probably better to split some of the things up to make the interpretation of the results easier
# Note: Server-Timing sent to same-origin/top-level requests is not an issue, maybe only look at non first-party requests?
CREATE TEMPORARY FUNCTION parseServerTiming(server_timing STRING)
RETURNS STRING DETERMINISTIC
LANGUAGE js AS '''
  if (!server_timing) {
    return server_timing;
  }
  const result = {
    "metric_names": [],
    "dur": [],
    "desc": [],
  };

  server_timing.split(",").forEach(st => {
    let name = null;
    let dur = null;
    let desc = null;

    st.split(";").forEach(prop => {
      let [key, ...valueParts] = prop.split("=");
      key = key.trim();
      const value = valueParts.join("="); // Join the remaining parts to handle multiple '=' signs

      if (!name) {
        name = key; // The first property is assumed to be the name
      } else if (key === "dur") {
        dur = value;
      } else if (key === "desc") {
        desc = value;
      } else {
        // Invalid or unhandled property
      }
    });

    result["metric_names"].push(name);
    result["dur"].push(dur);
    result["desc"].push(desc);
  });

  return JSON.stringify(result);

''';
  
WITH parsed_server_timing AS (
  SELECT
    client,
    NET.HOST(url) AS host,
    response_headers.value AS server_timing_header,
    JSON_EXTRACT(parseServerTiming(response_headers.value), "$.metric_names") AS metric_names,
    JSON_EXTRACT(parseServerTiming(response_headers.value), "$.dur") AS dur,
    JSON_EXTRACT(parseServerTiming(response_headers.value), "$.desc") AS desc1
  FROM
    `httparchive.all.requests`,
    UNNEST(response_headers) AS response_headers
  WHERE
    date = '2024-06-01'
    AND is_root_page
    AND LOWER(response_headers.name) = 'server-timing'
), st_details AS (
SELECT
  client,
  host,
  server_timing_header,
  metric_name,
  dur,
  desc1
FROM
  parsed_server_timing,
  UNNEST(JSON_EXTRACT_ARRAY(metric_names)) AS metric_name WITH OFFSET idx,
  UNNEST(JSON_EXTRACT_ARRAY(dur)) AS dur WITH OFFSET idx_dur,
  UNNEST(JSON_EXTRACT_ARRAY(desc1)) AS desc1 WITH OFFSET idx_desc
WHERE
  idx = idx_dur
  AND idx = idx_desc
), totals AS (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    is_root_page
  GROUP BY
    client
)

# Most common headers
SELECT
  client,
  server_timing_header,
  total AS total_responses,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS total_server_timing_headers,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) / total AS pct_server_timing,
  COUNT(DISTINCT host) AS freq,
  COUNT(host) AS freq_non_unique,
  COUNT(DISTINCT host) / SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS pct_value,
  metric_name,
  dur,
  desc1,
FROM st_details
  JOIN totals USING (client)
GROUP BY
  client,
  total,
  server_timing_header,
  metric_name,
  dur,
  desc1
ORDER BY
  pct_value DESC
LIMIT
  100

# Most common metric names
/*
SELECT
  client,
  metric_name
  total AS total_responses,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS total_server_timing_headers,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) / total AS pct_server_timing,
  COUNT(DISTINCT host) AS freq,
  COUNT(host) AS freq_non_unique,
  COUNT(DISTINCT host) / SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS pct_value,
FROM st_details
  JOIN totals USING (client)
GROUP BY
  client,
  total,
  metric_name,
ORDER BY
  pct_value DESC
LIMIT
  100
*/

# Most common dur properties
/*
SELECT
  client,
  dur,
  total AS total_responses,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS total_server_timing_headers,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) / total AS pct_server_timing,
  COUNT(DISTINCT host) AS freq,
  COUNT(host) AS freq_non_unique,
  COUNT(DISTINCT host) / SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS pct_value,
FROM st_details
  JOIN totals USING (client)
GROUP BY
  client,
  total,
  dur
ORDER BY
  pct_value DESC
LIMIT
  100
*/

# Most common descriptions
/*
SELECT
  client,
  desc1,
  total AS total_responses,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS total_server_timing_headers,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) / total AS pct_server_timing,
  COUNT(DISTINCT host) AS freq,
  COUNT(host) AS freq_non_unique,
  COUNT(DISTINCT host) / SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS pct_value,

FROM st_details
  JOIN totals USING (client)
GROUP BY
  client,
  total,
  desc1
ORDER BY
  pct_value DESC
LIMIT
  100
*/

# General query: Total #Pages, #With header, #With any dur, #With 1xdur, #With 2x dur, #With 3x dur, #With >3x dur, #With any desc, #Average number of metrics, #....
# WIP improve this
/*
SELECT
  client,
  total AS total_responses,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS total_server_timing_headers,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) / total AS pct_server_timing,
  COUNT(DISTINCT host) AS freq,
  COUNT(host) AS freq_non_unique,
  COUNT(DISTINCT host) / SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS pct_value,
FROM st_details
  JOIN totals USING (client)
GROUP BY
  client,
ORDER BY
  pct_value DESC
LIMIT
  100
*/
