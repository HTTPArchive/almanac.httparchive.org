WITH websites_using_cname_tracking AS (
  SELECT DISTINCT
    NET.REG_DOMAIN(domain) AS domain,
    tracker,
    CASE
      WHEN (tracker = "sc.omtrdc.net" OR tracker = ".2o7.net") THEN "Adobe Experience Cloud"
      WHEN tracker = "pi.pardot.com" THEN "Pardot"
      WHEN tracker = "hs.eloqua.com" THEN "Oracle Eloqua"
      WHEN tracker = ".wizaly.com" THEN "Wizaly"
      WHEN tracker = "k.keyade.com" THEN "Keyade"
      WHEN tracker = "partner.intentmedia.net" THEN "Intent"
      WHEN tracker = "dnsdelegation.io" THEN "Criteo"
      WHEN (tracker = "afc4d9aa2a91d11e997c60ac8a4ec150-2082092489.eu-central-1.elb.amazonaws.com" OR tracker = "a88045584548111e997c60ac8a4ec150-1610510072.eu-central-1.elb.amazonaws.com") THEN "Tracedock"
      WHEN tracker = ".at-o.net" THEN "AT Internet"
      WHEN tracker = ".affex.org" THEN "Ingenious Technologies"
      WHEN (tracker = ".wt-eu02.net" OR tracker = ".webtrekk.net") THEN "Webtrekk"
      WHEN tracker = ".actonsoftware.com" THEN "Act-On Software"
      WHEN tracker = ".eulerian.net" THEN "Eulerian"
      ELSE tracker
    END AS company
  FROM
    `httparchive.almanac.cname_tracking`,
    UNNEST(SPLIT(SUBSTRING(domains, 2, LENGTH(domains) - 2))) AS domain
),

totals AS (
  SELECT
    _TABLE_SUFFIX AS _TABLE_SUFFIX,
    count(0) AS total_pages
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  GROUP BY
    _TABLE_SUFFIX
)

SELECT
  _TABLE_SUFFIX AS client,
  company,
  COUNT(DISTINCT NET.REG_DOMAIN(domain)) AS nb_domains,
  count(0) AS num_cname_pages,
  total_pages,
  count(0) / total_pages AS pct_pages
FROM
  `httparchive.summary_pages.2021_07_01_*`
JOIN
  totals
USING (_TABLE_SUFFIX)
JOIN
  websites_using_cname_tracking
ON domain = NET.REG_DOMAIN(urlShort)
GROUP BY
  client,
  company,
  total_pages
ORDER BY
  pct_pages DESC,
  client
