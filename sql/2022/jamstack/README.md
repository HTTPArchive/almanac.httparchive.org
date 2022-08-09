# 2022 Jamstack queries

Jamstack is a hard category to define, since the definition is architectural -- a decoupled back end and front end -- which is not a distinction visible to a crawler. So we have gone with a number of proxy metrics, in combination:

1. Jamstack sites are fast

- [ ] Lighthouse Performance score
  * Have [distribution of Lighthouse performance scores](lighthouse_distribution.sql); median score is 0.3
  * Better means: anything with this or larger
- [ ] Largest Contentful Paint using user timings
  * Have [distribution of LCP times](distribution_lcp.sql); median is 5.5 seconds
  * Better means: anything with this or lower

2. Jamstack sites are resilient (and pre-rendered)

- [ ] How much the content changes post-load, i.e. Cumulative Layout Shift
  * Have [distribution of CLS scores](distribution_cls.sql); median is 0.058
  * Better means: anything with this or lower

3. Jamstack sites are cached for a long time

- [ ] Age header
  * Have [distribution of Age headers](distribution_age_headers.sql); median is 19 hours
  * Better means: anything with this or longer

4. The Jamstack category is growing

- [ ] Percentage of "new" sites in crawl that meet the defined criteria of "fast", "resilient" and "cached"

5. Candidate sites
  * We get this from a [join between all URLs matching criteria or "better" on all 4 current queries](candidate_urls.sql); this matches 26,107 sites out of 615,902 potential URLs = 4.2%

## Resources

- [📄 Planning doc][~google-doc]
- [📊 Results sheet][~google-sheets]
- [📝 Markdown file][~chapter-markdown]

[~google-doc]: https://docs.google.com/document/d/15RLaaTVqoqb5AuDrlBt6L0J_BMx1ltKW4t8VWX-sN_g/edit?usp=sharing
[~google-sheets]: https://docs.google.com/spreadsheets/d/1yfNaj25ToezMwQLKdYP6Qh7AUoX9zMdKMSRVC8JlZMY/edit?usp=sharing
[~chapter-markdown]: https://github.com/HTTPArchive/almanac.httparchive.org/tree/main/src/content/en/2022/jamstack.md
