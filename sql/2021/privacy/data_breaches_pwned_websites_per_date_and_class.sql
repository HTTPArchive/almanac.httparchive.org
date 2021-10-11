#standardSQL
# HaveIBeenPwned breaches by type of data breached, e.g., email addresses
# https://docs.google.com/spreadsheets/d/148SxZICZ24O44roIuEkRgbpIobWXpqLxegCDhIiX8XA/edit#gid=1158689200

SELECT
  data_class,
  breach_date,
  total_number_of_affected_accounts,
  SUM(total_number_of_affected_accounts) OVER (
    PARTITION BY data_class
    ORDER BY data_class, breach_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS cumulative_number_of_affected_accounts
FROM (
  SELECT
    data_class,
    BreachDate AS breach_date,
    SUM(PwnCount) AS total_number_of_affected_accounts
  FROM
    `httparchive.almanac.breaches`,
    UNNEST(JSON_VALUE_ARRAY(DataClasses)) AS data_class
  WHERE
    date = '2021-07-01'
  GROUP BY
    data_class,
    breach_date
)
ORDER BY
  data_class,
  breach_date
