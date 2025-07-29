#standardSQL

# Median resource weights by static site generator with detailed CO2e breakdown
# Source: https://sustainablewebdesign.org/calculating-digital-emissions/
# Declare variables to calculate the carbon emissions per gigabyte (kWh/GB)

DECLARE grid_intensity NUMERIC DEFAULT 494;
DECLARE embodied_emissions_data_centers NUMERIC DEFAULT 0.012;
DECLARE embodied_emissions_network NUMERIC DEFAULT 0.013;
DECLARE embodied_emissions_user_devices NUMERIC DEFAULT 0.081;
DECLARE operational_emissions_data_centers NUMERIC DEFAULT 0.055;
DECLARE operational_emissions_network NUMERIC DEFAULT 0.059;
DECLARE operational_emissions_user_devices NUMERIC DEFAULT 0.080;

WITH ssg_data AS (
    SELECT
        client,
        page,
        tech.technology AS ssg,
        CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64) / 1024 AS total_kb,

        -- Operational emissions calculations
        (
            CAST(
                JSON_VALUE(summary, '$.bytesTotal') AS INT64
            ) / 1024 / 1024 / 1024
        ) * operational_emissions_data_centers *
        grid_intensity AS op_emissions_dc,
        (
            CAST(
                JSON_VALUE(summary, '$.bytesTotal') AS INT64
            ) / 1024 / 1024 / 1024
        ) * operational_emissions_network *
        grid_intensity AS op_emissions_networks,
        (
            CAST(
                JSON_VALUE(summary, '$.bytesTotal') AS INT64
            ) / 1024 / 1024 / 1024
        ) * operational_emissions_user_devices *
        grid_intensity AS op_emissions_devices,

        -- Embodied emissions calculations
        (
            CAST(
                JSON_VALUE(summary, '$.bytesTotal') AS INT64
            ) / 1024 / 1024 / 1024
        ) * embodied_emissions_data_centers *
        grid_intensity AS em_emissions_dc,
        (
            CAST(
                JSON_VALUE(summary, '$.bytesTotal') AS INT64
            ) / 1024 / 1024 / 1024
        ) * embodied_emissions_network *
        grid_intensity AS em_emissions_networks,
        (
            CAST(
                JSON_VALUE(summary, '$.bytesTotal') AS INT64
            ) / 1024 / 1024 / 1024
        ) * embodied_emissions_user_devices *
        grid_intensity AS em_emissions_devices,

        -- Total emissions (operational + embodied)
        (
            (
                CAST(
                    JSON_VALUE(summary, '$.bytesTotal') AS INT64
                ) / 1024 / 1024 / 1024
            ) * operational_emissions_data_centers * grid_intensity +
            (
                CAST(
                    JSON_VALUE(summary, '$.bytesTotal') AS INT64
                ) / 1024 / 1024 / 1024
            ) * operational_emissions_network * grid_intensity +
            (
                CAST(
                    JSON_VALUE(summary, '$.bytesTotal') AS INT64
                ) / 1024 / 1024 / 1024
            ) * operational_emissions_user_devices * grid_intensity
        ) AS total_operational_emissions,

        (
            (
                CAST(
                    JSON_VALUE(summary, '$.bytesTotal') AS INT64
                ) / 1024 / 1024 / 1024
            ) * embodied_emissions_data_centers * grid_intensity +
            (
                CAST(
                    JSON_VALUE(summary, '$.bytesTotal') AS INT64
                ) / 1024 / 1024 / 1024
            ) * embodied_emissions_network * grid_intensity +
            (
                CAST(
                    JSON_VALUE(summary, '$.bytesTotal') AS INT64
                ) / 1024 / 1024 / 1024
            ) * embodied_emissions_user_devices * grid_intensity
        ) AS total_embodied_emissions,

        (
            (
                CAST(
                    JSON_VALUE(summary, '$.bytesTotal') AS INT64
                ) / 1024 / 1024 / 1024
            ) * operational_emissions_data_centers * grid_intensity +
            (
                CAST(
                    JSON_VALUE(summary, '$.bytesTotal') AS INT64
                ) / 1024 / 1024 / 1024
            ) * operational_emissions_network * grid_intensity +
            (
                CAST(
                    JSON_VALUE(summary, '$.bytesTotal') AS INT64
                ) / 1024 / 1024 / 1024
            ) * operational_emissions_user_devices * grid_intensity +
            (
                CAST(
                    JSON_VALUE(summary, '$.bytesTotal') AS INT64
                ) / 1024 / 1024 / 1024
            ) * embodied_emissions_data_centers * grid_intensity +
            (
                CAST(
                    JSON_VALUE(summary, '$.bytesTotal') AS INT64
                ) / 1024 / 1024 / 1024
            ) * embodied_emissions_network * grid_intensity +
            (
                CAST(
                    JSON_VALUE(summary, '$.bytesTotal') AS INT64
                ) / 1024 / 1024 / 1024
            ) * embodied_emissions_user_devices * grid_intensity
        ) AS total_emissions,

        -- Proportions of each resource type relative to total bytes
        CAST(
            JSON_VALUE(summary, '$.bytesHtml') AS INT64
        ) / CAST(
            JSON_VALUE(summary, '$.bytesTotal') AS INT64
        ) AS html_proportion,
        CAST(
            JSON_VALUE(summary, '$.bytesJS') AS INT64
        ) / CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64) AS js_proportion,
        CAST(
            JSON_VALUE(summary, '$.bytesCss') AS INT64
        ) / CAST(
            JSON_VALUE(summary, '$.bytesTotal') AS INT64
        ) AS css_proportion,
        CAST(
            JSON_VALUE(summary, '$.bytesImg') AS INT64
        ) / CAST(
            JSON_VALUE(summary, '$.bytesTotal') AS INT64
        ) AS img_proportion,
        CAST(
            JSON_VALUE(summary, '$.bytesFont') AS INT64
        ) / CAST(
            JSON_VALUE(summary, '$.bytesTotal') AS INT64
        ) AS font_proportion,

        -- Resource-specific emissions calculations
        (
            SAFE_DIVIDE(
                CAST(JSON_VALUE(summary, '$.bytesHtml') AS INT64),
                CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64)
            ) * (
                (
                    CAST(
                        JSON_VALUE(summary, '$.bytesTotal') AS INT64
                    ) / 1024 / 1024 / 1024
                ) * (
                    operational_emissions_data_centers * grid_intensity +
                    operational_emissions_network * grid_intensity +
                    operational_emissions_user_devices * grid_intensity +
                    embodied_emissions_data_centers * grid_intensity +
                    embodied_emissions_network * grid_intensity +
                    embodied_emissions_user_devices * grid_intensity
                )
            )) AS total_html_emissions,

        (
            SAFE_DIVIDE(
                CAST(JSON_VALUE(summary, '$.bytesJS') AS INT64),
                CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64)
            ) * (
                (
                    CAST(
                        JSON_VALUE(summary, '$.bytesTotal') AS INT64
                    ) / 1024 / 1024 / 1024
                ) * (
                    operational_emissions_data_centers * grid_intensity +
                    operational_emissions_network * grid_intensity +
                    operational_emissions_user_devices * grid_intensity +
                    embodied_emissions_data_centers * grid_intensity +
                    embodied_emissions_network * grid_intensity +
                    embodied_emissions_user_devices * grid_intensity
                )
            )) AS total_js_emissions,

        (
            SAFE_DIVIDE(
                CAST(JSON_VALUE(summary, '$.bytesCss') AS INT64),
                CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64)
            ) * (
                (
                    CAST(
                        JSON_VALUE(summary, '$.bytesTotal') AS INT64
                    ) / 1024 / 1024 / 1024
                ) * (
                    operational_emissions_data_centers * grid_intensity +
                    operational_emissions_network * grid_intensity +
                    operational_emissions_user_devices * grid_intensity +
                    embodied_emissions_data_centers * grid_intensity +
                    embodied_emissions_network * grid_intensity +
                    embodied_emissions_user_devices * grid_intensity
                )
            )) AS total_css_emissions,

        (
            SAFE_DIVIDE(
                CAST(JSON_VALUE(summary, '$.bytesImg') AS INT64),
                CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64)
            ) * (
                (
                    CAST(
                        JSON_VALUE(summary, '$.bytesTotal') AS INT64
                    ) / 1024 / 1024 / 1024
                ) * (
                    operational_emissions_data_centers * grid_intensity +
                    operational_emissions_network * grid_intensity +
                    operational_emissions_user_devices * grid_intensity +
                    embodied_emissions_data_centers * grid_intensity +
                    embodied_emissions_network * grid_intensity +
                    embodied_emissions_user_devices * grid_intensity
                )
            )) AS total_img_emissions,

        (
            SAFE_DIVIDE(
                CAST(JSON_VALUE(summary, '$.bytesFont') AS INT64),
                CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64)
            ) * (
                (
                    CAST(
                        JSON_VALUE(summary, '$.bytesTotal') AS INT64
                    ) / 1024 / 1024 / 1024
                ) * (
                    operational_emissions_data_centers * grid_intensity +
                    operational_emissions_network * grid_intensity +
                    operational_emissions_user_devices * grid_intensity +
                    embodied_emissions_data_centers * grid_intensity +
                    embodied_emissions_network * grid_intensity +
                    embodied_emissions_user_devices * grid_intensity
                )
            )) AS total_font_emissions,

        -- Resource-specific size in KB
        CAST(JSON_VALUE(summary, '$.bytesHtml') AS INT64) / 1024 AS html_kb,
        CAST(JSON_VALUE(summary, '$.bytesJS') AS INT64) / 1024 AS js_kb,
        CAST(JSON_VALUE(summary, '$.bytesCss') AS INT64) / 1024 AS css_kb,
        CAST(JSON_VALUE(summary, '$.bytesImg') AS INT64) / 1024 AS img_kb,
        CAST(JSON_VALUE(summary, '$.bytesFont') AS INT64) / 1024 AS font_kb

    FROM
        `httparchive.crawl.pages`,
        UNNEST(technologies) AS tech
    WHERE
        date = '2025-06-01' AND
        is_root_page = TRUE AND
        EXISTS (
            SELECT 1
            FROM UNNEST(tech.categories) AS category
            WHERE LOWER(category) = 'static site generator' OR
                tech.technology IN ('Next.js', 'Nuxt.js')
        )
)

