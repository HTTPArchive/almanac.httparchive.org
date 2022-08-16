SELECT
  client,
  url
FROM
  `httparchive.almanac.jamstack_sites`
WHERE
  methodology = '2022' AND
  date = '2022-06-01' AND
  rank = 1000
ORDER BY
  client,
  url
