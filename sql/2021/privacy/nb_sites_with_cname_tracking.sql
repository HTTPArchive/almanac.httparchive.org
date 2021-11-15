SELECT
    COUNT(DISTINCT NET.REG_DOMAIN(DOMAIN)) AS NB_DOMAINS,
    CASE
        WHEN
            (
                TRACKER = "sc.omtrdc.net" OR TRACKER = ".2o7.net"
            ) THEN "Adobe Experience Cloud"
        WHEN TRACKER = "pi.pardot.com" THEN "Pardot"
        WHEN TRACKER = "hs.eloqua.com" THEN "Oracle Eloqua"
        WHEN TRACKER = ".wizaly.com" THEN "Wizaly"
        WHEN TRACKER = "k.keyade.com" THEN "Keyade"
        WHEN TRACKER = "partner.intentmedia.net" THEN "Intent"
        WHEN TRACKER = "dnsdelegation.io" THEN "Criteo"
        WHEN
            (
                TRACKER = "afc4d9aa2a91d11e997c60ac8a4ec150-2082092489.eu-central-1.elb.amazonaws.com" OR TRACKER = "a88045584548111e997c60ac8a4ec150-1610510072.eu-central-1.elb.amazonaws.com"
            ) THEN "Tracedock"
        WHEN TRACKER = ".at-o.net" THEN "AT Internet"
        WHEN TRACKER = ".affex.org" THEN "Ingenious Technologies"
        WHEN (TRACKER = ".wt-eu02.net" OR TRACKER = ".webtrekk.net") THEN "Webtrekk"
        WHEN TRACKER = ".actonsoftware.com" THEN "Act-On Software"
        WHEN TRACKER = ".eulerian.net" THEN "Eulerian"
    END AS COMPANY
FROM `bamboo-chariot-267911.cname_analysis.results_tracking_2021_08_01`, unnest(domains) as domain
GROUP BY COMPANY
ORDER BY NB_DOMAINS DESC
