WITH
pages AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
  GROUP BY
    client
),
foundries AS (
  SELECT
    client,
    JSON_EXTRACT_SCALAR(payload, '$._font_details.OS2.achVendID') AS foundry,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    type = 'font'
  GROUP BY
    client,
    foundry
)

SELECT
  client,
  foundry,
  count,
  total,
  count / total AS proportion
FROM
  foundries
JOIN
  pages USING (client)
ORDER BY
  proportion DESC
