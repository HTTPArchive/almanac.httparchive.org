# 2022 Jamstack queries

<!--
  This directory contains all of the 2022 Jamstack chapter queries.

  Each query should have a corresponding `metric_name.sql` file.
  Note that readers are linked to this directory, so try to make the SQL file names descriptive for easy browsing.

  Analysts: if helpful, you can use this README to give additional info about the queries.
-->

1. Jamstack sites are fast

- [ ] Lighthouse Performance score]
  * Have [distribution of Lighthouse performance scores](lighthouse_distribution.sql); median score is 0.31
- [ ] Largest Contentful Paint
  * Have [distribution of LCP times](distribution_lcp.sql); median is 6.6 seconds

2. Jamstack sites are resilient (and pre-rendered)

- [ ] Rendered content sizes (reuse SEO chapter query https://github.com/HTTPArchive/custom-metrics/blob/main/dist/wpt_bodies.js)
- [ ] How much the content changes post-load, i.e. Cumulative Layout Shift
  * Have [distribution of CLS scores](distribution_cls.sql); median is 0.059

3. Jamstack sites are cached for a long time

- [ ] Age header
  * Have [distribution of Age headers](distribution_age_headers.sql); median is 1 day

4. The Jamstack category is growing

- [ ] Percentage of "new" sites in crawl that meet the defined criteria of "fast", "resilient" and "cached"

5. Candidate sites
  * Have a [join between all URLs better than median on all 4 current queries](candidate_urls.sql); this matches 10k sites.

## Resources

- [📄 Planning doc][~google-doc]
- [📊 Results sheet][~google-sheets]
- [📝 Markdown file][~chapter-markdown]

[~google-doc]: https://docs.google.com/document/d/15RLaaTVqoqb5AuDrlBt6L0J_BMx1ltKW4t8VWX-sN_g/edit?usp=sharing
[~google-sheets]: https://docs.google.com/spreadsheets/d/1yfNaj25ToezMwQLKdYP6Qh7AUoX9zMdKMSRVC8JlZMY/edit?usp=sharing
[~chapter-markdown]: https://github.com/HTTPArchive/almanac.httparchive.org/tree/main/src/content/en/2022/jamstack.md
