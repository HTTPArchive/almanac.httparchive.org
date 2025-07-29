#standardSQL
# Median third-parties & green third-party requests per websites by rank

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
        tp.domain,
        COUNT(DISTINCT r.page) AS page_usage
    FROM
        `httparchive.almanac.third_parties` AS tp
    INNER JOIN
        requests AS r
    ON NET.HOST(r.url) = NET.HOST(tp.domain)
    WHERE
        tp.date = '2025-06-01' AND
        tp.category NOT IN ('hosting')
    GROUP BY
        tp.domain
    HAVING
        page_usage >= 50
),

green_tp AS (
    SELECT tp.domain
    FROM
        `httparchive.almanac.third_parties` AS tp
    INNER JOIN
        green AS g
    ON NET.HOST(g.host) = NET.HOST(tp.domain)
    WHERE
        tp.date = '2025-06-01' AND
        tp.category NOT IN ('hosting')
    GROUP BY
        tp.domain
),

base AS (
    SELECT
        r.client,
        r.page,
        p.rank,
        COUNT(tp.domain) AS third_parties_per_page
    FROM
        requests AS r
    LEFT JOIN
        third_party AS tp
    ON
        NET.HOST(r.url) = NET.HOST(tp.domain)
    INNER JOIN
        pages AS p
    ON r.client = p.client AND r.page = p.page
    GROUP BY
        r.client,
        r.page,
        p.rank
),

base_green AS (
    SELECT
        r.client,
        r.page,
        p.rank,
        COUNT(gtp.domain) AS green_third_parties_per_page
    FROM
        requests AS r
    LEFT JOIN
        green_tp AS gtp
    ON
        NET.HOST(r.url) = NET.HOST(gtp.domain)
    INNER JOIN
        pages AS p
    ON r.client = p.client AND r.page = p.page
    GROUP BY
        r.client,
        r.page,
        p.rank
)

SELECT
    b.client,
    rank_grouping,
    CASE
        WHEN rank_grouping = 0 THEN ''
        WHEN rank_grouping = 100000000 THEN 'all'
        ELSE FORMAT("%'d", rank_grouping)
    END AS ranking,
    APPROX_QUANTILES(
        b.third_parties_per_page, 1000
    ) [OFFSET(500)] AS p50_third_parties_per_page,
    APPROX_QUANTILES(
        bg.green_third_parties_per_page, 1000
    ) [OFFSET(500)] AS p50_green_third_parties_per_page,
    APPROX_QUANTILES(
        SAFE_DIVIDE(
            bg.green_third_parties_per_page,
            b.third_parties_per_page
        ), 1000
    ) [OFFSET(500)] AS pct_green
FROM
    base AS b,
    UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
INNER JOIN
    base_green AS bg
ON
    b.client = bg.client AND
    b.page = bg.page AND
    b.rank = bg.rank
WHERE
    b.rank <= rank_grouping
GROUP BY
    b.client,
    rank_grouping
ORDER BY
    b.client,
    rank_grouping
