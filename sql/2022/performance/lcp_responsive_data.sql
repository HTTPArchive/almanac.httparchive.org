CREATE TEMP FUNCTION checkResponsiveImages(responsivelist STRING, lcpImgUrl STRING, nodePath STRING) RETURNS BOOLEAN LANGUAGE js AS '''
  try {
    //we will check lcp elment is img
    const lastSegment = (JSON.parse(nodePath).split(",").reverse())[0];
    let lastNodeImg = false
    if(lastSegment == 'IMG'){
      lastNodeImg = true
    }
    if(lcpImgUrl != null && lastNodeImg){
      const listJson = JSON.parse(responsivelist);
      if(listJson.length > 0){
        for(let i=0;i<listJson.length;i++){
          let currentUrl = listJson[i].url;
          if(currentUrl == JSON.parse(lcpImgUrl)){
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

SELECT
  _TABLE_SUFFIX AS client,
  COUNT(0) AS total,
  SUM(IF(checkResponsiveImages(JSON_EXTRACT(report, '$.audits.uses-responsive-images.details.items'), JSON_EXTRACT(report, '$.audits.preload-lcp-image.details.items[0].url'), JSON_EXTRACT(report, '$.audits.largest-contentful-paint-element.details.items[0].node.path')) = true, 1, 0 )) AS check_responsive_images,
  SUM(IF(checkResponsiveImages(JSON_EXTRACT(report, '$.audits.uses-responsive-images.details.items'), JSON_EXTRACT(report, '$.audits.preload-lcp-image.details.items[0].url'), JSON_EXTRACT(report, '$.audits.largest-contentful-paint-element.details.items[0].node.path')) = true, 1, 0 )) / COUNT(0) AS lcp_responsive_images_per

FROM `httparchive.lighthouse.2022_06_01_*`
GROUP BY
  client