SELECT
    client,
    ssg,
    COUNT(*) AS pages,

    -- Median resource weights and emissions
    APPROX_QUANTILES(total_kb, 1000) [OFFSET(500)] AS median_total_kb,
    APPROX_QUANTILES(
        total_operational_emissions, 1000
    ) [OFFSET(500)] AS median_operational_emissions,
    APPROX_QUANTILES(
        total_embodied_emissions, 1000
    ) [OFFSET(500)] AS median_embodied_emissions,
    APPROX_QUANTILES(
        total_emissions, 1000
    ) [OFFSET(500)] AS median_total_emissions,

    -- Resource-specific medians
    APPROX_QUANTILES(html_kb, 1000) [OFFSET(500)] AS median_html_kb,
    APPROX_QUANTILES(
        total_html_emissions, 1000
    ) [OFFSET(500)] AS median_total_html_emissions,
    APPROX_QUANTILES(js_kb, 1000) [OFFSET(500)] AS median_js_kb,
    APPROX_QUANTILES(
        total_js_emissions, 1000
    ) [OFFSET(500)] AS median_total_js_emissions,
    APPROX_QUANTILES(css_kb, 1000) [OFFSET(500)] AS median_css_kb,
    APPROX_QUANTILES(
        total_css_emissions, 1000
    ) [OFFSET(500)] AS median_total_css_emissions,
    APPROX_QUANTILES(img_kb, 1000) [OFFSET(500)] AS median_img_kb,
    APPROX_QUANTILES(
        total_img_emissions, 1000
    ) [OFFSET(500)] AS median_total_img_emissions,
    APPROX_QUANTILES(font_kb, 1000) [OFFSET(500)] AS median_font_kb,
    APPROX_QUANTILES(
        total_font_emissions, 1000
    ) [OFFSET(500)] AS median_total_font_emissions

FROM
    ssg_data
GROUP BY
    client,
    ssg
ORDER BY
    pages DESC,
    ssg ASC,
    client ASC;
