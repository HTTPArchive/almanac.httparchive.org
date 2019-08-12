#standardSQL
# Percentage of script execution time that are from third party requests broken down by third party category.
SELECT
  thirdPartyCategory,
  SUM(executionTime) AS totalExecutionTime,
  ROUND(SUM(executionTime) * 100 / SUM(SUM(executionTime)) OVER (), 4) AS percentExecutionTime
FROM ((
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[0].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[0].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[1].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[1].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[2].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[2].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[3].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[3].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[4].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[4].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[5].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[5].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[6].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[6].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[7].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[7].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[8].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[8].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[9].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[9].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[10].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[10].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[11].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[11].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[12].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[12].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[13].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[13].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[14].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[14].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[15].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[15].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[16].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[16].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[17].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[17].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[18].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[18].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[19].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[19].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[20].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[20].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[21].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[21].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[22].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[22].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[23].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[23].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[24].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[24].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[25].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[25].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[26].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[26].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[27].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[27].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[28].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[28].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[29].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[29].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[30].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[30].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[31].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[31].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[32].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[32].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[33].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[33].url')) = domain )
  UNION ALL (
    SELECT
      category AS thirdPartyCategory,
      SAFE_CAST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[34].scripting') AS FLOAT64) AS executionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01`
    ON
      NET.HOST(JSON_EXTRACT(report,
          '$.audits.bootup-time.details.items[34].url')) = domain ))
GROUP BY
  thirdPartyCategory
ORDER BY
  percentExecutionTime DESC
