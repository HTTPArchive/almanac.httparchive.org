-- Stats about expires of first party cookies set on websites

CREATE TEMP FUNCTION
ExactPercentile(arr ARRAY<FLOAT64>,percentile FLOAT64)
RETURNS FLOAT64
LANGUAGE js AS """
var sortedArray = arr.slice().sort(function(a, b) {
return a - b;
});

var index = (sortedArray.length - 1) * percentile;
var lower = Math.floor(index);
var upper = Math.ceil(index);

if (lower === upper) {
return sortedArray[lower];
}

var fraction = index - lower;
return sortedArray[lower] * (1 - fraction) + sortedArray[upper] * fraction;
""";

SELECT
  client,
  MIN(ROUND(CAST(expires AS FLOAT64),9)) as min_value,
  AVG(ROUND(CAST(expires AS FLOAT64),9)) as avg_value,
  MAX(ROUND(CAST(expires AS FLOAT64),9)) as max_value,
  ExactPercentile(ARRAY_AGG(ROUND(CAST(expires AS FLOAT64),9)), 0.5) AS percentile_25,
  ExactPercentile(ARRAY_AGG(ROUND(CAST(expires AS FLOAT64),9)), 0.5) AS percentile_50,
  ExactPercentile(ARRAY_AGG(ROUND(CAST(expires AS FLOAT64),9)), 0.75) AS percentile_75,
  ExactPercentile(ARRAY_AGG(ROUND(CAST(expires AS FLOAT64),9)), 0.9) AS percentile_90,
  ExactPercentile(ARRAY_AGG(ROUND(CAST(expires AS FLOAT64),9)), 0.99) AS percentile_99
FROM `httparchive.almanac.2024-06-01_top10k_cookies`
WHERE
  is_first_party = FALSE
GROUP BY client
