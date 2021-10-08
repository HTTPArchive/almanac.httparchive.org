SELECT
  client,
  COUNT(*) total,
  COUNTIF(has_start) has_start,
  COUNTIF(instr.proposals.atomics > 0) proposals_atomics,
  COUNTIF(instr.proposals.bigint_externals > 0) proposals_bigint_externals,
  COUNTIF(instr.proposals.bulk > 0) proposals_bulk,
  COUNTIF(instr.proposals.multi_value > 0) proposals_multi_value,
  COUNTIF(instr.proposals.mutable_externals > 0) proposals_mutable_externals,
  COUNTIF(instr.proposals.non_trapping_conv > 0) proposals_non_trapping_conv,
  COUNTIF(instr.proposals.ref_types > 0) proposals_ref_types,
  COUNTIF(instr.proposals.sign_extend > 0) proposals_sign_extend,
  COUNTIF(instr.proposals.simd > 0) proposals_simd,
  COUNTIF(instr.proposals.tail_calls > 0) proposals_tail_calls
FROM
  `httparchive.almanac.wasm_stats`
GROUP BY
  client;