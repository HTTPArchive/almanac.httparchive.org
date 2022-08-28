SELECT
  _TABLE_SUFFIX AS client,
  COUNT(0) AS total,
  SUM(IF(JSON_EXTRACT_SCALAR(payload, '$._performance.gaming_metrics.detectUA-ChromeLH') = 'true', 1, 0)) AS chrome_lighthouse,
  SUM(IF(JSON_EXTRACT_SCALAR(payload, '$._performance.gaming_metrics.detectUA-ChromeLH') = 'true', 1, 0)) / COUNT(0) AS chrome_lighthouse_per,
  SUM(IF(JSON_EXTRACT_SCALAR(payload, '$._performance.gaming_metrics.detectUA-GTmetrix') = 'true', 1, 0)) AS gtmetrix,
  SUM(IF(JSON_EXTRACT_SCALAR(payload, '$._performance.gaming_metrics.detectUA-GTmetrix') = 'true', 1, 0)) / COUNT(0) AS gtmetrix_per,
  SUM(IF(JSON_EXTRACT_SCALAR(payload, '$._performance.gaming_metrics.detectUA-PageSpeed') = 'true', 1, 0)) AS pagespeed,
  SUM(IF(JSON_EXTRACT_SCALAR(payload, '$._performance.gaming_metrics.detectUA-PageSpeed') = 'true', 1, 0)) / COUNT(0) AS pagespeed_per,
  SUM(IF(JSON_EXTRACT_SCALAR(payload, '$._performance.gaming_metrics.imgAnimationStrict') = 'true', 1, 0)) AS img_animation_strict,
  SUM(IF(JSON_EXTRACT_SCALAR(payload, '$._performance.gaming_metrics.imgAnimationStrict') = 'true', 1, 0)) / COUNT(0) AS img_animation_strict_per,
  SUM(IF(JSON_EXTRACT_SCALAR(payload, '$._performance.gaming_metrics.imgAnimationSoft') = 'true', 1, 0)) AS img_animation_soft,
  SUM(IF(JSON_EXTRACT_SCALAR(payload, '$._performance.gaming_metrics.imgAnimationSoft') = 'true', 1, 0)) / COUNT(0) AS img_animation_soft_per,
  SUM(IF(JSON_EXTRACT_SCALAR(payload, '$._performance.gaming_metrics.fidIframeOverlayStrict') = 'true', 1, 0)) AS fid_iframe_overlay_strict,
  SUM(IF(JSON_EXTRACT_SCALAR(payload, '$._performance.gaming_metrics.fidIframeOverlayStrict') = 'true', 1, 0)) / COUNT(0) AS fid_iframe_overlay_strict_per,
  SUM(IF(JSON_EXTRACT_SCALAR(payload, '$._performance.gaming_metrics.fidIframeOverlaySoft') = 'true', 1, 0)) AS fid_iframe_overlay_soft,
  SUM(IF(JSON_EXTRACT_SCALAR(payload, '$._performance.gaming_metrics.fidIframeOverlaySoft') = 'true', 1, 0)) / COUNT(0) AS fid_iframe_overlay_soft_per,
  SUM(IF(JSON_EXTRACT_SCALAR(payload, '$._performance.gaming_metrics.lcpOverlayStrict') = 'true', 1, 0)) AS lcp_overlay_strict,
  SUM(IF(JSON_EXTRACT_SCALAR(payload, '$._performance.gaming_metrics.lcpOverlayStrict') = 'true', 1, 0)) / COUNT(0) AS lcp_overlay_strict_per,
  SUM(IF(JSON_EXTRACT_SCALAR(payload, '$._performance.gaming_metrics.lcpOverlaySoft') = 'true', 1, 0)) AS lcp_overlay_soft,
  SUM(IF(JSON_EXTRACT_SCALAR(payload, '$._performance.gaming_metrics.lcpOverlaySoft') = 'true', 1, 0)) / COUNT(0) AS lcp_overlay_soft_per
FROM
  `httparchive.pages.2022_06_01_*`
GROUP BY
  client
