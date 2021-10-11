SELECT
  client,
  COUNT(0) AS total,
  COUNTIF(has_start) AS has_start,
  COUNTIF(instr.proposals.atomics > 0) AS proposals_atomics,
  COUNTIF(instr.proposals.bigint_externals > 0) AS proposals_bigint_externals,
  COUNTIF(instr.proposals.bulk > 0) AS proposals_bulk,
  COUNTIF(instr.proposals.multi_value > 0) AS proposals_multi_value,
  COUNTIF(instr.proposals.mutable_externals > 0) AS proposals_mutable_externals,
  COUNTIF(instr.proposals.non_trapping_conv > 0) AS proposals_non_trapping_conv,
  COUNTIF(instr.proposals.ref_types > 0) AS proposals_ref_types,
  COUNTIF(instr.proposals.sign_extend > 0) AS proposals_sign_extend,
  COUNTIF(instr.proposals.simd > 0) AS proposals_simd,
  COUNTIF(instr.proposals.tail_calls > 0) AS proposals_tail_calls
FROM
  `httparchive.almanac.wasm_stats`
WHERE
  date = '2021-09-01'
GROUP BY
  client;
