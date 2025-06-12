SELECT
  DATE('2022-07-01') AS date,
  _TABLE_SUFFIX AS client,
  page,
  url,
  css
FROM
  `httparchive.experimental_parsed_css.2022_07_01_*` -- noqa: CV09
WHERE
  is_root_page
