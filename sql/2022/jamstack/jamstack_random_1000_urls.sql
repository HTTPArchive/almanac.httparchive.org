SELECT
  url
FROM
  `httparchive.almanac.jamstack_sites`
WHERE
  methodology = '2022' AND
  date = '2022-06-01'
LIMIT 1000 -- noqa: AM09
