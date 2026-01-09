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
    COUNT(0) OVER (PARTITION BY CLIENT) AS total_st, # Total number of ST header, if a response has more than one ST header each of them is counted
    COUNT(DISTINCT NET.HOST(url)) OVER (PARTITION BY CLIENT) AS total_st_hosts,
    response_headers.value AS server_timing_header,
    JSON_EXTRACT(parseServerTiming(response_headers.value), '$.metric_names') AS metric_names,
    JSON_EXTRACT(parseServerTiming(response_headers.value), '$.dur') AS dur,
    JSON_EXTRACT(parseServerTiming(response_headers.value), '$.desc') AS desc1
  FROM
    `httparchive.all.requests`,
    # `httparchive.sample_data.requests_1k`,
    UNNEST(response_headers) AS response_headers
  WHERE
    date = '2024-06-01' AND
    is_root_page AND
    LOWER(response_headers.name) = 'server-timing'
),

st_details AS (
  SELECT
    client,
    host,
    server_timing_header,
    total_st,
    total_st_hosts,
    metric_name,
    dur,
    desc1
  FROM
    parsed_server_timing,
    UNNEST(JSON_EXTRACT_ARRAY(metric_names)) AS metric_name WITH OFFSET idx,
    UNNEST(JSON_EXTRACT_ARRAY(dur)) AS dur WITH OFFSET idx_dur,
    UNNEST(JSON_EXTRACT_ARRAY(desc1)) AS desc1 WITH OFFSET idx_desc
  WHERE
    idx = idx_dur AND
    idx = idx_desc
),

totals AS (
  SELECT
    client,
    COUNT(0) AS total,
    COUNT(DISTINCT NET.HOST(url)) AS total_hosts
  FROM
    `httparchive.all.requests`
  # `httparchive.sample_data.requests_1k`
  WHERE
    date = '2024-06-01' AND
    is_root_page
  GROUP BY
    client
)

# Most common headers
# (Data already has one row for each metric (header split at comma) thus some headers occur multiple times)
/*
SELECT
  client,
  server_timing_header,
  metric_name,
  dur,
  desc1,
  total AS total_responses,
  total_hosts,
  total_st,
  total_st_hosts,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_st_metrics, # Counts the total number of metrics
  total_st / total AS pct_server_timing,
  total_st_hosts / total_hosts AS pct_server_timing_hosts,
  COUNT(DISTINCT host) AS freq_host,
  COUNT(0) AS freq_req,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_value, # How common this exact "row" (i.e., server_timing_header or metric_name or dur or desc) is
  COUNT(DISTINCT host) / total_st_hosts AS pct_hosts, # What is the percentage of hosts of all hosts that have a ST header that belong to this row's group
FROM st_details
  JOIN totals USING (client)
GROUP BY
  client,
  total,
  total_st,
  total_st_hosts,
  total_hosts,
  server_timing_header,
  metric_name,
  dur,
  desc1
ORDER BY
  pct_value DESC
LIMIT
  100
*/

