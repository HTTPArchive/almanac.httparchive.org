#standardSQL
# HaveIBeenPwned breaches by type of data breached, e.g., email addresses

SELECT
  data_class,
  COUNT(DISTINCT Title) AS number_of_breaches,
  SUM(PwnCount) AS number_of_affected_accounts
FROM
  `httparchive.almanac.breaches`,
  UNNEST(JSON_VALUE_ARRAY(DataClasses)) AS data_class
WHERE
  date = '2022-06-01' AND
  BreachDate BETWEEN '2021-08-01' AND '2022-06-30' -- noqa: CV09
GROUP BY
  data_class
ORDER BY
  number_of_breaches DESC
