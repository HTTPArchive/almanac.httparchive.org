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

WITH data AS (
  -- TP interact with other tps - only extract necessary fields
  SELECT
    client,
    root_page,
    third_party,
    initiator_etld
  FROM (
    SELECT
      client,
      NET.REG_DOMAIN(root_page) AS root_page,
      NET.REG_DOMAIN(url) AS third_party,
      NET.REG_DOMAIN(JSON_VALUE(payload, '$._initiator')) AS initiator_etld
    FROM
      `httparchive.crawl.requests`
    WHERE
      date = '2025-07-01' AND
      NET.REG_DOMAIN(root_page) != NET.REG_DOMAIN(url)
  )
  WHERE third_party != initiator_etld AND
    root_page != initiator_etld
  GROUP BY client, root_page, third_party, initiator_etld
)

SELECT
  client,
  ARRAY_LENGTH(all_initiators) AS chain_length,
  COUNT(0) AS pages_with_this_length
FROM (
  SELECT
    root_page,
    client,
    findAllInitiators(root_page, ARRAY_AGG(STRUCT(root_page, third_party, initiator_etld))) AS all_initiators
  FROM data
  GROUP BY root_page, client
)
WHERE ARRAY_LENGTH(all_initiators) > 0
GROUP BY client, chain_length
ORDER BY client, chain_length;
