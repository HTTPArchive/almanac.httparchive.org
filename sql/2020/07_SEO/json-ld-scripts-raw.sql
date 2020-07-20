# how many lson-ld scripts on a page
SELECT 
ARRAY_LENGTH(REGEXP_EXTRACT_ALL(body, '(?i)<script[^>]*type=[\'"]?application\\/ld\\+json[\'"]?[^>]*>(.*?)<\\/script>')) AS jsonld_scripts_count,
COUNT(0) AS number_of_pages
FROM `httparchive.sample_data.response_bodies_desktop_10k` 
WHERE page = url
GROUP BY jsonld_scripts_count
ORDER BY jsonld_scripts_count DESC;

# pages with 10 or more scripts
SELECT 
page,
ARRAY_LENGTH(REGEXP_EXTRACT_ALL(body, '(?i)<script[^>]*type=[\'"]?application\\/ld\\+json[\'"]?[^>]*>(.*?)<\\/script>')) AS jsonld_scripts_count
FROM `httparchive.sample_data.response_bodies_desktop_10k` 
WHERE page = url
AND ARRAY_LENGTH(REGEXP_EXTRACT_ALL(body, '(?i)<script[^>]*type=[\'"]?application\\/ld\\+json[\'"]?[^>]*>(.*?)<\\/script>')) > 10;

 
# broken scripts summary

CREATE TEMPORARY FUNCTION parseJsonError(jsonText STRING)
RETURNS STRING LANGUAGE js AS '''
  try {
    if (jsonText == null)
      return null;
     
    jsonText = jsonText.trim();

    jsonText = jsonText.replace(/^\\/\\*(.*?)\\*\\//g, ''); // remove comment from start (could be for CDATA section)
    jsonText = jsonText.replace(/\\/\\*(.*?)\\*\\/$/g, ''); // remove comment from end (could be for CDATA section)

    if (jsonText.length == 0)
        return null; // empty scripts cause no errors, not perfect though

    JSON.parse(jsonText);
    return null;
  } catch (e) {
    return e;
  }
''';

SELECT 
 COUNT(0) AS pages,
 COUNTIF(json_scripts > 0) AS have_jsonld_scripts,
 COUNTIF(invalid_json_errors > 0) AS have_json_errors,
 ROUND(COUNTIF(json_scripts > 0) / COUNT(0), 2) AS pct_pages_with_jsonld,
 ROUND(COUNTIF(invalid_json_errors > 0) / COUNT(0), 4) AS pct_pages_with_json_errors
FROM (
    SELECT 
        page,
        COUNTIF(jsonld_script IS NOT NULL) AS json_scripts,
        COUNTIF(invalid_json_error IS NOT NULL) AS invalid_json_errors
    FROM (
        SELECT # row per script found. so no page if no scripts
            page,
            jsonld_script,
            parseJsonError(jsonld_script) AS invalid_json_error # is the script parsable
        FROM `httparchive.sample_data.response_bodies_desktop_10k` 
        LEFT JOIN UNNEST(REGEXP_EXTRACT_ALL(body, '(?i)<script[^>]*type=[\'"]?application\\/ld\\+json[\'"]?[^>]*>(.*?)<\\/script>')) AS jsonld_script
        WHERE page = url
    )
    GROUP BY page
);

# broken scripts - show examples

CREATE TEMPORARY FUNCTION parseJsonError(jsonText STRING)
RETURNS STRING LANGUAGE js AS '''
  try {
    jsonText = jsonText.trim();

    jsonText = jsonText.replace(/^\\/\\*(.*?)\\*\\//g, ''); // remove comment from start (could be for CDATA section)
    jsonText = jsonText.replace(/\\/\\*(.*?)\\*\\/$/g, ''); // remove comment from end (could be for CDATA section)

    if (jsonText.length == 0)
        return null; // empty scripts cause no errors, not perfect though
    JSON.parse(jsonText);
    return null;
  } catch (e) {
    return e;
  }
''';

SELECT 
  page,
  jsonld_script,
  invalid_json_scripts_error
 FROM (
  SELECT # row per script found
  page,
  jsonld_script,
  parseJsonError(jsonld_script) AS invalid_json_scripts_error # is the script parsable
  FROM `httparchive.sample_data.response_bodies_desktop_10k`, 
  UNNEST(REGEXP_EXTRACT_ALL(body, '(?i)<script[^>]*type=[\'"]?application\\/ld\\+json[\'"]?[^>]*>(.*?)<\\/script>')) AS jsonld_script
  WHERE page = url
  )
WHERE invalid_json_scripts_error IS NOT NULL
LIMIT 100;
