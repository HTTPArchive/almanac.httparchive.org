#standardSQL
# Check for Lighthouse PWA info - based on 2019/14_02.sql
SELECT
  COUNT(0) AS total,
  COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.load-fast-enough-for-pwa.score') = '1') AS load_fast_enough_for_pwa,
  COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.works-offline.score') = '1') AS works_offline,
  COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.offline-start-url.score') = '1') AS offline_start_url,
  COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.is-on-https.score') = '1') AS is_on_https,
  COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.service-worker.score') = '1') AS service_worker,
  COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.installable-manifest.score') = '1') AS installable_manifest,
  COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.redirects-http.score') = '1') AS redirects_http,
  COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.splash-screen.score') = '1') AS splash_screen,
  COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.themed-omnibox.score') = '1') AS themed_omnibox,
  COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.content-width.score') = '1') AS content_width,
  COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.viewport.score') = '1') AS viewport,
  COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.without-javascript.score') = '1') AS without_javascript,
  COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.apple-touch-icon.score') = '1') AS apple_touch_icon,
  COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.maskable-icon.score') = '1') AS maskable_icon,
  COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.pwa-cross-browser.score') = '1') AS pwa_cross_browser,
  COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.pwa-page-transitions.score') = '1') AS pwa_page_transitions,
  COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.pwa-each-page-has-url.score') = '1') AS pwa_each_page_has_url
FROM
  `httparchive.lighthouse.2020_08_01_mobile`
