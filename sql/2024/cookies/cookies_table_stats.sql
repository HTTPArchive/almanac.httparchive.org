-- Stats about the cookie table

SELECT
    client,
    COUNT(*) as total_cookies,
    COUNT(DISTINCT first_party_host) as distinct_websites,
    COUNT(DISTINCT CONCAT(name, domain)) as distinct_cookies_name_domain,
    COUNT(DISTINCT name) as distinct_cookies,
    COUNT(DISTINCT domain) as distinct_domains_setting_them,
    COUNT(DISTINCT NET.REG_DOMAIN(domain)) as distinct_registrable_domains_setting_them,
    SUM(IF(is_first_party = TRUE, 1, 0)) as nb_first_party,
    SUM(IF(is_first_party = FALSE, 1, 0)) as nb_third_party,
    SUM(IF(expires = '-1', 1, 0)) as negative_expires,
    SUM(IF(httpOnly = 'true', 1, 0)) as http_only_true,
    SUM(IF(httpOnly = 'false', 1, 0)) as http_only_false,
    SUM(IF(secure = 'true', 1, 0)) as secure_true,
    SUM(IF(secure = 'false', 1, 0)) as secure_false,
    SUM(IF(session = 'true', 1, 0)) as session_true,
    SUM(IF(session = 'false', 1, 0)) as session_false,
    SUM(IF(sameSite = 'Lax', 1, 0)) as same_site_lax,
    SUM(IF(sameSite = 'None', 1, 0)) as same_site_none,
    SUM(IF(sameSite = 'Strict', 1, 0)) as same_site_strict,
    SUM(IF(sameSite IS NULL, 1, 0)) as same_site_null,
    SUM(IF(sameParty = 'true', 1, 0)) as same_party_true,
    SUM(IF(sameParty = 'false', 1, 0)) as same_party_false,
    SUM(IF(partitionKey IS NOT NULL, 1, 0)) as partition_key_not_null,
    SUM(IF(partitionKey IS NULL, 1, 0)) as partition_key_null,
    SUM(IF(partitionKeyOpaque IS NOT NULL, 1, 0)) as partition_key_opaque_not_null,
    SUM(IF(partitionKeyOpaque IS NULL, 1, 0)) as partition_key_opaque_null,
FROM `httparchive.almanac.2024-06-01_top10k_cookies`
GROUP BY client

