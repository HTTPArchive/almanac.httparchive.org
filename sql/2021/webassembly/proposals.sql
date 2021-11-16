SELECT
  client,
  COUNTIF(has_start) AS has_start,
  COUNTIF(instr.proposals.atomics > 0) AS atomics,
  COUNTIF(instr.proposals.bigint_externals > 0) AS bigint_externals,
  COUNTIF(instr.proposals.bulk > 0) AS bulk,
  COUNTIF(instr.proposals.multi_value > 0) AS multi_value,
  COUNTIF(instr.proposals.mutable_externals > 0) AS mutable_externals,
  COUNTIF(instr.proposals.non_trapping_conv > 0) AS non_trapping_conv,
  COUNTIF(instr.proposals.ref_types > 0) AS ref_types,
  COUNTIF(instr.proposals.sign_extend > 0) AS sign_extend,
  COUNTIF(instr.proposals.simd > 0) AS simd,
  COUNTIF(instr.proposals.tail_calls > 0) AS tail_calls,
  COUNT(0) AS total
FROM
  `httparchive.almanac.wasm_stats`
WHERE
  date = '2021-09-01'
GROUP BY
  client
ORDER BY
  client
