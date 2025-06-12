# cms passing core web vitals
# core_web_vitals_yoy.sql
CREATE TEMP FUNCTION IS_GOOD(good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good / (good + needs_improvement + poor) >= 0.75
);

CREATE TEMP FUNCTION IS_NON_ZERO(good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good + needs_improvement + poor > 0
);

SELECT
  2024 AS year,
  client,
  cms,
  COUNT(DISTINCT origin) AS origins,
  # Origins with good LCP divided by origins with any LCP.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(IS_GOOD(fast_lcp, avg_lcp, slow_lcp), origin, NULL)),
    COUNT(DISTINCT IF(IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp), origin, NULL))
  ) AS pct_good_lcp,

  # Origins with good INP divided by origins with any INP.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(IS_GOOD(fast_inp, avg_inp, slow_inp), origin, NULL)),
    COUNT(DISTINCT IF(IS_NON_ZERO(fast_inp, avg_inp, slow_inp), origin, NULL))
  ) AS pct_good_inp,
  # Origins with good CLS divided by origins with any CLS.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL)),
    COUNT(DISTINCT IF(IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL))
  ) AS pct_good_cls,

  # Origins with good LCP, INP (optional), and CLS divided by origins with any LCP and CLS.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_GOOD(fast_lcp, avg_lcp, slow_lcp) AND
      IS_GOOD(fast_inp, avg_inp, slow_inp) IS NOT FALSE AND
      IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp) AND
      IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL
    ))
  ) AS pct_good_cwv
FROM
  `chrome-ux-report.materialized.device_summary`
JOIN (
  SELECT
    client,
    page AS url,
    technologies.technology AS cms
  FROM
    `httparchive.all.pages`,
    UNNEST(technologies) AS technologies,
    UNNEST(technologies.categories) AS cats
  WHERE
    cats = 'CMS' AND
    date = '2024-06-01' AND
    is_root_page
)
ON
  CONCAT(origin, '/') = url AND
  IF(device = 'desktop', 'desktop', 'mobile') = client
WHERE
  date = '2024-06-01'
GROUP BY
  client,
  cms

UNION ALL

SELECT
  2023 AS year,
  client,
  cms,
  COUNT(DISTINCT origin) AS origins,
  # Origins with good LCP divided by origins with any LCP.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(IS_GOOD(fast_lcp, avg_lcp, slow_lcp), origin, NULL)),
    COUNT(DISTINCT IF(IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp), origin, NULL))
  ) AS pct_good_lcp,

  # Origins with good INP divided by origins with any INP.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(IS_GOOD(fast_inp, avg_inp, slow_inp), origin, NULL)),
    COUNT(DISTINCT IF(IS_NON_ZERO(fast_inp, avg_inp, slow_inp), origin, NULL))
  ) AS pct_good_inp,

  # Origins with good CLS divided by origins with any CLS.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL)),
    COUNT(DISTINCT IF(IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL))
  ) AS pct_good_cls,

  # Origins with good LCP, INP (optional), and CLS divided by origins with any LCP and CLS.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_GOOD(fast_lcp, avg_lcp, slow_lcp) AND
      IS_GOOD(fast_inp, avg_inp, slow_inp) IS NOT FALSE AND
      IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp) AND
      IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL
    ))
  ) AS pct_good_cwv
FROM
  `chrome-ux-report.materialized.device_summary`
JOIN (
  SELECT
    client,
    page AS url,
    technologies.technology AS cms
  FROM
    `httparchive.all.pages`,
    UNNEST(technologies) AS technologies,
    UNNEST(technologies.categories) AS cats
  WHERE
    cats = 'CMS' AND
    date = '2023-06-01' AND
    is_root_page
)
ON
  CONCAT(origin, '/') = url AND
  IF(device = 'desktop', 'desktop', 'mobile') = client
WHERE
  date = '2023-06-01'
GROUP BY
  client,
  cms

UNION ALL

SELECT
  2022 AS year,
  client,
  cms,
  COUNT(DISTINCT origin) AS origins,
  # Origins with good LCP divided by origins with any LCP.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(IS_GOOD(fast_lcp, avg_lcp, slow_lcp), origin, NULL)),
    COUNT(DISTINCT IF(IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp), origin, NULL))
  ) AS pct_good_lcp,

  # Origins with good INP divided by origins with any INP.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(IS_GOOD(fast_inp, avg_inp, slow_inp), origin, NULL)),
    COUNT(DISTINCT IF(IS_NON_ZERO(fast_inp, avg_inp, slow_inp), origin, NULL))
  ) AS pct_good_inp,

  # Origins with good CLS divided by origins with any CLS.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL)),
    COUNT(DISTINCT IF(IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL))
  ) AS pct_good_cls,

  # Origins with good LCP, INP (optional), and CLS divided by origins with any LCP and CLS.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_GOOD(fast_lcp, avg_lcp, slow_lcp) AND
      IS_GOOD(fast_inp, avg_inp, slow_inp) IS NOT FALSE AND
      IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp) AND
      IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL
    ))
  ) AS pct_good_cwv
FROM
  `chrome-ux-report.materialized.device_summary`
JOIN (
  SELECT
    client,
    page AS url,
    technologies.technology AS cms
  FROM
    `httparchive.all.pages`,
    UNNEST(technologies) AS technologies,
    UNNEST(technologies.categories) AS cats
  WHERE
    cats = 'CMS' AND
    date = '2022-06-01' AND
    is_root_page
)
ON
  CONCAT(origin, '/') = url AND
  IF(device = 'desktop', 'desktop', 'mobile') = client
WHERE
  date = '2022-06-01'
GROUP BY
  client,
  cms
ORDER BY
  origins DESC
