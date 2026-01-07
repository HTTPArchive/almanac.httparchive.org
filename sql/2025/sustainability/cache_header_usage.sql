#standardSQL
# The distribution of cache header adoption on websites by client.

SELECT
    client,
    COUNT(*) AS total_requests,

    COUNTIF(uses_cache_control) AS total_using_cache_control,
    COUNTIF(uses_max_age) AS total_using_max_age,
    COUNTIF(uses_expires) AS total_using_expires,
    COUNTIF(uses_max_age AND uses_expires) AS total_using_max_age_and_expires,
    COUNTIF(
        uses_cache_control AND uses_expires
    ) AS total_using_both_cc_and_expires,
    COUNTIF(
        NOT uses_cache_control AND NOT uses_expires
    ) AS total_using_neither_cc_and_expires,
    COUNTIF(
        uses_cache_control AND NOT uses_expires
    ) AS total_using_only_cache_control,
    COUNTIF(
        NOT uses_cache_control AND uses_expires
    ) AS total_using_only_expires,

    COUNTIF(uses_cache_control) / COUNT(*) AS pct_cache_control,
    COUNTIF(uses_max_age) / COUNT(*) AS pct_using_max_age,
    COUNTIF(uses_expires) / COUNT(*) AS pct_using_expires,
    COUNTIF(
        uses_max_age AND uses_expires
    ) / COUNT(*) AS pct_using_max_age_and_expires,
    COUNTIF(
        uses_cache_control AND uses_expires
    ) / COUNT(*) AS pct_using_both_cc_and_expires,
    COUNTIF(
        NOT uses_cache_control AND NOT uses_expires
    ) / COUNT(*) AS pct_using_neither_cc_nor_expires,
    COUNTIF(
        uses_cache_control AND NOT uses_expires
    ) / COUNT(*) AS pct_using_only_cache_control,
    COUNTIF(
        NOT uses_cache_control AND uses_expires
    ) / COUNT(*) AS pct_using_only_expires

FROM (
        SELECT
            client,
            url,
            LOGICAL_OR(
                header.name = 'expires' AND header.value IS NOT NULL AND TRIM(
                    header.value
                ) != ''
            ) AS uses_expires,
            LOGICAL_OR(
                header.name = 'cache-control' AND
                header.value IS NOT NULL AND
                TRIM(header.value) != ''
            ) AS uses_cache_control,
            LOGICAL_OR(
                header.name = 'cache-control' AND REGEXP_CONTAINS(
                    header.value, r'(?i)max-age\s*=\s*[0-9]+'
                )
            ) AS uses_max_age,

            LOGICAL_OR(
                header.name = 'etag' AND (
                    header.value IS NULL OR TRIM(header.value) = ''
                )
            ) AS uses_no_etag,
            LOGICAL_OR(
                header.name = 'etag' AND header.value IS NOT NULL AND TRIM(
                    header.value
                ) != ''
            ) AS uses_etag,
            LOGICAL_OR(
                header.name = 'last-modified' AND
                header.value IS NOT NULL AND
                TRIM(header.value) != ''
            ) AS uses_last_modified,

            LOGICAL_OR(
                header.name = 'etag' AND REGEXP_CONTAINS(
                    TRIM(header.value), '^W/".*"'
                )
            ) AS uses_weak_etag,
            LOGICAL_OR(
                header.name = 'etag' AND REGEXP_CONTAINS(
                    TRIM(header.value), '^".*"'
                )
            ) AS uses_strong_etag

        FROM
            `httparchive.crawl.requests`,
            UNNEST(response_headers) AS header
        WHERE
            date = '2025-07-01'
        GROUP BY
            client,
            url
)

GROUP BY
    client
ORDER BY
    client;
