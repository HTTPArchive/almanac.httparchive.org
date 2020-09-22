#standardSQL
# 13_08: CrUX LCP performance of ecommerce providers
SELECT
    client,
    ecomm,
    AVG(ROUND(SAFE_DIVIDE(fast_lcp, fast_lcp + avg_lcp + slow_lcp) * 100, 2)) AS fast,
    AVG(ROUND(SAFE_DIVIDE(avg_lcp, fast_lcp + avg_lcp + slow_lcp) * 100, 2)) AS avg,
    AVG(ROUND(SAFE_DIVIDE(slow_lcp, fast_lcp + avg_lcp + slow_lcp) * 100, 2)) AS slow,
    COUNT(DISTINCT origin) AS freq
  FROM
    `chrome-ux-report.materialized.device_summary`
     JOIN (
      SELECT 
        _TABLE_SUFFIX AS client,
        url, 
        app as ecomm
      FROM 
        `httparchive.technologies.2020_08_01_*`
      WHERE 
        category = 'Ecommerce')
    ON 
      CONCAT(origin, '/') = url 
      AND
      IF(device = 'desktop', 'desktop', 'mobile') = client
  WHERE
    date = '2020-08-01' AND
    fast_lcp + avg_lcp + slow_lcp > 0
  GROUP BY 
    client,
    ecomm
  ORDER BY
    freq DESC  
   