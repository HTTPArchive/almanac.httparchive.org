#standardSQL

# structured data rich results eligibility

# note: the RegExp options based on: https://developers.google.com/search/docs/guides/search-gallery
# note: homepage only data
# note: also see 10.05

CREATE TEMPORARY FUNCTION parseStructuredData(payload STRING)
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
    COUNT(0) AS count,
    COUNTIF(parseStructuredData(payload)) AS occurence,
    ROUND(COUNTIF(parseStructuredData(payload)) * 100 / SUM(COUNT(0)) OVER (), 2) AS occurence_perc
FROM
    `httparchive.pages.2019_07_01_*`
