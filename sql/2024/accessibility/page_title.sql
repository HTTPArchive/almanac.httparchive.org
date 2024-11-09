#standardSQL
# Page title stats (usage, descriptive, changed on render)
SELECT
  client,
  is_root_page,
  COUNT(0) AS total_sites,
  COUNTIF(total_title_words > 0) AS total_has_title,
  COUNTIF(total_title_words > 3) AS total_title_with_four_or_more_words,
  COUNTIF(title_changed_on_render) AS total_title_changed,
  COUNTIF(total_title_words > 0) / COUNT(0) AS pct_with_title,
  COUNTIF(total_title_words > 3) / COUNTIF(total_title_words > 0) AS pct_titles_four_or_more_words,
  COUNTIF(title_changed_on_render) / COUNTIF(total_title_words > 0) AS pct_titles_changed_on_render
FROM (
  SELECT
    client,
    is_root_page,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies'), '$.title.title_changed_on_render') AS BOOL) AS title_changed_on_render,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies'), '$.title.rendered.primary.words') AS INT64) AS total_title_words
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
)
GROUP BY
  client,
  is_root_page;
