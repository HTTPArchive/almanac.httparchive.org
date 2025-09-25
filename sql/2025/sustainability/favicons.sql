#standardSQL
# Temporary function to extract favicon image extensions from the JSON payload
CREATE TEMPORARY FUNCTION GETFAVICONIMAGE(payload STRING)
RETURNS STRING LANGUAGE js AS '''
var result = 'NO_DATA';
try {
    var parsed = JSON.parse(payload);
    
    // If wrapped, unwrap _almanac
    if (parsed && typeof parsed === 'object' && parsed._almanac && typeof parsed._almanac === 'object') {
      parsed = parsed._almanac;
    }

    // Deep search for any array of link-like nodes anywhere in the object
    function findLinkNodes(obj) {
      if (!obj) return [];
      var stack = [obj];
      while (stack.length) {
        var current = stack.pop();
        if (!current) continue;
        if (Array.isArray(current)) {
          // If array of objects with rel/href, treat as nodes
          if (
            current.length && typeof current[0] === 'object' && current.some(function(it){return it && (it.href || it.rel);})
          ) {
            return current;
          }
          for (var i = 0; i < current.length; i++) stack.push(current[i]);
        } else if (typeof current === 'object') {
          // Common patterns: {nodes: [...]} wrappers
          if (current.nodes && Array.isArray(current.nodes)) {
            var n = current.nodes;
            if (n.length && typeof n[0] === 'object' && n.some(function(it){return it && (it.href || it.rel);})){return n;}
          }
          for (var k in current) if (Object.prototype.hasOwnProperty.call(current, k)) stack.push(current[k]);
        }
      }
      return [];
    }

    var nodes = findLinkNodes(parsed);
    if (!nodes || !nodes.length) return result;

    if (nodes && nodes.find) {
      var faviconNode = nodes.find(function(n) {
        if (!n || !('rel' in n)) return false;
        var rels = Array.isArray(n.rel) ? n.rel : String(n.rel).split(' ');
        for (var j = 0; j < rels.length; j++) {
          var r = String(rels[j]).trim().toLowerCase();
          if (r === 'icon' || r === 'shortcut icon' || r === 'apple-touch-icon' || r === 'apple-touch-icon-precomposed') {
            return true;
          }
        }
        return false;
      });

      if (faviconNode) {
        if (faviconNode.href) {
          var temp = String(faviconNode.href);

          if (temp.includes('?')) {
            temp = temp.substring(0, temp.indexOf('?'));
          }

          if (temp.includes('.')) {
            temp = temp.substring(temp.lastIndexOf('.')+1);

            result = temp.toLowerCase().trim();
          }
          else {
            result = "NO_EXTENSION";
          }

        } else {
          result = "NO_HREF";
        }
      } else {
        result = "NO_ICON";
      }
    }
    else {
      result = "NO_DATA";
    }

} catch (e) {}
return result;
''';

# Main query to analyze favicon image extensions using requests heuristics
WITH pages AS (
  SELECT
    client,
    page
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-06-01' AND
    is_root_page
),

reqs AS (
  SELECT
    client,
    page,
    url,
    response_headers
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-06-01' AND
    is_root_page
),

candidates AS (
  SELECT
    r.client,
    r.page,
    r.url,
    LOWER(
      REGEXP_EXTRACT(
        REGEXP_REPLACE(SPLIT(r.url, '?')[SAFE_OFFSET(0)], r'/+$', ''),
        r'\.([A-Za-z0-9]+)$'
      )
    ) AS url_ext,
    (
      SELECT LOWER(value)
      FROM UNNEST(r.response_headers)
      WHERE LOWER(name) = 'content-type'
      LIMIT 1
    ) AS content_type
  FROM
    reqs r
  JOIN
    pages p
  USING (client, page)
  WHERE
    REGEXP_CONTAINS(LOWER(r.url), r'favicon|apple-touch-icon|android-chrome|mstile|safari-pinned-tab')
),

resolved AS (
  SELECT
    client,
    page,
    url,
    COALESCE(
      NULLIF(url_ext, ''),
      CASE
        WHEN content_type LIKE 'image/svg%' THEN 'svg'
        WHEN content_type LIKE 'image/png%' THEN 'png'
        WHEN content_type LIKE 'image/webp%' THEN 'webp'
        WHEN content_type LIKE 'image/jpeg%' OR content_type LIKE 'image/jpg%' THEN 'jpg'
        WHEN content_type LIKE 'image/x-icon%' OR content_type LIKE 'image/vnd.microsoft.icon%' THEN 'ico'
        ELSE 'unknown'
      END
    ) AS image_type_extension
  FROM
    candidates
),

rollup_data AS (
  SELECT
    client,
    image_type_extension,
    COUNT(DISTINCT page) AS pages
  FROM
    resolved
  GROUP BY
    client,
    image_type_extension
)

SELECT
  client,
  image_type_extension,
  pages AS count,
  SUM(pages) OVER (PARTITION BY client) AS total,
  ROUND(100 * SAFE_DIVIDE(pages, SUM(pages) OVER (PARTITION BY client)), 2) AS pct
FROM
  rollup_data
ORDER BY
  client ASC,
  count DESC,
  image_type_extension ASC
