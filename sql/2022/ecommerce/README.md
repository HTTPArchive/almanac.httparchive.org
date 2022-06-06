# 2022 Ecommerce queries

<!--
  This directory contains all of the 2022 Ecommerce chapter queries.

  Each query should have a corresponding `metric_name.sql` file.
  Note that readers are linked to this directory, so try to make the SQL file names descriptive for easy browsing.

  Analysts: if helpful, you can use this README to give additional info about the queries.
-->

## Resources

- [📄 Planning doc][~google-doc]
- [📊 Results sheet][~google-sheets]
- [📝 Markdown file][~chapter-markdown]

[~google-doc]: https://docs.google.com/document/d/1IsdOo8Tgjo4aLDdYZaTGc42BNnJIZMziqPBgNzqCYYg/edit?usp=sharing
[~google-sheets]: https://docs.google.com/spreadsheets/d/1UXCD_A748UF79McCg1cdLdCKPKE8JNFAdd1l-t-glrI/edit?usp=sharing
[~chapter-markdown]: https://github.com/HTTPArchive/almanac.httparchive.org/tree/main/src/content/en/2022/ecommerce.md

# 2021 Queries for re-use (early list)

* Ecommerce comparison 2021 to 2022. - pct_ecommsites_bydevice_compare20212022.sql
* Top ecommerce platforms. - top_vendors.sql, top_vendors_crux_rank.sql
* Enterprise ecommerce platforms (desktop) - top_vendors.sql
* Enterprise ecommerce platforms - 2020 desktop
* Enterprise ecommerce platforms - 2021 desktop
* Ecommerce platform growth Covid-19 impact - ecomm_vendors_covid_growth.sql
* Page requests distribution. - pagestats_percentiles_bydevice.sql
* Page weight distribution. - pagestats_percentiles_bydevice.sql
* Median page requests by type. - pagestats_percentile_bydevice_format.sql
* Median page kilobytes by type. - pagestats_percentile_bydevice_format.sql
* Distribution of HTML bytes per ecommerce page - pagestats_html_bydevice.sql
* Distribution of image requests for ecommerce - pagestats_image_bydevice.sql
* Distribution of image bytes for ecommerce - pagestats_percentiles_bydevice.sql
* Popular image formats on ecommerce sites - pagestats_image_bydevice_format.sql
* Distribution of third-party requests - pct_3pusage_bydevice.sql
* Distribution of third-party bytes - pct_3pusage_bydevice.sql
* Real-user Largest Contentful Paint experiences - core_web_vitals_distribution_byvendor_bydevice.sql
* Real-user First Input Delay experiences - core_web_vitals_distribution_byvendor_bydevice.sql
* Real-user Cumulative Layout Shift experiences - core_web_vitals_distribution_byvendor_bydevice.sql
* Real-user Core Web Vitals experiences - core_web_vitals_passingmetrics_byvendor_bydevice.sql
* Top analytics solutions on ecommerce sites - top_analytics_providers_bydevice_wapp.sql
* Tag manager usage on ecommerce sites. - percent_of_ecommsites_using_each_tag_managers.sql
* Consent Management Platform adoption - percent_of_ecommsites_using_cmp.sql
* AMP usage on ecommerce sites (mobile). - pct_ampusage_bydevice_vendor.sql
* Web Push Notification acceptance rates - webpushstats_ecommsites.sql
* Top "JavaScript frameworks" - top_jsframework_providers_by_device.sql
* Top "JavaScript libraries" category - top_jslibs_by_device.sql
* Top CMS technology category - top_cms_by_device.sql
* Top "Page Builders” technology category - top_pagebuilders_bydevice.sql
* Top “A/B testing” technology category. - top_abtesting_bydevice.sql
* Top “Personalisation” technology category - top_personalisation_bydevice.sql
* Top “Loyalty & Rewards” technology category - top_loyaltyandrewards_bydevice.sql
* Median lighthouse scores for ecommerce - median_lighthouse_score_ecommsites.sql
* Ecommerce sites using hreflang value through headers - percent_of_ecommsites_using_hreflang_value_headers.sql
* Ecommerce sites using hreflang value through link rel - percent_of_ecommsites_using_hreflang_value_link.sql
* Presence of `Content-Security-Policy` and `Content-Security-Policy-Report-Only` on `Ecommerce` sites - percent_of_ecommsites_csp.sql
* App links association - android_ios_app_links_ecomm_sites.sql
* Ecomm covid growth: 2021-2022 - ecomm_covid_growth.sql
* A11y usage on Ecomm sites - percent_of_ecommsites_using_a11y_solutions.sql
* Webpush adoption stats - webpush_adoption_by_ecommsites.sql

# Interested in bringing these queries back
* top_cdn_bydevice.sql
* top_cdn_bydevice_vendor_cdn.sql
* top_cdn_bydevice_vendor_wapp.sql
