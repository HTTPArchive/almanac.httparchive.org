#standardSQL
# 'Sensitive' HaveIBeenPwned breaches, where the existence of an account is sensitive in and of itself.
# https://haveibeenpwned.com/FAQs#SensitiveBreach
# https://docs.google.com/spreadsheets/d/148SxZICZ24O44roIuEkRgbpIobWXpqLxegCDhIiX8XA/edit#gid=1435927653

SELECT
  DATE_TRUNC(DATE(BreachDate), MONTH) AS breach_date,
  IF(isSensitive, "Sensitive", "Not sensitive") AS sensitivity,
  COUNT(DISTINCT Title) AS number_of_breaches,
  SUM(PwnCount) AS number_of_affected_accounts
FROM
  `httparchive.almanac.breaches`
WHERE
  date = '2021-07-01' AND
  BreachDate BETWEEN '2020-08-01' AND '2021-07-31'
GROUP BY
  breach_date,
  sensitivity
ORDER BY
  breach_date,
  sensitivity
