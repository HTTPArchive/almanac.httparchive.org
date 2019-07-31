#standardSQL

# structured data
# search action
# reviews
# breadcrumbs
# ...

# dataset: `httparchive.pages.2019_07_01_desktop`
# sample: `httparchive.almanac.pages_desktop_1k`
# todo: occurence_perc
# note: the RegExp options based on: https://developers.google.com/search/docs/guides/search-gallery
# note: homepage only data
# note: also see 10.05

CREATE TEMPORARY FUNCTION parseStructuredData(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    return Array.from(almanac['10.5']);
  } catch (e) {
    return [];
  }
''';

SELECT
    flattened_105,
    COUNT(flattened_105) AS occurence,
    COUNT(flattened_105) / COUNT(url) AS occurence_perc
FROM
    `httparchive.almanac.pages_desktop_1k`
CROSS JOIN
    UNNEST(parseStructuredData(payload)) as flattened_105
WHERE REGEXP_CONTAINS(flattened_105, '/(Breadcrumb|SearchAction|Offer|AggregateRating|Event|Review|Rating|SoftwareApplication|ContactPoint|NewsArticle|Book|Recipe|Course|EmployerAggregateRating|ClaimReview|Question|HowTo|JobPosting|LocalBusiness|Organization|Product|SpeakableSpecification|VideoObject)/i')
GROUP BY flattened_105
ORDER BY occurence DESC
