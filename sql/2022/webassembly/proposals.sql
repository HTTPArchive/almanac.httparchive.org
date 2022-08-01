# standardSQL
# The number of usages of post-MVP proposals in wasm modules.

WITH wasm AS (
  SELECT
    *,
    JSON_QUERY(payload, '$._wasm_stats') AS wasm_stats
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    (mimeType = 'application/wasm' OR ext = 'wasm')
)

SELECT
  client,
  COUNTIF(SAFE_CAST(JSON_VALUE(wasm_stats, '$.instr.proposals.atomics') AS INT64) > 0) AS atomics,
  COUNTIF(SAFE_CAST(JSON_VALUE(wasm_stats, '$.instr.proposals.bigint_externals') AS INT64) > 0) AS bigint_externals,
  COUNTIF(SAFE_CAST(JSON_VALUE(wasm_stats, '$.instr.proposals.bulk') AS INT64) > 0) AS bulk,
  COUNTIF(SAFE_CAST(JSON_VALUE(wasm_stats, '$.instr.proposals.multi_value') AS INT64) > 0) AS multi_value,
  COUNTIF(SAFE_CAST(JSON_VALUE(wasm_stats, '$.instr.proposals.mutable_externals') AS INT64) > 0) AS mutable_externals,
  COUNTIF(SAFE_CAST(JSON_VALUE(wasm_stats, '$.instr.proposals.non_trapping_conv') AS INT64) > 0) AS non_trapping_conv,
  COUNTIF(SAFE_CAST(JSON_VALUE(wasm_stats, '$.instr.proposals.ref_types') AS INT64) > 0) AS ref_types,
  COUNTIF(SAFE_CAST(JSON_VALUE(wasm_stats, '$.instr.proposals.sign_extend') AS INT64) > 0) AS sign_extend,
  COUNTIF(SAFE_CAST(JSON_VALUE(wasm_stats, '$.instr.proposals.simd') AS INT64) > 0) AS simd,
  COUNTIF(SAFE_CAST(JSON_VALUE(wasm_stats, '$.instr.proposals.tail_calls') AS INT64) > 0) AS tail_calls,
  COUNT(0) AS total
FROM
  wasm
WHERE
  wasm_stats IS NOT NULL
GROUP BY
  client
ORDER BY
  client
