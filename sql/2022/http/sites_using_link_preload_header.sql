#standardSQL

# Number of <link rel="preload">.

CREATE TEMPORARY FUNCTION getNumLinkRelPreloadRespHeader(HTTPheaders STRING, header STRING)
RETURNS INT64 LANGUAGE js AS """
try {
  var headers = JSON.parse(HTTPheaders);

  // Filter by header name (which is case insensitive)
  // If multiple headers it's the same as comma separated
  const allLinkHeaderValues = headers.filter(h => h.name.toLowerCase() == header.toLowerCase()).map(h => h.value);
  let numPreload = 0;
  for (let linkHeader of allLinkHeaderValues) {
    const linkHeaderTokens = linkHeader.split(',');
    for (let linkHeaderToken of linkHeaderTokens) {
      const linkTokenProps = linkHeaderToken.split(';');
      for (let linkTokenProp of linkTokenProps) {
        if (linkTokenProps.includes('rel=preload')) {
          numPreload++;
        }
      }
    }
  }
  return numPreload;
} catch (e) {
  return 0;
}
""";

SELECT
  client,
  COUNTIF(num_link_rel_preload_resp_header > 0) AS num_sites_using_link_preload_resp_header,
  COUNT(0) AS total_sites,
  COUNTIF(num_link_rel_preload_resp_header > 0) / COUNT(0) AS pct_sites_using_link_preload_resp_header
FROM (
  SELECT
    client,
    page,
    SUM(getNumLinkRelPreloadRespHeader(response_headers, 'link')) AS num_link_rel_preload_resp_header
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    firstHtml
  GROUP BY
    client,
    page
)
GROUP BY
  client
