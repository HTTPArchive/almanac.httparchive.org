# Most common CNAME domains

CREATE TEMP FUNCTION convert_cname_json(json_str STRING)
RETURNS ARRAY<STRUCT<origin STRING, cname STRING>>
LANGUAGE js AS """
  const obj = JSON.parse(json_str);
  const result = [];
  for (const key in obj) {
    result.push({
      origin: key,
      cname: obj[key]
    });
  }
  return result;
""";

# Adguard CNAME Trackers source:
# https://github.com/AdguardTeam/cname-trackers/blob/master/script/src/cloaked-trackers.json
WITH adguard_trackers AS (
  SELECT NET.REG_DOMAIN(domain) AS domain
  FROM UNNEST(['cz.affilbox.cz', 'pl02.prolitteris.2cnt.net', 'a8.net', 'mm.actionlink.jp', 'ebis.ne.jp', '0i0i0i0.com', 'ads.bid', 'at-o.net', 'actonservice.com', 'actonsoftware.com', '2o7.net', 'data.adobedc.net', 'sc.adobedc.net', 'sc.omtrdc.net', 'adocean.pl', 'aquaplatform.com', 'cdn18685953.ahacdn.me', 'thirdparty.bnc.lt', 'api.clickaine.com', 'tagcommander.com', 'track.sp.crdl.io', 'dnsdelegation.io', 'storetail.io', 'e.customeriomail.com', 'dataunlocker.com', 'monopoly-drain.ga', 'friendly-community.tk', 'nc0.co', 'eulerian.net', 'extole.com', 'extole.io', 'fathomdns.com', 'genieespv.jp', 'ad-cloud.jp', 'goatcounter.com', 'heleric.com', 'iocnt.net', 'affex.org', 'k.keyade.com', 'ghochv3eng.trafficmanager.net', 'online-metrix.net', 'logly.co.jp', 'mailgun.org', 'ab1n.net', 'ntv.io', 'ntvpforever.com', 'postrelease.com', 'non.li', 'tracking.bp01.net', 't.eloqua.com', 'oghub.io', 'go.pardot.com', 'parsely.com', 'custom.plausible.io', 'popcashjs.b-cdn.net', 'rdtk.io', 'sailthru.com', 'exacttarget.com', 'a351fec2c318c11ea9b9b0a0ae18fb0b-1529426863.eu-central-1.elb.amazonaws.com', 'a5e652663674a11e997c60ac8a4ec150-1684524385.eu-central-1.elb.amazonaws.com', 'a88045584548111e997c60ac8a4ec150-1610510072.eu-central-1.elb.amazonaws.com', 'afc4d9aa2a91d11e997c60ac8a4ec150-2082092489.eu-central-1.elb.amazonaws.com', 'webtrekk.net', 'wt-eu02.net', 'ak-is2.net', 'wizaly.com']) AS domain
), whotracksme AS (
  SELECT
    domain,
    category
  FROM `httparchive.almanac.whotracksme`
  WHERE date = '2024-06-01'
  GROUP BY
    domain,
    category
), cnames AS (
  SELECT
    client,
    NET.REG_DOMAIN(cnames.cname) AS cname_domain,
    COUNT(DISTINCT NET.REG_DOMAIN(cnames.origin)) AS number_of_request_domains,
    COUNT(DISTINCT page) AS number_of_pages
  --ARRAY_AGG(DISTINCT cnames.origin LIMIT 2) AS request_domain_examples,
  --ARRAY_AGG(DISTINCT page LIMIT 2) AS page_examples,
  FROM `httparchive.all.pages`,
    UNNEST(convert_cname_json(JSON_QUERY(custom_metrics, '$.privacy.request_hostnames_with_cname'))) AS cnames
  WHERE date = '2024-06-01' AND
    is_root_page = TRUE
  GROUP BY
    client,
    cname_domain
  HAVING number_of_request_domains > 100
  LIMIT 500
)

SELECT
  client,
  cnames.cname_domain AS cname,
  adguard_trackers.domain AS adguard_cname,
  whotracksme.category AS whotracksme_category,
  number_of_request_domains,
  number_of_pages
FROM cnames
LEFT JOIN adguard_trackers
ON cnames.cname_domain = adguard_trackers.domain
LEFT JOIN whotracksme
ON cnames.cname_domain = whotracksme.domain
ORDER BY number_of_request_domains DESC
