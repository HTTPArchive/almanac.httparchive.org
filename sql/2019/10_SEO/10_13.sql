#standardSQL

# check if mobile gets redirected to a different url

SELECT
    JSON_EXTRACT_SCALAR(`httparchive.requests.2019_07_01_desktop`.payload, '$.response.redirectURL'),
    JSON_EXTRACT_SCALAR(`httparchive.requests.2019_07_01_mobile`.payload, '$.response.redirectURL'),
    IF(JSON_EXTRACT_SCALAR(`httparchive.requests.2019_07_01_desktop`.payload, '$.response.redirectURL') != JSON_EXTRACT_SCALAR(`httparchive.requests.2019_07_01_mobile`.payload, '$.response.redirectURL'), 2, 1) AS has_device_redirect
FROM
    `httparchive.pages.2019_07_01_desktop`
LEFT JOIN `httparchive.requests.2019_07_01_desktop` USING(url)
LEFT JOIN `httparchive.requests.2019_07_01_mobile` USING(url)
ORDER BY has_device_redirect DESC
