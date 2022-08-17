# 2022 Jamstack queries

Jamstack is a hard category to define, since the definition is architectural -- a decoupled back end and front end -- which is not a distinction visible to a crawler. So we have gone with a number of proxy metrics, in combination. See [draft](https://docs.google.com/document/d/15RLaaTVqoqb5AuDrlBt6L0J_BMx1ltKW4t8VWX-sN_g/edit#heading=h.8z91yaf1dmft) for more detail on methodology.

1. Jamstack sites are fast

- Largest Contentful Paint using user timings
  * Distribution of LCP times on [mobile](distribution_lcp_mobile.sql) and [desktop](distribution_lcp_desktop.sql)
    * Mobile median p75 LCP is 2.4 seconds
    * Desktop median p75 LCP is 2.0 seconds
  * Better means: anything with this or lower

2. Jamstack sites are resilient (and pre-rendered)

- How much the content changes post-load, i.e. Cumulative Layout Shift
  * Have distribution of CLS scores on [mobile](distribution_cls_mobile.sql) and [desktop](distribution_cls_desktop.sql)
    * Mobile median p75 CLS is 0.05
    * Desktop median p75 CLS is 0.05
  * Better means: anything with this or lower

3. Jamstack sites are cached (often for a long time)

- Change Age and Cache Control Headers
  * Better means: anything with this or longer

This definition was used to populate the [`httparchive.almanac.jamstack_sites`](jamstack-sites.sql) table (including previous years based on that definition), and then queries were run based off of that.

## Resources

- [📄 Planning doc][~google-doc]
- [📊 Results sheet][~google-sheets]
- [📝 Markdown file][~chapter-markdown]

[~google-doc]: https://docs.google.com/document/d/15RLaaTVqoqb5AuDrlBt6L0J_BMx1ltKW4t8VWX-sN_g/edit?usp=sharing
[~google-sheets]: https://docs.google.com/spreadsheets/d/1yfNaj25ToezMwQLKdYP6Qh7AUoX9zMdKMSRVC8JlZMY/edit?usp=sharing
[~chapter-markdown]: https://github.com/HTTPArchive/almanac.httparchive.org/tree/main/src/content/en/2022/jamstack.md
