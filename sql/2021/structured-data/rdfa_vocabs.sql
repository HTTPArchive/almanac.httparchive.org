# standardSQL
# Count RDFa Vocabs
CREATE TEMP FUNCTION getRDFaVocabs(rendered STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
  try {
    rendered = JSON.parse(rendered);
    return rendered.rdfa_vocabs.map(vocab => vocab.toLowerCase());
  } catch (e) {
    return [];
  }
""";

WITH
rendered_data AS (
  SELECT
    getRDFaVocabs(rendered) AS rdfa_vocabs,
    client
  FROM (
    SELECT
      JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload,
            '$._structured-data')),
        '$.structured_data.rendered') AS rendered,
      _TABLE_SUFFIX AS client
    FROM
      `httparchive.pages.2021_07_01_*`)
)

SELECT
  rdfa_vocab,
  COUNT(rdfa_vocab) AS count,
  SUM(COUNT(rdfa_vocab)) OVER (PARTITION BY client) AS total,
  COUNT(rdfa_vocab) / SUM(COUNT(rdfa_vocab)) OVER (PARTITION BY client) AS pct,
  client
FROM (
  SELECT
    -- Removes the protocol and any subdomains from the URL.
    -- e.g. "https://my.example.com/pathname" becomes "example.com/pathname"
    -- This is done to normalize the URL a bit before counting.
    CONCAT(NET.REG_DOMAIN(rdfa_vocab), SPLIT(rdfa_vocab, NET.REG_DOMAIN(rdfa_vocab))[SAFE_OFFSET(1)]) AS rdfa_vocab,
    client
  FROM
    rendered_data,
    UNNEST(rdfa_vocabs) AS rdfa_vocab
)
GROUP BY
  rdfa_vocab,
  client
ORDER BY
  count DESC
