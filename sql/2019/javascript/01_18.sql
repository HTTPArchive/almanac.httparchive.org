#standardSQL
# 01_18-23: % of pages using JS APIs
SELECT
  client,
  COUNT(0) AS total,
  COUNTIF(atomics > 0) AS atomics,
  ROUND(COUNTIF(atomics > 0) * 100 / COUNT(0), 2) AS pct_atomics,
  COUNTIF(intl > 0) AS intl,
  ROUND(COUNTIF(intl > 0) * 100 / COUNT(0), 2) AS pct_intl,
  COUNTIF(proxy > 0) AS proxy,
  ROUND(COUNTIF(proxy > 0) * 100 / COUNT(0), 2) AS pct_proxy,
  COUNTIF(sharedarraybuffer > 0) AS sharedarraybuffer,
  ROUND(COUNTIF(sharedarraybuffer > 0) * 100 / COUNT(0), 2) AS pct_sharedarraybuffer,
  COUNTIF(weakmap > 0) AS weakmap,
  ROUND(COUNTIF(weakmap > 0) * 100 / COUNT(0), 2) AS pct_weakmap,
  COUNTIF(weakset > 0) AS weakset,
  ROUND(COUNTIF(weakset > 0) * 100 / COUNT(0), 2) AS pct_weakset
FROM (
  SELECT
    client,
    COUNTIF(body LIKE '%Atomics.%') AS atomics,
    COUNTIF(body LIKE '%new Intl.%') AS intl,
    COUNTIF(body LIKE '%new Proxy%') AS proxy,
    COUNTIF(body LIKE '%new SharedArrayBuffer(%') AS sharedarraybuffer,
    COUNTIF(body LIKE '%new WeakMap%') AS weakmap,
    COUNTIF(body LIKE '%new WeakSet%') AS weakset
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2019-07-01' AND
    type = 'script'
  GROUP BY
    client,
    page
)
GROUP BY
  client
ORDER BY
  client
