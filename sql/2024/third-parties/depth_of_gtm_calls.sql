CREATE TEMP FUNCTION findAllInitiators(rootPage STRING, data ARRAY<STRUCT<root_page STRING, third_party STRING, initiator_etld STRING>>)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
  // Helper function to find all initiator_etlds for a given root_page
  function findInitiators(page, visited, data) {
    // Find all entries where the root_page matches and the initiator_etld hasn't been visited
    const initiators = data
      .filter(row => row.root_page === page && !visited.includes(row.initiator_etld))
      .map(row => row.initiator_etld);

    // Add the newly found initiators to the visited list
    visited = visited.concat(initiators);

    // Recursively process all new initiators
    initiators.forEach(initiator => {
      visited = findInitiators(initiator, visited, data);
    });

    return visited;
  }

  // Main call: Start recursion from the rootPage
  // Use a Set to ensure that all returned values are distinct
  return Array.from(new Set(findInitiators(rootPage, [], data)));
""";



CREATE TEMP FUNCTION mean_depth_and_next_element_after_gtm(input_array ARRAY<STRING>)
RETURNS STRUCT<mean_depth FLOAT64, next_elements ARRAY<STRING>>
LANGUAGE js AS """
  // Initialize the array to hold names of next elements
  const nextElements = [];

  // Traverse the input array to find "googletagmanager.com" and capture the next element
  for (let i = 0; i < input_array.length - 1; i++) { // -1 to avoid out-of-bounds
    if (input_array[i] === 'googletagmanager.com') {
      nextElements.push(input_array[i + 1]);
    }
  }

  // If no "googletagmanager.com" is found, return NULL
  if (nextElements.length === 0) {
    return { mean_depth: null, next_elements: [] };
  }

  // Calculate mean depth for all next elements
  const meanDepth = nextElements.length > 0
    ? nextElements.reduce((sum, _, idx) => sum + (idx + 2), 0) / nextElements.length
    : null;

  // Return the result as a struct
  return { mean_depth: meanDepth, next_elements: nextElements };
""";


with data as (
  -- TP interact with other tps
  SELECT
  *
  FROM (
  SELECT
    client,
    NET.REG_DOMAIN(root_page) root_page,
    NET.REG_DOMAIN(url) third_party,
    NET.REG_DOMAIN(JSON_VALUE(payload, '$._initiator')) initiator_etld
  FROM
    httparchive.all.requests
    #TABLESAMPLE SYSTEM (0.01 PERCENT)
  WHERE
    NET.REG_DOMAIN(root_page) != NET.REG_DOMAIN(url)
    AND date = "2024-06-01")
    WHERE third_party != initiator_etld
    AND root_page != initiator_etld
    group by client, root_page, third_party, initiator_etld
)

SELECT client, next_elements_after_gtm, count(*) c FROM(
SELECT
  client,
  result.mean_depth AS mean_depth_after_gtm,
  result.next_elements AS next_elements_after_gtm
FROM (
SELECT
  root_page,
  client,
    findAllInitiators(root_page, ARRAY_AGG(STRUCT(root_page, third_party, initiator_etld))) AS all_initiators
FROM data
group by root_page, client),
UNNEST([mean_depth_and_next_element_after_gtm(all_initiators)]) AS result
WHERE result.mean_depth is not null
OrDER by mean_depth_after_gtm) group by client, next_elements_after_gtm order by c ;

