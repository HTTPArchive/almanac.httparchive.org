#standardSQL
# Payment request api usage on ecommerce sites
SELECT
  client,
  COUNT(0) AS total_ecommerce,
  COUNTIF(uses_payment_requst) AS total_using_payment_request,

  COUNTIF(uses_payment_requst) / COUNT(0) AS pct_using_payment_request
FROM
  (
    SELECT
      _TABLE_SUFFIX AS client,
      url
    FROM
      `httparchive.technologies.2020_08_01_*`
    WHERE
      category = 'Ecommerce'
  )
LEFT OUTER JOIN
  (
    SELECT
      client,
      url,
      TRUE AS uses_payment_requst
    FROM
      `httparchive.blink_features.features`
    WHERE
      yyyymmdd = '20200801' AND
      feature = 'PaymentRequestInitialized'
  )
USING (client, url)
GROUP BY
  client
