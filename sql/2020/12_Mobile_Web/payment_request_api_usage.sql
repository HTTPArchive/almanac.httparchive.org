#standardSQL
# Payment request api usage on ecommerce sites
SELECT
  client,
  COUNT(0) AS total_ecommerce,
  COUNTIF(uses_payment_requst) AS total_using_payment_request,

  COUNTIF(uses_payment_requst) / COUNT(0) AS pct_using_payment_request
FROM (
  SELECT
    client,
    url,
    TRUE as uses_payment_requst
  FROM
    `httparchive.blink_features.features`
  WHERE
    yyyymmdd = '20200801' AND
    feature = 'PaymentRequestInitialized'
)
RIGHT JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url
  FROM
    `httparchive.technologies.2020_08_01_*`
  WHERE
    category = 'Ecommerce'
)
USING (client, url)
GROUP BY
  client
