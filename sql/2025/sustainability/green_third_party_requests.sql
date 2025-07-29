#standardSQL

WITH requests AS (
    SELECT
        client,
        url,
        CAST(JSON_VALUE(summary, '$.pageid') AS INT64) AS page
    FROM
        `httparchive.crawl.requests`
    WHERE
        date = '2025-06-01'
),

green AS (
    SELECT
        TRUE AS is_green,
        NET.HOST(url) AS host
    FROM
        `httparchive.almanac.green_web_foundation`
    WHERE
        date = '2025-09-01'
),

pages AS (
    SELECT
        client,
        rank,
        CAST(JSON_VALUE(summary, '$.pageid') AS INT64) AS page
    FROM
        `httparchive.crawl.pages`
    WHERE
        date = '2025-06-01'
),

third_party AS (
    SELECT
        domain,
        COUNT(DISTINCT page) AS page_usage
    FROM
        `httparchive.almanac.third_parties` AS tp
    INNER JOIN
        requests AS r
    ON NET.HOST(r.url) = NET.HOST(tp.domain)
    WHERE
        date = '2025-06-01' AND
        category NOT IN ('hosting')
    GROUP BY
        domain
    HAVING
        page_usage >= 50
),

green_tp AS (
    SELECT domain
    FROM
        `httparchive.almanac.third_parties` AS tp
    INNER JOIN
        green AS g
    ON NET.HOST(g.host) = NET.HOST(tp.domain)
    WHERE
        date = '2025-06-01' AND
        category NOT IN ('hosting')
    GROUP BY
        domain
),

base AS (
    SELECT
        client,
        page,
        rank,
        COUNT(domain) AS third_parties_per_page
    FROM
        requests
    LEFT JOIN
        third_party
    ON
        NET.HOST(requests.url) = NET.HOST(third_party.domain)
    INNER JOIN
        pages
    USING (client, page)
    GROUP BY
        client,
        page,
        rank
),

base_green AS (
    SELECT
        client,
        page,
        rank,
        COUNT(domain) AS green_third_parties_per_page
    FROM
        requests
    LEFT JOIN
        green_tp
    ON
        NET.HOST(requests.url) = NET.HOST(green_tp.domain)
    INNER JOIN
        pages
    USING (client, page)
    GROUP BY
        client,
        page,
        rank
)

SELECT
    client,
    rank_grouping,
    CASE
        WHEN rank_grouping = 0 THEN ''
        WHEN rank_grouping = 100000000 THEN 'all'
        ELSE FORMAT("%'d", rank_grouping)
    END AS ranking,
    APPROX_QUANTILES(
        third_parties_per_page, 1000
    ) [OFFSET(500)] AS p50_third_parties_per_page,
    APPROX_QUANTILES(
        green_third_parties_per_page, 1000
    ) [OFFSET(500)] AS p50_green_third_parties_per_page,
    APPROX_QUANTILES(
        SAFE_DIVIDE(green_third_parties_per_page, third_parties_per_page), 1000
    ) [OFFSET(500)] AS pct_green
FROM
    base,
    UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
INNER JOIN
    base_green
ON
    base.client = base_green.client AND
    base.page = base_green.page AND
    base.rank = base_green.rank
WHERE
    rank <= rank_grouping
GROUP BY
    client,
    rank_grouping
ORDER BY
    client,
    rank_grouping
