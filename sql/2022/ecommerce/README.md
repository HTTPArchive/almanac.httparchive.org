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

- [ ] Top platforms - top_vendors.sql
- [ ] Top platforms growth - pct_ecommsites_bydevice_compare20202122.sql
- [ ] Top platforms by 1M, 100k, 10k - top_vendors_crux_rank.sql
- [ ] Top Enterprise targetted platforms - top_vendors.sql filtered

## Growth trends - overall
- [ ] eComm growth - ecomm_growth.sql
- [ ] platform growth - ecomm_vendors_growth.sql

## Server Stack
- [ ] CDN Provider - top_cdn_bydevice_vendor_cdn.sql top_cdn_bydevice_vendor_wapp.sql

## Frontend Tech
- [ ] JS Frameworks - top_jslibs_by_device.sql
- [ ] JS Libraries - top_jsframework_providers_by_device.sql

## User Experience
- [ ] CWV - Platform - Passing grade 10k vs 100k vendor - core_web_vitals_passingmetrics_byvendor_bydevice.sql
- [ ] CWV - Top x Platforms - CLS, FCP, LCP, FID, TTFB - core_web_vitals_distribution_byvendor_bydevice.sql
- [ ] Lighthouse - Top x Platforms - 5 scores - median_lighthouse_score_ecommsites.sql

## Page Anatomy
- [ ] Page Reqs and Weight - pagestats_percentiles_bydevice.sql
- [ ] Page Weight - HTML payload - pagestats_html_bydevice.sql
- [ ] Page Reqs and Weight - images - pagestats_image_bydevice.sql 
- [ ] Page Weight - 3rd party domain reqs and weight - pct_3pusage_bydevice.sql

## Tools and Misc
- [ ] Analytics usage - top_analytics_providers_bydevice_wapp.sql
- [ ] Tag Manager usage - percent_of_ecommsites_using_each_tag_managers.sql
- [ ] AMP usage - pct_ampusage_bydevice_vendor.sql
- [ ] Consent Management usage - percent_of_ecommsites_using_cmp.sql
- [ ] CSP usage - review latest security query
- [ ] Web Push usage - webpushstats_ecommsites.sql