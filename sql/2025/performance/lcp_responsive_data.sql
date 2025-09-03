CREATE TEMP FUNCTION checkResponsiveImages(responsivelist STRING, lcpImgUrl STRING, nodePath STRING) RETURNS BOOLEAN LANGUAGE js AS '''
  try {
    //we will check lcp elment is img
    const lastSegment = (nodePath.split(",").reverse())[0];
    let lastNodeImg = false
    if(lastSegment == 'IMG'){
      lastNodeImg = true
    }
    if(lcpImgUrl != null && lastNodeImg){
      const listJson = JSON.parse(responsivelist);
      if(listJson.length > 0){
        for(let i=0;i<listJson.length;i++){
          let currentUrl = listJson[i].url;
          if(currentUrl == lcpImgUrl){
            return true
          }
        }
      }
    }
    return false;
  } catch (e) {
    return false
  }
''';


WITH lh AS (
  SELECT
    client,
    page,
    JSON_VALUE(lighthouse.audits.`prioritize-lcp-image`.details.items[0].url) AS url,
    JSON_VALUE(lighthouse.audits.`largest-contentful-paint-element`.details.items[0].items[0].node.path) AS node_path,
    TO_JSON_STRING(lighthouse.audits.`uses-responsive-images`.details.items) AS responsive_images
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page
),

responsive_lcp AS (
  SELECT
    client,
    page,
    ENDS_WITH(node_path, 'IMG') AS is_img_lcp,
    checkResponsiveImages(responsive_images, url, node_path) AS is_responsive_lcp
  FROM
    lh
)

SELECT
  client,
  COUNTIF(is_responsive_lcp) AS is_responsive_lcp,
  COUNTIF(is_img_lcp) AS pages_with_img_lcp,
  COUNTIF(is_responsive_lcp) / COUNTIF(is_img_lcp) AS pct_responsive_lcp
FROM
  responsive_lcp
GROUP BY
  client
