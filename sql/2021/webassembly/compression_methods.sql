SELECT
  * EXCEPT (count),
  count / (SUM(count) OVER ()) AS pct
FROM
  (
    SELECT
      client,
      resp_content_encoding,
      COUNT(0) AS count
    FROM
      `httparchive.almanac.wasm_stats`
    WHERE
      date = '2021-09-01'
    GROUP BY
      client,
      resp_content_encoding
  )
ORDER BY
  client,
  pct
