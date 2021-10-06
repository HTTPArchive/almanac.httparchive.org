# standardSQL
  # Count RDFa Vocabs
CREATE TEMP FUNCTION
  getRDFaVocabs(rendered STRING)
  RETURNS ARRAY<STRING>
  LANGUAGE js AS r"""
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
    getRDFaVocabs(rendered) AS rdfa_vocabs
  FROM (
    SELECT
      JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload,
            '$._structured-data')),
        '$.structured_data.rendered') AS rendered
    FROM
      `httparchive.pages.2021_07_01_*`)
)

SELECT
  rdfa_vocab,
  COUNT(rdfa_vocab) AS count
FROM
  rendered_data,
  UNNEST(rdfa_vocabs) AS rdfa_vocab
GROUP BY
  rdfa_vocab
ORDER BY
  count DESC
