#standardSQL
#openType_axis
SELECT
 client,
 JSON_EXTRACT_SCALAR(payload, '$._font_details.table_sizes.name') AS name,
 JSON_EXTRACT_SCALAR(payload, '$._font_details.table_sizes.fvar.axisTag') AS axis,
 JSON_EXTRACT_SCALAR(payload, '$._font_details.table_sizes.fvar.axisSize') AS axisSize,
FROM
 `httparchive.almanac.requests`
WHERE
 type = 'font' AND
 JSON_EXTRACT_SCALAR(payload, '$._font_details.table_sizes.name' ) IS NOT NULL OR
 JSON_EXTRACT_SCALAR(payload, '$._font_details.table_sizes.fvar.axisTag') IS NOT NULL OR
 JSON_EXTRACT_SCALAR(payload, '$._font_details.table_sizes.fvar.axisSize') IS NOT NULL
GROUP BY
 client, name, axis, axisSize
