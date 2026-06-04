#standardSQL
# - average of at-rules per page, per year
# - average of selectors per page, per year
# - average of declarations per page, per year
# - average of lines of code per page, per year
# - maximum of at-rules per page, per year
# - maximum of selectors per page, per year
# - maximum of declarations per page, per year
# - maximum of lines of code per page, per year
CREATE TEMPORARY FUNCTION getSourceLocStats(parsedCss JSON)
RETURNS STRUCT<atRules INT64, selectors INT64, declarations INT64>
LANGUAGE js
AS '''
const AT_RULE_TYPES = [
  'charset',
  'custom-media',
  'document',
  'font-face',
  'host',
  'import',
  'keyframes',
  'media',
  'namespace',
  'page',
  'supports',
]

function processNode(node) {
  let atRules = 0;
  let selectors = 0;
  let declarations = 0;
  if (AT_RULE_TYPES.includes(node.type))
    atRules += 1;
  if (node.type === 'rule' && node.selectors !== undefined) {
    selectors += node.selectors.length;
  }
  if ((node.type === 'rule' || node.type === 'keyframe') && node.declarations !== undefined) {
    declarations += node.declarations.length;
  }
  if (node.type === 'stylesheet' || node.type === 'media' || node.type === 'keyframes') {
    const rules = (node.type === 'stylesheet') ? node.stylesheet.rules : (node.type === 'keyframes') ? node.keyframes : node.rules;
    for (const rule of rules) {
      const r = processNode(rule);
      atRules += r.atRules;
      selectors += r.selectors;
      declarations += r.declarations;
    }
  }
  return {
    atRules: atRules,
    selectors: selectors,
    declarations: declarations
  };
}

try {
  return processNode(parsedCss);
} catch (e) {
  throw e;
  return {atRules: 1, selectors: 2, declarations: 3};
}
''';

WITH
basedata AS (
  SELECT
    EXTRACT(YEAR FROM `date`) AS report_year,
    page,
    getSourceLocStats(css) AS source_loc_stats
  FROM
    `httparchive.crawl.parsed_css` --TABLESAMPLE SYSTEM (0.01 PERCENT)
  WHERE `date` IN ('2025-07-01', '2024-07-01', '2023-07-01', '2022-07-01', '2021-07-01', '2020-07-01', '2019-07-01')
),

per_page AS (
  SELECT
    report_year,
    page,
    SUM(source_loc_stats.AtRules) AS at_rules,
    SUM(source_loc_stats.selectors) AS selectors,
    SUM(source_loc_stats.declarations) AS declarations
  FROM basedata
  GROUP BY
    report_year, page
)

SELECT
  report_year,
  AVG(at_rules) AS avg_at_rules,
  AVG(selectors) AS avg_selectors,
  AVG(declarations) AS avg_declarations,
  AVG(at_rules + selectors + declarations) AS avg_lines_of_code,
  MAX(at_rules) AS max_at_rules,
  MAX(selectors) AS max_selectors,
  MAX(declarations) AS max_declarations,
  MAX(at_rules + selectors + declarations) AS max_lines_of_code
FROM
  per_page
GROUP BY
  report_year
ORDER BY
  report_year;
