#standardSQL
SELECT
  client,
  parsed_stylesheets,
  total_stylesheets,
  parsed_stylesheets / total_stylesheets AS pct_parsed
FROM (
  SELECT
    client,
    COUNT(0) AS total_stylesheets
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
    type = 'css'
  GROUP BY
    client)
JOIN (
  SELECT
    client,
    COUNT(0) AS parsed_stylesheets
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2021-07-01' AND
    url != 'inline'
  GROUP BY
    client)
USING
  (client)
