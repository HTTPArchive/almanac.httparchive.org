# Guide 

## perecent as 0-100
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq * 100, total), 2)
);

## perecent as 0-1
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);


fields:

AS_PERCENT(COUNTIF(contains_custom_element), COUNT(0)) AS pct_contains_custom_element,


JSON_EXTRACT_SCALAR(payload, '$._almanac') AS almanac
JSON_EXTRACT_SCALAR(payload, '$._element_count') AS element_count 
