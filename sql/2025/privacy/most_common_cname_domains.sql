# Most common CNAME domains
CREATE TEMP FUNCTION CONVERT_CNAME_JSON(obj JSON)
RETURNS ARRAY<STRUCT<origin STRING, cname STRING>>
LANGUAGE js AS """
try {
  const result = [];
  for (const key in obj) {
    result.push({
      origin: key,
      cname: obj[key]
    });
  }
  return result;
} catch (e) {
  return [];
}
""";

# Adguard CNAME Trackers source:
# https://github.com/AdguardTeam/cname-trackers/blob/master/script/src/cloaked-trackers.json
WITH adguard_trackers AS (
  SELECT
    domain
  FROM UNNEST(['cz.affilbox.cz', 'pl02.prolitteris.2cnt.net', 'a8.net', 'mm.actionlink.jp', 'mr-in.com', 'ebis.ne.jp', '0i0i0i0.com', 'ads.bid', 'at-o.net', 'actonservice.com', 'actonsoftware.com', '2o7.net', 'data.adobedc.net', 'sc.adobedc.net', 'sc.omtrdc.net', 'adocean.pl', 'aquaplatform.com', 'cdn18685953.ahacdn.me', 'thirdparty.bnc.lt', 'api.clickaine.com', 'tagcommander.com', 'track.sp.crdl.io', 'dnsdelegation.io', 'storetail.io', 'e.customeriomail.com', 'dataunlocker.com', 'monopoly-drain.ga', 'friendly-community.tk', 'nc0.co', 'customer.etracker.com', 'eulerian.net', 'extole.com', 'extole.io', 'fathomdns.com', 'genieespv.jp', 'ad-cloud.jp', 'goatcounter.com', 'heleric.com', 'iocnt.net', 'affex.org', 'k.keyade.com', 'ghochv3eng.trafficmanager.net', 'online-metrix.net', 'logly.co.jp', 'mailgun.org', 'ab1n.net', 'ntv.io', 'ntvpforever.com', 'postrelease.com', 'non.li', 'tracking.bp01.net', 't.eloqua.com', 'oghub.io', 'go.pardot.com', 'parsely.com', 'custom.plausible.io', 'popcashjs.b-cdn.net', 'rdtk.io', 'sailthru.com', 'exacttarget.com', 'a351fec2c318c11ea9b9b0a0ae18fb0b-1529426863.eu-central-1.elb.amazonaws.com', 'a5e652663674a11e997c60ac8a4ec150-1684524385.eu-central-1.elb.amazonaws.com', 'a88045584548111e997c60ac8a4ec150-1610510072.eu-central-1.elb.amazonaws.com', 'afc4d9aa2a91d11e997c60ac8a4ec150-2082092489.eu-central-1.elb.amazonaws.com', 'e.truedata.co', 'utiq-aws.net', 'webtrekk.net', 'wt-eu02.net', 'ak-is2.net', 'wizaly.com']) AS domain
),

whotracksme AS (
  SELECT DISTINCT
    domain,
    category
  FROM `httparchive.almanac.whotracksme`
  WHERE date = '2025-07-01'
),

cnames AS (
  SELECT
    client,
    cnames.cname,
    page,
    ARRAY_AGG(DISTINCT page LIMIT 2) AS page_examples
  FROM `httparchive.crawl.pages`,
    UNNEST(CONVERT_CNAME_JSON(custom_metrics.privacy.request_hostnames_with_cname)) AS cnames
  WHERE date = '2025-07-01' AND
    NET.REG_DOMAIN(cnames.origin) = NET.REG_DOMAIN(page) AND
    NET.REG_DOMAIN(cnames.cname) != NET.REG_DOMAIN(page)
  GROUP BY
    client,
    cnames.cname,
    page
),

pages_total AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total_pages
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01'
  GROUP BY client
),

cname_stats AS (
  SELECT
    client,
    NET.REG_DOMAIN(cname) AS cname,
    adguard_trackers.domain IS NOT NULL AS adguard_known_cname,
    whotracksme.category AS whotracksme_category,
    COUNT(DISTINCT page) AS number_of_pages,
    ANY_VALUE(page_examples)
  FROM cnames
  LEFT JOIN adguard_trackers
  ON ENDS_WITH(cnames.cname, adguard_trackers.domain)
  LEFT JOIN whotracksme
  ON ENDS_WITH(cnames.cname, whotracksme.domain)
  GROUP BY
    client,
    cname,
    adguard_known_cname,
    whotracksme_category
)

SELECT
  client,
  cname,
  adguard_known_cname,
  whotracksme_category,
  number_of_pages,
  number_of_pages / total_pages AS pct_pages
FROM cname_stats
LEFT JOIN pages_total
USING (client)
ORDER BY number_of_pages DESC
