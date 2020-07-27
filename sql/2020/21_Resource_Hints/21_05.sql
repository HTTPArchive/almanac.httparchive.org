#standardSQL
# 21_05: Usage of Guess.js
SELECT
    client,
    COUNT(0) AS total,
    COUNTIF(REGEXP_CONTAINS(body, r'__GUESS__')) AS guess,
FROM
  `httparchive.almanac.summary_response_bodies`
WHERE
  type = "script"
  AND
  edition = "2020"
GROUP BY
  client