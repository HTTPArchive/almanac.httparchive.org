#standardSQL

# Metric: Content - looking at word count, thin pages, header usage, alt attributes images

CREATE TEMPORARY FUNCTION parseWords(payload STRING, element STRING)
RETURNS INT64 LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    return almanac['seo-words'][element];
  } catch (e) {
    return 0;
  }
''';

CREATE TEMPORARY FUNCTION parseTitle(payload STRING, element STRING)
RETURNS INT64 LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    return almanac['seo-titles'][element];
  } catch (e) {
    return 0;
  }
''';


SELECT
    # words
    APPROX_QUANTILES(parseWords(payload,'wordsCount'), 1000)[OFFSET(250)] as quantP25WordsCount,
    APPROX_QUANTILES(parseWords(payload,'wordsCount'), 1000)[OFFSET(500)] as quantMedianWordsCount,
    APPROX_QUANTILES(parseWords(payload,'wordsCount'), 1000)[OFFSET(750)] as quantP75WordsCount,
    AVG(parseWords(payload, 'wordsCount')) as avgWordsCount,
    AVG(parseWords(payload, 'wordElements')) as avgWordElements,
    # titles
    APPROX_QUANTILES(parseTitle(payload,'titleWords'), 1000)[OFFSET(250)] as quantP25TitleWords,
    APPROX_QUANTILES(parseTitle(payload,'titleWords'), 1000)[OFFSET(500)] as quantMedianTitleWords,
    APPROX_QUANTILES(parseTitle(payload,'titleWords'), 1000)[OFFSET(750)] as quantP75TitleWords,
    AVG(parseTitle(payload, 'titleWords')) as avgTitleWords,
    AVG(parseTitle(payload, 'titleElements')) as avgTitleElements
FROM
    `httparchive.pages.2019_07_01_desktop`
