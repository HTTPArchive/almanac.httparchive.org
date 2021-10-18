SELECT
    client,
    percentile,
    APPROX_QUANTILES(custom_elements,
        1000)[OFFSET(percentile * 10)] AS custom_elements,
    APPROX_QUANTILES(shadow_roots,
        1000)[OFFSET(percentile * 10)] AS shadow_roots,
    APPROX_QUANTILES(template,
        1000)[OFFSET(percentile * 10)] AS template
FROM
    (SELECT
        _table_suffix AS client,
        (CASE
                 WHEN
            ARRAY_LENGTH(
                JSON_QUERY_ARRAY(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload,
                                                                       '$._javascript'
                                                                  ),
                                                                       '$.web_component_specs.custom_elements'
                                                                  ))) > 1 THEN 1
                 ELSE 0
             END) AS custom_elements,
        (CASE
                 WHEN
            ARRAY_LENGTH(
                JSON_QUERY_ARRAY(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload,
                                                                       '$._javascript'
                                                                  ),
                                                                       '$.web_component_specs.shadow_roots'
                                                                  ))) > 1 THEN 1
                 ELSE 0
             END) AS shadow_roots,
        (CASE
                 WHEN
            ARRAY_LENGTH(
                JSON_QUERY_ARRAY(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload,
                                                                       '$._javascript'
                                                                  ),
                                                                       '$.web_component_specs.template'
                                                                  ))) > 1 THEN 1
                 ELSE 0
             END) AS template
    FROM
    `httparchive.pages.2021_09_01_*` ),
    UNNEST([10, 25, 50, 75, 90, 100])
GROUP BY
    percentile,
    client
ORDER BY
    percentile,
    client
