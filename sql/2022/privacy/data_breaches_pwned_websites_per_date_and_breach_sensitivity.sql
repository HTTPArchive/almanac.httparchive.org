#standardSQL
# 'Sensitive' HaveIBeenPwned breaches, where the existence of an account is sensitive in and of itself.
# https://haveibeenpwned.com/FAQs#SensitiveBreach

SELECT
  DATE_TRUNC(DATE(BreachDate), MONTH) AS breach_date,
  IF(isSensitive, 'Sensitive', 'Not sensitive') AS sensitivity,
  COUNT(DISTINCT Title) AS number_of_breaches,
  SUM(PwnCount) AS number_of_affected_accounts
FROM
  `httparchive.almanac.breaches`
WHERE
  date = '2022-06-01' AND
  BreachDate BETWEEN '2021-08-01' AND '2022-06-30' -- noqa: CV09
GROUP BY
  breach_date,
  sensitivity
ORDER BY
  breach_date,
  sensitivity
