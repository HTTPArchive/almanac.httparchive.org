#standardSQL
# Payment request api usage on ecommerce pages
SELECT
  client,
  COUNT(0) AS total_ecommerce,
  COUNTIF(uses_payment_requst) AS total_using_payment_request,

  COUNTIF(uses_payment_requst) / COUNT(0) AS pct_using_payment_request
FROM (
  SELECT
    client,
    url,
    TRUE AS uses_payment_requst
  FROM
    `httparchive.blink_features.features`
  WHERE
    yyyymmdd = CAST('2021-07-01' AS DATE) AND
    feature = 'PaymentRequestInitialized'
)
RIGHT JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    category = 'Ecommerce'
)
USING (client, url)
GROUP BY
  client
