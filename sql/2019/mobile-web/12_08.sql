#standardSQL

# password-inputs-can-be-pasted-into

SELECT
  COUNT(0) AS total_pages,
  COUNTIF(password_score IS NOT NULL) AS applicable_pages,

  COUNTIF(CAST(password_score AS NUMERIC) = 1) AS total_allowing,
  ROUND(COUNTIF(CAST(password_score AS NUMERIC) = 1) * 100 / COUNTIF(password_score IS NOT NULL), 2) AS perc_allowing
FROM
  (
    SELECT
      url,
      JSON_EXTRACT_SCALAR(report, '$.audits.password-inputs-can-be-pasted-into.score') AS password_score
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
  )
