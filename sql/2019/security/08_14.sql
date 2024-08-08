#standardSQL
# 08_14: Frame-ancestor CSP directive
SELECT
  client,
  csp_frame_ancestors_count,
  csp_frame_ancestors_none_count,
  csp_frame_ancestors_self_count,
  total,
  ROUND(csp_frame_ancestors_count * 100 / total, 2) AS pct_csp_frame_ancestors,
  ROUND(csp_frame_ancestors_none_count * 100 / total, 2) AS pct_csp_frame_ancestors_none,
  ROUND(csp_frame_ancestors_self_count * 100 / total, 2) AS pct_csp_frame_ancestors_self
FROM (
  SELECT
    client,
    COUNT(0) AS total,
    COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), r'frame-ancestors') AND REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =')) AS csp_frame_ancestors_count,
    COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), r'content-security-policy =') AND ENDS_WITH(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\Wframe-ancestors([^,|;]+)'), "'none'")) AS csp_frame_ancestors_none_count,
    COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), r'content-security-policy =') AND ENDS_WITH(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\Wframe-ancestors([^,|;]+)'), "'self'")) AS csp_frame_ancestors_self_count
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01' AND
    firstHtml
  GROUP BY
    client
)
