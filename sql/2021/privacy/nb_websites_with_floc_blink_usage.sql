#standardSQL
# Pages that request the FLoC cohort (based on Blink features)

SELECT
  client,
  feature,
  num_urls,
  total_urls,
  ROUND(pct_urls, 2) AS pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20210701' AND
  feature = 'InterestCohortAPI_interestCohort_Method'
ORDER BY
  2 ASC, 1 ASC

# relevant Blink features:

# InterestCohortAPI_interestCohort_Method
