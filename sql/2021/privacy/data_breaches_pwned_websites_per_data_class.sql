#standardSQL
# HaveIBeenPwned breaches by type of data breached, e.g., email addresses
# https://docs.google.com/spreadsheets/d/148SxZICZ24O44roIuEkRgbpIobWXpqLxegCDhIiX8XA/edit#gid=1158689200


SELECT
  data_class,
  COUNT(DISTINCT Domain) AS number_of_affected_domains,
  SUM(PwnCount) AS number_of_affected_accounts
FROM
  `httparchive.almanac.breaches`,
  UNNEST(JSON_VALUE_ARRAY(DataClasses)) AS data_class
WHERE
  date = '2021-07-01' AND
  BreachDate BETWEEN '2020-08-01' AND '2021-06-30'
GROUP BY
  data_class
ORDER BY
  number_of_affected_domains DESC