# Most common metric names
/*
SELECT
  client,
  metric_name,
  total AS total_responses,
  total_hosts,
  total_st,
  total_st_hosts,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_st_metrics, # Counts the total number of metrics
  total_st / total AS pct_server_timing,
  total_st_hosts / total_hosts AS pct_server_timing_hosts,
  COUNT(DISTINCT host) AS freq_host,
  COUNT(0) AS freq_req,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_value, # How common this exact "row" (i.e., server_timing_header or metric_name or dur or desc) is
  COUNT(DISTINCT host) / total_st_hosts AS pct_hosts, # What is the percentage of hosts of all hosts that have a ST header that belong to this row's group
FROM st_details
  JOIN totals USING (client)
GROUP BY
  client,
  total,
  total_st,
  total_st_hosts,
  total_hosts,
  metric_name
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
  total_hosts,
  total_st,
  total_st_hosts,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_st_metrics, # Counts the total number of metrics
  total_st / total AS pct_server_timing,
  total_st_hosts / total_hosts AS pct_server_timing_hosts,
  COUNT(DISTINCT host) AS freq_host,
  COUNT(0) AS freq_req,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_value, # How common this exact "row" (i.e., server_timing_header or metric_name or dur or desc) is
  COUNT(DISTINCT host) / total_st_hosts AS pct_hosts, # What is the percentage of hosts of all hosts that have a ST header that belong to this row's group
FROM st_details
  JOIN totals USING (client)
GROUP BY
  client,
  total,
  total_st,
  total_st_hosts,
  total_hosts,
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
  total_hosts,
  total_st,
  total_st_hosts,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_st_metrics, # Counts the total number of metrics
  total_st / total AS pct_server_timing,
  total_st_hosts / total_hosts AS pct_server_timing_hosts,
  COUNT(DISTINCT host) AS freq_host,
  COUNT(0) AS freq_req,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_value, # How common this exact "row" (i.e., server_timing_header or metric_name or dur or desc) is
  COUNT(DISTINCT host) / total_st_hosts AS pct_hosts, # What is the percentage of hosts of all hosts that have a ST header that belong to this row's group
FROM st_details
  JOIN totals USING (client)
GROUP BY
  client,
  total,
  total_st,
  total_st_hosts,
  total_hosts,
  desc1
ORDER BY
  pct_value DESC
LIMIT
  100
*/

# General query: Total #Responses (Requests), #With header, #With any dur, #With 1xdur, #With 2x dur, #With >=3x dur, #With any desc, #Average number of metrics, #....
SELECT
  client,
  total AS total_responses,
  total_hosts,
  total_st,
  total_st_hosts,
  COUNT(0) AS total_st_metrics, # Counts the total number of metrics
  total_st / total AS pct_server_timing,
  total_st_hosts / total_hosts AS pct_server_timing_hosts,
  COUNTIF(dur != 'null') AS freq_dur,
  COUNTIF(desc1 != 'null') AS freq_desc,
  COUNTIF(dur != 'null') / COUNT(0) AS pct_dur,
  COUNTIF(desc1 != 'null') / COUNT(0) AS pct_desc,
  hosts_at_least_1_dur,
  hosts_1_durs,
  hosts_2_durs,
  hosts_more_than_2_durs,
  hosts_avg_distinct_durs,
  hosts_avg_durs,
  hosts_avg_descs,
  hosts_avg_metrics,
  hosts_at_least_1_desc
FROM (
  SELECT
    client,
    COUNT(DISTINCT CASE WHEN dur_count >= 1 THEN host ELSE NULL END) AS hosts_at_least_1_dur,
    COUNT(DISTINCT CASE WHEN dur_count = 1 THEN host ELSE NULL END) AS hosts_1_durs,
    COUNT(DISTINCT CASE WHEN dur_count = 2 THEN host ELSE NULL END) AS hosts_2_durs,
    COUNT(DISTINCT CASE WHEN dur_count >= 3 THEN host ELSE NULL END) AS hosts_more_than_2_durs,
    AVG(dur_distinct) AS hosts_avg_distinct_durs,
    AVG(dur_count) AS hosts_avg_durs, # Average of all hosts that have a least one ST header, they might have 0 ST headers with an metric with a dur content
    AVG(row_count) AS hosts_avg_metrics,
    AVG(desc_count) AS hosts_avg_descs,
    COUNT(DISTINCT CASE WHEN desc_count >= 1 THEN host ELSE NULL END) AS hosts_at_least_1_desc
  FROM (
    SELECT
      client,
      host,
      COUNTIF(dur != 'null') AS dur_count,
      COUNT(DISTINCT dur) AS dur_distinct, # Counts 'null' as one distinct value?
      COUNTIF(desc1 != 'null') AS desc_count,
      COUNT(0) AS row_count
    FROM st_details
    GROUP BY client, host
  ) GROUP BY client
)
JOIN st_details USING (client)
JOIN totals USING (client)
GROUP BY
  client,
  total,
  total_st,
  total_st_hosts,
  total_hosts,
  hosts_at_least_1_dur,
  hosts_1_durs,
  hosts_2_durs,
  hosts_more_than_2_durs,
  hosts_avg_distinct_durs,
  hosts_avg_durs,
  hosts_avg_descs,
  hosts_avg_metrics,
  hosts_at_least_1_desc
