#standardSQL
  # A count of pages which include each type of structured data
SELECT
  SUM(CASE
      WHEN CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.rdfa') AS BOOL) = TRUE THEN 1
      ELSE
        0
    END
  ) AS rdfa,
  SUM(CASE
      WHEN CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.json_ld') AS BOOL) = TRUE THEN 1
      ELSE
        0
    END
  ) AS json_ld,
  SUM(CASE
      WHEN CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.microdata') AS BOOL) = TRUE THEN 1
      ELSE
        0
    END
  ) AS microdata,
  SUM(CASE
      WHEN CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.microformats2') AS BOOL) = TRUE THEN 1
      ELSE
        0
    END
  ) AS microformats2,
  SUM(CASE
      WHEN CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.microformats_classic') AS BOOL) = TRUE THEN 1
      ELSE
        0
    END
  ) AS microformats_classic,
  SUM(CASE
      WHEN CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.dublin_core') AS BOOL) = TRUE THEN 1
      ELSE
        0
    END
  ) AS dublin_core,
  SUM(CASE
      WHEN CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.twitter') AS BOOL) = TRUE THEN 1
      ELSE
        0
    END
  ) AS twitter,
  SUM(CASE
      WHEN CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.facebook') AS BOOL) = TRUE THEN 1
      ELSE
        0
    END
  ) AS facebook,
  SUM(CASE
      WHEN CAST(JSON_EXTRACT(structured_data, '$.structured_data.rendered.present.opengraph') AS BOOL) = TRUE THEN 1
      ELSE
        0
    END
  ) AS opengraph,
  SUM(CASE
      WHEN JSON_EXTRACT(structured_data, '$.structured_data') IS NOT NULL AND JSON_EXTRACT(structured_data, '$.log') IS NULL THEN 1
      ELSE
        0
    END
  ) AS total,
  client
FROM (
  SELECT
    JSON_VALUE(JSON_EXTRACT(payload,
        '$._structured-data')) AS structured_data,
    _TABLE_SUFFIX AS client
  FROM
    `httparchive.pages.2021_07_01_*`)
GROUP BY
  client
