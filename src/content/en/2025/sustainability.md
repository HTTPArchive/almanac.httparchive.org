---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Sustainability
description: Sustainability chapter of the 2025 Web Almanac covering environmental impacts of web pages, where they come from and how to reduce them.
hero_alt: Hero image of Web Almanac characters installing solar panels on top of a web page.
authors: [AlexDawsonUK, burakguneli]
reviewers: [lebreRafael, rosenewell]
analysts: [burakguneli]
editors: []
translators: []
results: https://docs.google.com/spreadsheets/d/1oTOkbeVSuwhVQQEFTHtj5UF6bImIUc_Iey84qZ7m9pY/edit?usp=sharing
featured_quote: Sustainability moved from a niche to a regulated, standards-backed discipline in 2025—an essential part of how we build for the web.
featured_stat_1: 0.36 gCO2e
featured_stat_label_1: Median desktop emissions per page visit
featured_stat_2: 271 KB
featured_stat_label_2: Median unused JavaScript shipped
featured_stat_3: 65%
featured_stat_label_3: Sites not using a CDN
doi: ...
---

## A Transparency Note: Quality Over Quantity

The Web Almanac is a massive, volunteer-driven effort. This year, our team faced significant constraints in bandwidth and resources. As we approached our deadlines, we faced a choice: publish a rushed, potentially incomplete report, or pivot to a high-quality executive summary that highlights the most critical updates.

We chose the latter. We believe the sustainability community deserves accurate, actionable insights rather than a "weak report with lots of holes". While we are not publishing a full-length chapter this year, we are releasing the complete queried statistics publicly. We invite data scientists, researchers, and curious developers to explore the raw data and draw their own conclusions to supplement this summary.

- [Explore the 2025 Sustainability Dataset](https://docs.google.com/spreadsheets/d/1oTOkbeVSuwhVQQEFTHtj5UF6bImIUc_Iey84qZ7m9pY/edit?usp=sharing)

## 2025 Executive Summary: The State of the Field

The last 12 months have been transformative for digital sustainability. The field has matured from a niche interest into a regulated, standardized professional discipline. The most significant milestone of the year was the adoption of the Sustainable Web Design Community Group into the W3C as an official Interest Group. This move signals that sustainability is no longer an edge case—it is a core component of the web's future standards.

## The Regulatory Landscape: From Voluntary to Mandatory

Since the 2024 Almanac, digital sustainability has moved from a "nice-to-have" to a legal imperative. The regulatory landscape has shifted aggressively, with governments holding businesses accountable for their environmental footprints.

- The European Union continues to lead with the Corporate Sustainability Reporting Directive (CSRD), mandating that large corporations report on Scope 1, 2, and 3 emissions. Additionally, the Ecodesign for Sustainable Products Regulation (ESPR) pushes for circular economies in physical infrastructure.
- France remains a leader with its General Policy Framework for the Ecodesign of Digital Services, focusing heavily on training engineers in energy efficiency.
- The United States is catching up. California's Climate Corporate Data Accountability Act (S.B. 253) requires major companies to disclose greenhouse gas emissions, while the federal Clean Cloud Act establishes requirements for IT equipment data collection.
- Global Adoption: Similar reporting standards are emerging in Brazil, Singapore, India, Canada, and Australia.

For web professionals, the message is clear: compliance is no longer optional.

## Data Trends: The Web is Getting Heavier

Despite better tools, the 2025 data indicates we are moving in the wrong direction.

- **Rising Emissions**: Median desktop emissions have risen to **0.36 gCO2e per page visit** (up from 0.33g in 2024). The "bloat" of the web is outpacing our efficiency gains.
- **The "Unused" Epidemic**: We are shipping massive amounts of dead code. The median desktop page now carries **271 KB of unused JavaScript** and **57 KB of unused CSS**. This data is transferred, processed, and discarded—a triple waste of energy.
- **Framework Choices Matter**: Not all tools are equal. Our data shows that sites built with Eleventy (median 482 KB) are nearly 5x lighter than those built with Next.js (median 2,214 KB).
- **Missing Basics**:
  - **Caching & Compression**: Over 30% of sites lack basic caching headers, and ~12% of text resources are sent without compression.
  - **Hosting**: While ~50% of the top 1,000 websites use green hosting, this drops to under 10% for the broader web.
  - **CDNs**: 65% of sites detected were not using a CDN, missing a massive opportunity for caching and efficient data delivery.

## CMS and E-Commerce Impact

Our data highlights significant variance in the environmental impact of major platforms.

- **CMS**: Platforms like WordPress and Shopify continue to power a massive portion of the web. The data suggests that while these platforms are capable of sustainability, the median implementation is often heavy. For example, Squarespace sites (median ~3,400 KB) consistently showed higher page weights compared to others in our sample.
- **E-Commerce**: E-commerce applications remain some of the heaviest on the web due to complex functionality and media-heavy product pages. Optimizing these platforms offers one of the highest returns on investment for emission reductions.

## Standardization: The W3C Web Sustainability Guidelines (WSG)

Perhaps the most significant story of the year is the formal adoption of the Sustainable Web Design Community Group into the W3C as an official Interest Group. This marks a turning point where digital sustainability is now a dedicated workstream within the organization that defines the web.

We strongly encourage all developers, designers, and product owners to align their work with the Web Sustainability Guidelines (WSG). As we move toward 2026, the WSG remains the definitive source of truth for evidence-based sustainability guidance.

## 2026 Call for Contributors

To reverse these trends, we need to measure them. The Web Almanac is a volunteer-driven project, and the Sustainability chapter requires a dedicated team to analyze the massive scale of the web's environmental impact.

If you are passionate about the planet and the web, we need your help for the 2026 edition. We are looking for data analysts, authors, and peer reviewers to help us build the most comprehensive report to date.

## Recommended Resources

- [W3C Web Sustainability Guidelines (WSG)](https://w3c.github.io/sustyweb/)
- [MDN Introduction to Web Sustainability](https://developer.mozilla.org/en-US/blog/introduction-to-web-sustainability/)
- [Sustainable Web Design](https://sustainablewebdesign.org/)
- [Climate Product Leaders Playbook](https://www.climateproductleaders.org/)
