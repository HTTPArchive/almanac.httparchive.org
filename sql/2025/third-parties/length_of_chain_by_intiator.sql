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
  -- TP interact with other tps
  SELECT
    *
  FROM (
    SELECT
      client,
      NET.REG_DOMAIN(root_page) AS root_page,
      NET.REG_DOMAIN(url) AS third_party,
      NET.REG_DOMAIN(JSON_VALUE(payload, '$._initiator')) AS initiator_etld
    FROM
      `httparchive.crawl.requests`
    WHERE
      NET.REG_DOMAIN(root_page) != NET.REG_DOMAIN(url) AND
      date = '2025-07-01'
  )
  WHERE third_party != initiator_etld AND
    root_page != initiator_etld
  GROUP BY client, root_page, third_party, initiator_etld
)

-- Add this to the final SELECT to see top initiators by chain length
SELECT
  client,
  first_initiator,
  AVG(ARRAY_LENGTH(all_initiators)) AS avg_chain_length,
  MAX(ARRAY_LENGTH(all_initiators)) AS max_chain_length,
  COUNT(0) AS pages
FROM (
  SELECT
    root_page,
    client,
    all_initiators,
    all_initiators[OFFSET(0)] AS first_initiator  -- First third-party in chain
  FROM (
    SELECT
      root_page,
      client,
      findAllInitiators(root_page, ARRAY_AGG(STRUCT(root_page, third_party, initiator_etld))) AS all_initiators
    FROM data
    GROUP BY root_page, client
  )
  WHERE ARRAY_LENGTH(all_initiators) > 0
)
GROUP BY client, first_initiator
ORDER BY avg_chain_length DESC;
