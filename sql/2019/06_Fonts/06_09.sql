#standardSQL

-- counts the number of pages given number of font-face

WITH
  response_bodies AS (
    SELECT * FROM `httparchive.response_bodies.2019_07_01_desktop`
    UNION ALL
    SELECT * FROM `httparchive.response_bodies.2019_07_01_mobile`
  ),
  temp AS (
    SELECT ARRAY_LENGTH(REGEXP_EXTRACT_ALL(body, r"\@font-face\s*\{[^}]+\}")) AS font_display_arr, url, page
    FROM response_bodies WHERE STRPOS(body, "@font-face") > 0
  ),
  processedTable AS (
    SELECT
      DISTINCT(page),
      COUNT(font_display_arr) AS font_face
    FROM temp
    GROUP BY page
  )
SELECT
  COUNTIF(font_face = 1) AS page_one_font_face,
  COUNTIF(font_face = 2) AS page_two_font_face,
  COUNTIF(font_face = 3) AS page_three_font_face,
  COUNTIF(font_face = 4) AS page_four_font_face,
  COUNTIF(font_face = 5) AS page_five_font_face,
  COUNTIF(font_face = 6) AS page_six_font_face,
  COUNTIF(font_face = 7) AS page_seven_font_face,
  COUNTIF(font_face = 8) AS page_eight_font_face,
  COUNTIF(font_face > 8) AS page_more_font_face
FROM processedTable
