#standardSQL
# Payment request api usage on ecommerce sites
SELECT
  client,
  COUNT(0) AS total_ecommerce,
  COUNTIF(payment_request_uses > 0) AS total_using_payment_request,

  COUNTIF(payment_request_uses > 0) / COUNT(0) AS pct_using_payment_request
FROM (
  SELECT
    client,
    page,
    COUNTIF(body LIKE '%new paymentrequest(%') AS payment_request_uses,
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2020-08-01' AND
    type = 'script'
  GROUP BY
    client,
    page
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page
  FROM
    `httparchive.technologies.2020_08_01_*`
  WHERE
    category = 'Ecommerce'
)
USING (client, page)
GROUP BY
  client
