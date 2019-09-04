#standardSQL

-- counts the font types (format)

SELECT
  DISTINCT LOWER(font),
  COUNT(0) OVER (PARTITION BY LOWER(font)) / COUNT(0) OVER () AS pct
FROM (
  SELECT
    IF(STRPOS(mimeType, "font") > 0,
      -- get the type of font from the content-type
      REGEXP_REPLACE(
        REGEXP_REPLACE(mimeType, r"^(font\/x\-)|(font\/font\-)|(font\/)|(application\/font\-)|(application\/x\-font\-)", ""),
        r"^x\-",
        ""
      ),
      LOWER(ext)
    ) AS font
  FROM
    `httparchive.summary_requests.2019_07_01_*`
  WHERE
    type = 'font'
)
ORDER BY
  pct DESC
