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
    getRDFaVocabs(rendered) AS rdfaVocabs
  FROM (
    SELECT
      JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload,
            '$._structured-data')),
        '$.structured_data.rendered') AS rendered
    FROM
      `httparchive.pages.2021_07_01_*`))
SELECT
  rdfaVocab,
  COUNT(rdfaVocab) AS count
FROM
  rendered_data,
  UNNEST(rdfaVocabs) AS rdfaVocab
GROUP BY
  rdfaVocab
ORDER BY
  count DESC;
