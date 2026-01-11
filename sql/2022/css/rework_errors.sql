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
    `httparchive.all.requests`
  WHERE
    date = '2022-07-01' AND -- noqa: CV09
    type = 'css'
  GROUP BY
    client
)
JOIN (
  SELECT
    client,
    COUNT(0) AS parsed_stylesheets
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2022-07-01' AND -- noqa: CV09
    url != 'inline'
  GROUP BY
    client
)
USING (client)
