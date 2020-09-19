SELECT DISTINCT
  date,
  client,
  page,
  url,
  body
FROM (
  SELECT
    *
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2020-08-01') AS bodies
JOIN (
  SELECT
    date,
    client,
    pwa_url AS page,
    sw_url AS url
  FROM
    `httparchive.almanac.pwa_candidates`
  WHERE
    date = '2020-08-01'
  GROUP BY
    date,
    client,
    page,
    url) AS pwa
USING (
  date,
  client,
  page,
  url)