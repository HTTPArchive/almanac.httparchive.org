#standardSQL
# 21_04: Popular resource types to preload/prefetch.
CREATE TEMPORARY FUNCTION getResourceHintTypes(payload STRING)
RETURNS ARRAY<STRUCT<name STRING, href STRING>>
LANGUAGE js AS '''
var hints = new Set(['preload', 'prefetch']);
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac['link-nodes'].nodes.reduce((results, link) => {
    var hint = link.rel.toLowerCase();
    if (!hints.has(hint)) {
      return results;
    }

    results.push({
      name: hint,
      href: link.href
    });

    return results;
  }, []);
} catch (e) {
  return [];
}
''';

CREATE TEMPORARY FUNCTION pathResolve(path1 STRING, path2 STRING)
RETURNS STRING LANGUAGE js AS '''
  if (!path2) return null;
  function normalizeStringPosix(e,t){for(var n="",r=-1,i=0,l=void 0,o=!1,h=0;h<=e.length;++h){if(h<e.length)l=e.charCodeAt(h);else{if(l===SLASH)break;l=SLASH}if(l===SLASH){if(r===h-1||1===i);else if(r!==h-1&&2===i){if(n.length<2||!o||n.charCodeAt(n.length-1)!==DOT||n.charCodeAt(n.length-2)!==DOT)if(n.length>2){for(var g=n.length-1,a=g;a>=0&&n.charCodeAt(a)!==SLASH;--a);if(a!==g){n=-1===a?"":n.slice(0,a),r=h,i=0,o=!1;continue}}else if(2===n.length||1===n.length){n="",r=h,i=0,o=!1;continue}t&&(n.length>0?n+="/..":n="..",o=!0)}else{var f=e.slice(r+1,h);n.length>0?n+="/"+f:n=f,o=!1}r=h,i=0}else l===DOT&&-1!==i?++i:i=-1}return n}function resolvePath(){for(var e=[],t=0;t<arguments.length;t++)e[t]=arguments[t];for(var n="",r=!1,i=void 0,l=e.length-1;l>=-1&&!r;l--){var o=void 0;l>=0?o=e[l]:(void 0===i&&(i=getCWD()),o=i),0!==o.length&&(n=o+"/"+n,r=o.charCodeAt(0)===SLASH)}return n=normalizeStringPosix(n,!r),r?"/"+n:n.length>0?n:"."}var SLASH=47,DOT=46,getCWD=function(){return""};if(/^https?:/.test(path2)){return path2;}if(/^\\//.test(path2)){return path1+path2.substr(1);}return resolvePath(path1, path2).replace(/^(https?:\\/)/, '$1/');
''';

SELECT
  client,
  name,
  type,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client, name) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, name) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    hint.name,
    pathResolve(url, hint.href) AS url
  FROM
    `httparchive.pages.2020_08_01_*`,
    UNNEST(getResourceHintTypes(payload)) AS hint)
LEFT JOIN (
  SELECT
    client,
    page,
    url,
    type
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01')
USING
  (client, page, url)
GROUP BY
  client,
  name,
  type
ORDER BY
  pct DESC
