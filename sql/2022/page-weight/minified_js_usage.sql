SELECT 
    _TABLE_SUFFIX as client,
    COUNTIF(
        REGEXP_CONTAINS(report,r'unminified-javascript\/\).","score":null')
    ) AS null_count,
    COUNTIF(
        REGEXP_CONTAINS(report,r'unminified-javascript\/\).","score":1')
    ) AS pass_count,
    COUNTIF(
        REGEXP_CONTAINS(report,r'unminified-javascript\/\).","score":0')
    ) AS fail_count
FROM
  `httparchive.lighthouse.2022_06_01_*`
GROUP BY
  client
ORDER BY
    client,
    null_count,
    pass_count,
    fail_count