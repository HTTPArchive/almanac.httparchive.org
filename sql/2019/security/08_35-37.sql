#standardSQL
  # 08_35-37: Groupings of availably parsed values by percentage by client
  #   Mostly dynamic, but then removed all of the disinct values at "=" unless
  #     samesite rule is involved
SELECT
  client,
  TRIM(SUBSTR(LOWER(policy), 1,
    CASE
      WHEN (STRPOS(LOWER(policy), 'samesite=strict') > 1
          OR STRPOS(LOWER(policy), 'samesite=lax') > 0
          OR STRPOS(LOWER(policy), 'samesite=none') > 1 )
        THEN LENGTH(policy)
      WHEN STRPOS(policy, '=') > 1
        THEN STRPOS(LOWER(policy), '=') - 1
      ELSE LENGTH(policy)
    END
  )) AS substr_policy,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders), r'set-cookie = ([^,\r\n]+)')) AS value,
  UNNEST(SPLIT(value, ';')) AS policy
WHERE
  date = '2019-07-01' AND
  firstHtml
GROUP BY
  client,
  substr_policy
ORDER BY
  freq / total DESC
