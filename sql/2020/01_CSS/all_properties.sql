#standardSQL
CREATE TEMPORARY FUNCTION getProperties(css STRING) RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
	function compute(ast) {
		let ret = {};

		walkDeclarations(ast, ({property, value}) => {
			if (!property.startsWith("--")) { // Custom props are case sensitive
				property = property.toLowerCase();
			}
			
			incrementByKey(ret, property);
		});

		return sortObject(ret);
	}

	let ast = JSON.parse(css);
	let props = compute(ast);
	return Object.entries(props).flatMap(([prop, freq]) => {
		return Array(freq).fill(prop);
	});
}
catch (e) {
	return [];
}
'''
OPTIONS (library="gs://httparchive/lib/css-utils.js");

SELECT
  *
FROM (
  SELECT
    client,
    prop,
    COUNT(DISTINCT page) AS pages,
    COUNT(0) AS freq,
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getProperties(css)) AS prop
  WHERE
    date = '2020-08-01'
  GROUP BY
    client,
    prop)
WHERE
  pages >= 1000
ORDER BY
  pct DESC
