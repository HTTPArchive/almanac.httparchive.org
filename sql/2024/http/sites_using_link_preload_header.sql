#standardSQL

# Number of <link rel="preload">.

CREATE TEMPORARY FUNCTION getNumLinkRelPreloadRespHeader(linkHeader STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
  let numPreload = 0;

  const linkHeaderTokens = linkHeader.split(',');
  for (let linkHeaderToken of linkHeaderTokens) {
    const linkTokenProps = linkHeaderToken.split(';');
    for (let linkTokenProp of linkTokenProps) {
      if (linkTokenProps.includes('rel=preload')) {
        numPreload++;
      }
    }
  }
  return numPreload;
} catch (e) {
  return 0;
}
''';

SELECT
  client,
  is_root_page,
  COUNTIF(num_link_rel_preload_resp_header > 0) AS num_sites_using_link_preload_resp_header,
  COUNT(0) AS total_sites,
  COUNTIF(num_link_rel_preload_resp_header > 0) / COUNT(0) AS pct_sites_using_link_preload_resp_header
FROM (
  SELECT
    client,
    is_root_page,
    page,
    SUM(getNumLinkRelPreloadRespHeader(resp_headers.value)) AS num_link_rel_preload_resp_header
  FROM
    `httparchive.all.requests`
  LEFT OUTER JOIN
    UNNEST(response_headers) AS resp_headers ON LOWER(resp_headers.name) = 'link'
  WHERE
    date = '2024-06-01' AND
    is_main_document
  GROUP BY
    client,
    is_root_page,
    page
)
GROUP BY
  client,
  is_root_page
ORDER BY
  client,
  is_root_page
