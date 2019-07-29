#standardSQL

-- counts the font types (format)

WITH
  summary_requests AS (
    SELECT * FROM `httparchive.summary_requests.2019_07_01_desktop`
    UNION ALL
    SELECT * FROM `httparchive.summary_requests.2019_07_01_mobile`
  ),
  processedTable AS (
    SELECT
      (
        IF(STRPOS(mimeType, "font") > 0,
          -- get the type of font from the content-type
          REGEXP_REPLACE(
            REGEXP_REPLACE(mimeType, r"^(font\/x\-)|(font\/font\-)|(font\/)|(application\/font\-)|(application\/x\-font\-)", ""),
            r"^x\-",
            ""
          ),
          -- hack: get the type of font from the file name
          ARRAY_REVERSE(
            SPLIT(
              SPLIT(
                ARRAY_REVERSE(
                  SPLIT(url, "/")
                )[OFFSET(0)],
                "?"
              )[OFFSET(0)],
              "."
            )
          )[OFFSET(0)]
        )
      ) AS font,
      *
    FROM summary_requests WHERE type = 'font'
  )
SELECT
  DISTINCT(font),
  COUNT(font) AS count
FROM processedTable
GROUP BY font
ORDER BY count DESC
