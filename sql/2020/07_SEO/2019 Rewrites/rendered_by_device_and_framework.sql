#standardSQL
# gather data from almanac.js

CREATE TEMPORARY FUNCTION sdHasEligibleType(almanacJsonString STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
  try {
    var almanac = JSON.parse(almanacJsonString);
    var found = almanac['10.5'].findIndex(type => {
        if(type.match(/(Breadcrumb|SearchAction|Offer|AggregateRating|Event|Review|Rating|SoftwareApplication|ContactPoint|NewsArticle|Book|Recipe|Course|EmployerAggregateRating|ClaimReview|Question|HowTo|JobPosting|LocalBusiness|Organization|Product|SpeakableSpecification|VideoObject)/i)) {
            return true;
        }
    });
    return found >= 0 ? true : false;
  } catch (e) {
    return false;
  }
''';

CREATE TEMP FUNCTION hasAmpLink(almanacJsonString STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var almanac = JSON.parse(almanacJsonString);
  return !!almanac['link-nodes'].find(node => {
    return node.rel && node.rel.toLowerCase() == 'amphtml'; 
  });
} catch (e) {
  return false;
}
''';

CREATE TEMP FUNCTION hasHrefLang(almanacJsonString STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var almanac = JSON.parse(almanacJsonString);
  return !!almanac['link-nodes'].find(node => node.hreflang); // happy if we find one
} catch (e) {
  return false;
}
''';


SELECT
  client,
  framework,
  COUNT(0) AS total,

  # AMP
  COUNTIF(has_amp_link) AS has_amp_link,
  ROUND(COUNTIF(has_amp_link) * 100 / COUNT(0), 2) AS pct_has_amp_link,
  ROUND(COUNTIF(has_amp_link) * 100 / SUM(COUNT(0)) OVER (), 2) AS pct_overall_sd_has_amp_link,

  # Hreflang
  COUNTIF(has_hreflang) AS has_hreflang,
  ROUND(COUNTIF(has_hreflang) * 100 / COUNT(0), 2) AS pct_has_hreflang,
  ROUND(COUNTIF(has_hreflang) * 100 / SUM(COUNT(0)) OVER (), 2) AS pct_overall_sd_has_hreflang,

  # Zero count words and headers (from 2019)
  ROUND(COUNTIF(words_count = 0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) as pct_word_count_zero,
  ROUND(COUNTIF(header_elements  = 0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2)as pct_header_count_zero,

  # https
  COUNTIF(STARTS_WITH(url, 'https')) AS https,
  COUNTIF(STARTS_WITH(url, 'http:')) AS http,
  ROUND(COUNTIF(STARTS_WITH(url, 'https')) * 100 / COUNT(0), 2) AS pct_https,
  ROUND(COUNTIF(STARTS_WITH(url, 'http:')) * 100 / COUNT(0), 2) AS pct_http,

  # zero links 
  ROUND(COUNTIF(internal_links  = 0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct_internal_link_zero,
  ROUND(COUNTIF(external_links  = 0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct_external_link_zero,
  ROUND(COUNTIF(hash_links = 0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct_hash_link_zero,
  ROUND(COUNTIF(navigate_hash_links = 0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct_navigate_hash_links_zero,

  # Structured Data 
  COUNTIF(sd_has_eligible_type) AS sd_has_eligible_type,
  ROUND(COUNTIF(sd_has_eligible_type) * 100 / COUNT(0), 2) AS pct_sd_has_eligible_type,
  ROUND(COUNTIF(sd_has_eligible_type) * 100 / SUM(COUNT(0)) OVER (), 2) AS pct_overall_sd_has_eligible_type,

  COUNTIF(jsonld_scripts_count > 0) AS has_jsonld_scripts,
  ROUND(COUNTIF(jsonld_scripts_count > 0) * 100 / COUNT(0), 2) AS pct_have_jsonld_scripts,
  ROUND(COUNTIF(jsonld_scripts_count > 0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct_overall_have_jsonld_scripts,

  COUNTIF(jsonld_scripts_error_count > 0) AS has_jsonld_script_errors,
  ROUND(COUNTIF(jsonld_scripts_error_count > 0) * 100 / COUNT(0), 2) AS pct_have_jsonld_script_errors,
  ROUND(COUNTIF(jsonld_scripts_error_count > 0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct_overall_have_jsonld_script_errors
FROM (
  SELECT
    client,
    framework,
    url,
    sdHasEligibleType(almanac) AS sd_has_eligible_type,
    hasAmpLink(almanac) AS has_amp_link,
    hasHrefLang(almanac) AS has_hreflang,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['seo-words'].wordsCount") AS INT64) AS words_count,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['seo-titles'].titleElements") AS INT64) AS header_elements,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['seo-anchor-elements'].internal") AS INT64) AS internal_links,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['seo-anchor-elements'].external") AS INT64) AS external_links,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['seo-anchor-elements'].hash") AS INT64) AS hash_links,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['seo-anchor-elements'].navigateHash") AS INT64) AS navigate_hash_links,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['structured-data'].jsonLdScriptCount") AS INT64) AS jsonld_scripts_count,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['structured-data'].jsonLdScriptErrorCount") AS INT64) AS jsonld_scripts_error_count
  FROM
  ( 
    SELECT 
    _TABLE_SUFFIX AS client,
    technologies.app AS framework,
    url,
    #payload,
    JSON_EXTRACT_SCALAR(payload, '$._almanac') AS almanac
    #JSON_EXTRACT_SCALAR(payload, '$._element_count') AS elements # all elements on the page?
    FROM
    `httparchive.sample_data.pages_*`
    LEFT JOIN
    `httparchive.sample_data.technologies_desktop_10k` AS technologies
    USING (url)
    WHERE
        category = 'JavaScript frameworks'
  )
)
GROUP BY
  client, framework