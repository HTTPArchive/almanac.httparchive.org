#standardSQL

# custom mobile site (e.g. is mobile diffent response compared to desktop?)
# check if we get a redirect, and if so to where

SELECT
    COUNT(`httparchive.pages.2019_07_01_desktop`.url) AS `total`,
    COUNT(DISTINCT `httparchive.pages.2019_07_01_desktop`.url) AS `distinct_total`,
    COUNTIF(JSON_EXTRACT_SCALAR(`httparchive.requests.2019_07_01_desktop`.payload, '$.response.redirectURL') != JSON_EXTRACT_SCALAR(`httparchive.requests.2019_07_01_mobile`.payload, '$.response.redirectURL')) as `responseRedirectDifferent`
FROM
    `httparchive.pages.2019_07_01_desktop`
LEFT JOIN
    `httparchive.requests.2019_07_01_desktop`
        ON `httparchive.pages.2019_07_01_desktop`.url = `httparchive.requests.2019_07_01_desktop`.url
LEFT JOIN
    `httparchive.requests.2019_07_01_mobile`
        ON `httparchive.pages.2019_07_01_desktop`.url = `httparchive.requests.2019_07_01_mobile`.url

GROUP BY
    `httparchive.requests.2019_07_01_desktop`.url

# debug


SELECT
    `httparchive.almanac.requests_mobile_1k`.url as mobile,
    `httparchive.almanac.pages_desktop_1k`.url as desktop,
    IF(JSON_EXTRACT_SCALAR(`httparchive.almanac.requests_desktop_1k`.payload, '$.response.redirectURL') != JSON_EXTRACT_SCALAR(`httparchive.almanac.requests_mobile_1k`.payload, '$.response.redirectURL'), 1, 0) as `responseRedirectDifferent`,
    JSON_EXTRACT_SCALAR(`httparchive.almanac.requests_desktop_1k`.payload, '$.response.redirectURL') as redirect_desktop,
    JSON_EXTRACT_SCALAR(`httparchive.almanac.requests_mobile_1k`.payload, '$.response.redirectURL')as redirect_mobile

FROM
    `httparchive.almanac.pages_desktop_1k`
LEFT JOIN
    `httparchive.almanac.requests_desktop_1k`
        ON `httparchive.almanac.pages_desktop_1k`.url = `httparchive.almanac.requests_desktop_1k`.url
LEFT JOIN
    `httparchive.almanac.requests_mobile_1k`
        ON `httparchive.almanac.pages_desktop_1k`.url = `httparchive.almanac.requests_mobile_1k`.url

LIMIT 100
