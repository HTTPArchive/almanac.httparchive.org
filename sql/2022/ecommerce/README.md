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

## eComm Platforms

- [X] Top platforms - top_vendors.sql
- [X] Top platforms growth - pct_ecommsites_bydevice_compare20202122.sql
- [X] Top platforms by 1M, 100k, 10k - top_vendors_crux_rank.sql
- [X] Top Enterprise targetted platforms - top_vendors.sql filtered

## Growth trends - overall
- [X] eComm growth - ecomm_growth.sql
- [X] platform growth - ecomm_vendors_growth.sql

## Server Stack
- [X] CDN Provider - top_cdn_bydevice_vendor_cdn.sql top_cdn_bydevice_vendor_wapp.sql

## Frontend Tech
- [X] JS Frameworks - wCart_review - top_jslibs_by_device.sql
- [X] JS Libraries - wCart_review - top_jsframework_providers_by_device.sql

## User Experience
- [X] CWV - Platform - Passing grade 10k vs 100k vendor - core_web_vitals_passingmetrics_byvendor_bydevice.sql
- [X] CWV - Top x Platforms - CLS, FCP, LCP, FID, TTFB - core_web_vitals_distribution_byvendor_bydevice.sql
- [X] Lighthouse - Top x Platforms - 5 scores - median_lighthouse_score_ecommsites.sql

## Page Anatomy
- [X] Page Reqs and Weight - pagestats_percentiles_bydevice.sql
- [X] Page Weight - HTML payload - pagestats_html_bydevice.sql
- [X] Page Reqs and Weight - images - pagestats_image_bydevice.sql
- [X] Page Weight - 3rd party domain reqs and weight - pct_3pusage_bydevice.sql

## Tools and Misc
- [X] Analytics usage - wGAEnhanced_review - top_analytics_providers_bydevice_wapp.sql
- [X] Tag Manager usage - percent_of_ecommsites_using_each_tag_managers.sql
- [X] AMP usage - pct_ampusage_bydevice_vendor.sql
- [X] Consent Management usage - percent_of_ecommsites_using_cmp.sql
- [X] CSP usage - review latest security query
- [X] Web Push usage - webpushstats_ecommsites.sql
