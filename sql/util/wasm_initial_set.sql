SELECT DISTINCT
  url
FROM
  `httparchive.summary_requests.2021_09_01_*`
WHERE
  ext = 'wasm' OR
  mimeType = 'application/wasm'
