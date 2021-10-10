#standardSQL
# 'Sensitive' HaveIBeenPwned breaches, where the existence of an account is sensitive in and of itself.
# https://haveibeenpwned.com/FAQs#SensitiveBreach
# https://docs.google.com/spreadsheets/d/148SxZICZ24O44roIuEkRgbpIobWXpqLxegCDhIiX8XA/edit#gid=1435927653

SELECT
  is_sensitive,
  breach_date,
  total_number_of_affected_accounts,
  SUM(total_number_of_affected_accounts) OVER (
    PARTITION BY is_sensitive
    ORDER BY is_sensitive, breach_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS cumulative_number_of_affected_accounts
FROM (
  SELECT
    isSensitive AS is_sensitive,
    BreachDate AS breach_date,
    SUM(PwnCount) AS total_number_of_affected_accounts
  FROM
    `httparchive.almanac.breaches`
  WHERE
    date = '2021-07-01'
  GROUP BY
    is_sensitive,
    breach_date
)
ORDER BY
  is_sensitive,
  breach_date
