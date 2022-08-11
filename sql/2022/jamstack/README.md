# 2022 Jamstack queries

Jamstack is a hard category to define, since the definition is architectural -- a decoupled back end and front end -- which is not a distinction visible to a crawler. So we have gone with a number of proxy metrics, in combination. See [draft](https://docs.google.com/document/d/15RLaaTVqoqb5AuDrlBt6L0J_BMx1ltKW4t8VWX-sN_g/edit#heading=h.8z91yaf1dmft) for more detail on methodology.

1. Jamstack sites are fast

- <strike>Lighthouse Performance score</strike>
  * We found [distribution of Lighthouse performance scores](lighthouse_distribution_mobile.sql) in 2022
    * Mobile median score was 0.3
    * Better means: anything with this or larger
  * Lighthouse performance scores were not reliably available in earlier years
    * And omitting the score in the 2022 data did not make a big difference to the resulting set of URLs (since they were performant on 3 other measures already) so we omitted this.
- Largest Contentful Paint using user timings
  * Distribution of LCP times on [mobile](distribution_lcp_mobile.sql) and [desktop](distribution_lcp_desktop.sql)
    * Mobile median is 5.5 seconds
    * Desktop median is 3.7 seconds
  * Better means: anything with this or lower

2. Jamstack sites are resilient (and pre-rendered)

- [ ] How much the content changes post-load, i.e. Cumulative Layout Shift
  * Have [distribution of CLS scores](distribution_cls.sql)
    * Mobile median is 0.058
    * Desktop median is 0.023
  * Better means: anything with this or lower

3. Jamstack sites are cached for a long time

- [ ] Age header
  * Have [distribution of Age headers](distribution_age_headers.sql)
    * Mobile median is 19 hours
    * Desktop median is 21 hours
  * Better means: anything with this or longer

4. The Jamstack category is growing

- [ ] Percentage of "new" sites in crawl that meet the defined criteria of "fast", "resilient" and "cached"

5. Candidate sites
  * We get this from a [join between all URLs matching criteria or "better" on all 4 current queries](candidate_urls.sql)

## Resources

- [📄 Planning doc][~google-doc]
- [📊 Results sheet][~google-sheets]
- [📝 Markdown file][~chapter-markdown]

[~google-doc]: https://docs.google.com/document/d/15RLaaTVqoqb5AuDrlBt6L0J_BMx1ltKW4t8VWX-sN_g/edit?usp=sharing
[~google-sheets]: https://docs.google.com/spreadsheets/d/1yfNaj25ToezMwQLKdYP6Qh7AUoX9zMdKMSRVC8JlZMY/edit?usp=sharing
[~chapter-markdown]: https://github.com/HTTPArchive/almanac.httparchive.org/tree/main/src/content/en/2022/jamstack.md
