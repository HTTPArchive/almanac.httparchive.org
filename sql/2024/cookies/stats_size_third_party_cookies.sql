-- Stats about size of third party cookies set on websites

CREATE TEMP FUNCTION
ExactPercentile(arr ARRAY<INT>,percentile FLOAT64)
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
  MIN(CAST(size AS INT)) as min_value,
  AVG(CAST(size AS INT)) as avg_value,
  MAX(CAST(size AS INT)) as max_value,
  ExactPercentile(ARRAY_AGG(CAST(size AS INT)), 0.5) AS percentile_25,
  ExactPercentile(ARRAY_AGG(CAST(size AS INT)), 0.5) AS percentile_50,
  ExactPercentile(ARRAY_AGG(CAST(size AS INT)), 0.75) AS percentile_75,
  ExactPercentile(ARRAY_AGG(CAST(size AS INT)), 0.9) AS percentile_90,
  ExactPercentile(ARRAY_AGG(CAST(size AS INT)), 0.99) AS percentile_99
FROM `httparchive.almanac.2024-06-01_top10k_cookies`
WHERE
  is_first_party = FALSE
GROUP BY client
