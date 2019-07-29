#standardSQL

-- counts the local() inside @font-face

WITH
  response_bodies AS (
    SELECT * FROM `httparchive.response_bodies.2019_07_01_desktop`
    UNION ALL
    SELECT * FROM `httparchive.response_bodies.2019_07_01_mobile`
  ),
  temp AS (
    SELECT REGEXP_EXTRACT_ALL(body, r"\@font-face\s*\{[^}]+\}") AS font_display_arr, url, page
    FROM response_bodies WHERE STRPOS(body, "@font-face") > 0
  ),
  temp2 AS (
    SELECT ARRAY_LENGTH(REGEXP_EXTRACT_ALL(font_face, r"local\(")) AS local_usage
    FROM temp, UNNEST(font_display_arr) AS font_face
  ),
  processedTable AS (
    SELECT SUM(local_usage) AS local_usage FROM temp2
  )
SELECT * FROM processedTable
