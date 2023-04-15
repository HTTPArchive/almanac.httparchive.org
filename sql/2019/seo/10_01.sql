#standardSQL
# 10_01: structured data rich results eligibility
# note: the RegExp options based on: https://developers.google.com/search/docs/guides/search-gallery
# note: homepage only data
# note: also see 10.05
CREATE TEMPORARY FUNCTION hasEligibleType(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
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

SELECT
  client,
  COUNTIF(has_eligible_type) AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(has_eligible_type) * 100 / SUM(COUNT(0)) OVER (), 2) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    hasEligibleType(payload) AS has_eligible_type
  FROM
    `httparchive.pages.2019_07_01_*`
)
GROUP BY
  client
