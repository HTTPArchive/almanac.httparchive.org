SELECT
  COUNT(DISTINCT NET.REG_DOMAIN(domain)) AS nb_domains,
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
  END AS company
FROM
  `bamboo-chariot-267911.cname_analysis.results_tracking_2021_08_01`,
  UNNEST(domains) AS domain
GROUP BY
  company
ORDER BY
  nb_domains DESC
