---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Ecommerce
description: This chapter explores trends in the ecommerce ecosystem, covering platform adoption, Core Web Vitals, Lighthouse metrics, payments, and regional differences. It highlights how platforms like WooCommerce and Shopify lead while newer players grow in specific markets.
hero_alt: Hero image of a Web Almanac character at a supermarket checkout loading items from a shopping basket onto the conveyor belt while another character pays with a credit card.
authors: [AmandeepSingh]
reviewers: [tunetheweb]
analysts: [AmandeepSingh]
editors: [tunetheweb]
translators: []
results: https://docs.google.com/spreadsheets/d/1tbbH4q4wzj4bpTj8ctRJ_8-NyS5KPBBcNInkemfxcR8
AmandeepSingh_bio: Amandeep Singh has been developing for the web since 2009 and writes about front end development, UI/UX, Shopify, BigCommerce, WordPress, and programming at <a hreflang="en" href="https://byaman.com/">byaman.com</a>. He is a writer, mentor, and speaker.
featured_quote: While ecommerce platforms are diverse and well distributed among different providers, a few key players dominate technologies like payment systems.
featured_stat_1: 19.8%
featured_stat_label_1: Desktop sites that are ecommerce
featured_stat_2: 35.9%
featured_stat_label_2: Desktop ecommerce sites built with WooCommerce
featured_stat_3: 3.9%
featured_stat_label_3: Desktop sites offering PayPal as a payment method
---

## Introduction

Ecommerce is no longer a special case on the web-it _is_ the web. In 2025, buying journeys start in search results, social feeds, and live streams; they continue in voice assistants, messaging apps, and lean‑back surfaces like smart TVs; and increasingly, they can be completed by AI agents acting on a shopper's behalf. An ecommerce website is still an online store that sells physical or digital products, but it now sits at the intersection of product pages, payments, performance, accessibility, and trust.

When building an online store, there are a few common platform models:

1. **Software-as-a-Service (SaaS)** platforms (e.g., Shopify) minimize the technical knowledge required to run a store by controlling the codebase and abstracting hosting.
2. **Platform-as-a-Service (PaaS)** solutions (e.g., Adobe Commerce / Magento) provide an optimized technology stack and hosting environment while still allowing full code access.
3. **Self-hosted** platforms (e.g., WooCommerce, OpenCart) run on infrastructure managed by the merchant or their agency.
4. **Headless / API-first** platforms (e.g., Commercetools, Medusa) provide the commerce backend as a service, while the merchant owns the frontend experience and hosting.
5. **Agentic commerce (agent-ready commerce)** layers sit alongside (or on top of) the storefront: structured product data, inventory, policies, identity, and payment flows exposed through APIs and standards so assistants and AI agents can safely discover products and execute purchases-with clear user consent and guardrails.

Platforms may fall into more than one category. For example, some vendors offer SaaS, PaaS, and self-hosted options, and many headless builds still rely on SaaS backends under the hood. The important variables are who controls hosting, who controls the runtime and upgrade path, and how much freedom you have to change the frontend and backend.

## Platform detection

We used a tool called Wappalyzer to detect technologies used by websites. It can detect ecommerce platforms, content management systems, JavaScript frameworks, analytics, and more.

For this analysis, we considered a site to be ecommerce if we detected either:

- Use of a known ecommerce platform, or
- Use of a technology that strongly implies an online store (for example, enhanced ecommerce analytics).

## Limitations

Our methodology has limitations that affect accuracy.

### Limitations in recognizing ecommerce sites

- We can only recognize ecommerce sites when Wappalyzer detects an ecommerce platform or a strong ecommerce signal.
- Detecting a payment processor alone (e.g., PayPal) is not sufficient to classify a site as ecommerce, because many non‑store sites also take payments.
- If the store is hosted in a subdirectory (and we only analyze the homepage), it may be missed.
- Headless implementations reduce platform detectability because the traditional fingerprints in HTML/JS often disappear.

### Accuracy of metrics and commentary

- Apparent trends can be influenced by improvements or regressions in detection, not just industry shifts.
- Crawl geography matters: results may differ when sites redirect based on location.
- The underlying site set is drawn from Chrome's field data ecosystem, which biases toward sites visited by Chrome users.

## Overall adoption

{{ figure_markup(
  caption="Percent of mobile pages that are ecommerce sites.",
  content="19.1%",
  classes="big-number",
  sheets_gid="1000255969",
  sql_file="top_ecommerce.sql"
  )
}}

In the 2025 dataset, we detected 19.8% of all analyzed desktop sites and 19.1% of all analyzed mobile sites.

That headline number is the first reminder that ecommerce is not just "a vertical"-it's a major slice of what real users experience on the open web.

### Adoption by rank

In general, the most popular sites are more likely to be professionally engineered, heavily optimized, and backed by larger budgets.

The following table shows how the share of sites that are ecommerce increases as we include less‑popular sites.

<figure>
  <table>
    <thead>
      <tr>
        <th>Rank tier</th>
        <th>Desktop ecommerce share</th>
        <th>Mobile ecommerce share</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Top 1,000</td>
        <td class="numeric">1.7%</td>
        <td class="numeric">1.4%</td>
      </tr>
      <tr>
        <td>Top 10,000</td>
        <td class="numeric">3.7%</td>
        <td class="numeric">3.2%</td>
      </tr>
      <tr>
        <td>Top 100,000</td>
        <td class="numeric">7.8%</td>
        <td class="numeric">6.9%</td>
      </tr>
      <tr>
        <td>Top 1,000,000</td>
        <td class="numeric">17.0%</td>
        <td class="numeric">15.5%</td>
      </tr>
      <tr>
        <td>Top 10,000,000</td>
        <td class="numeric">21.3%</td>
        <td class="numeric">20.7%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Top ecommerce platforms by rank.",
      sheets_gid="TODO",
      sql_file="TODO.sql",
    ) }}
  </figcaption>
</figure>

The pattern is consistent:

- At the very top of the web (top 1,000), ecommerce is present but rare.
- By the time you reach the top 10 million, roughly one in five sites is an online store.

## Platform market share

Across both desktop and mobile, the platform landscape remains top-heavy: a small set of systems account for the majority of detected stores, while a long tail of niche and regional platforms fills the rest.

The following tables show the share of detected ecommerce sites within ecommerce (platform market share), and also how often each platform appears across all sites in the dataset.

<figure>
  <table>
    <thead>
      <tr>
        <th>Platform</th>
        <th>Share of ecommerce sites</th>
        <th>Share of all sites</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WooCommerce</td>
        <td class="numeric">35.9%</td>
        <td class="numeric">7.1%</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">21.2%</td>
        <td class="numeric">4.2%</td>
      </tr>
      <tr>
        <td>Squarespace Commerce</td>
        <td class="numeric">9.1%</td>
        <td class="numeric">1.8%</td>
      </tr>
      <tr>
        <td>Wix eCommerce</td>
        <td class="numeric">7.8%</td>
        <td class="numeric">1.6%</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">3.2%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td class="numeric">1C-Bitrix</td>
        <td class="numeric">2.4%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>OpenCart</td>
        <td class="numeric">1.1%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>Cafe24</td>
        <td class="numeric">1.0%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>BigCommerce</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Desktop (top platforms, 2025).",
      sheets_gid="TODO",
      sql_file="TODO.sql",
    ) }}
  </figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Platform</th>
        <th>Share of ecommerce sites</th>
        <th>Share of all sites</th>
        <th>Detected sites</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WooCommerce</td>
        <td class="numeric">37.1%</td>
        <td class="numeric">7.1%</td>
        <td class="numeric">1,099,863</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">20.6%</td>
        <td class="numeric">3.9%</td>
        <td class="numeric">612,387</td>
      </tr>
      <tr>
        <td>Wix eCommerce</td>
        <td class="numeric">8.9%</td>
        <td class="numeric">1.7%</td>
        <td class="numeric">262,643</td>
      </tr>
      <tr>
        <td>Squarespace Commerce</td>
        <td class="numeric">8.1%</td>
        <td class="numeric">1.5%</td>
        <td class="numeric">239,580</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">3.1%</td>
        <td class="numeric">0.6%</td>
        <td class="numeric">92,484</td>
      </tr>
      <tr>
        <td class="numeric">1C-Bitrix</td>
        <td class="numeric">2.8%</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">82,394</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">1.8%</td>
        <td class="numeric">0.3%</td>
        <td class="numeric">53,179</td>
      </tr>
      <tr>
        <td>OpenCart</td>
        <td class="numeric">1.2%</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">35,493</td>
      </tr>
      <tr>
        <td>Tiendanube</td>
        <td class="numeric">0.8%</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">23,333</td>
      </tr>
      <tr>
        <td>Square Online</td>
        <td class="numeric">0.7%</td>
        <td class="numeric">0.1%</td>
        <td class="numeric">20,942</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Mobile (top platforms, 2025).",
      sheets_gid="TODO",
      sql_file="TODO.sql",
    ) }}
  </figcaption>
</figure>

### Trends since 2022

If you zoom out to the last few years, the story is less about disruption and more about slow consolidation:

- WooCommerce remains the largest ecosystem, staying roughly flat (about 37.2% → 35.9% of ecommerce sites from 2022 to 2025).
- Shopify continues to gain share (about 17.7% → 21.2%).
- Wix eCommerce is the fastest climber in the top 5 (about 4.5% → 7.8%).
- PrestaShop continues to trend down in share (about 4.6% → 3.2%).

In other words: the default choices are getting more default, and smaller open‑source ecosystems are having to compete harder on developer experience, hosting simplicity, and performance out of the box.

### Tops platforms by tier

Different tiers have different top platforms.

<figure>
  <table>
    <thead>
      <tr>
        <th>Position</th>
        <th>Top 1,000</th>
        <th>Top 10,000</th>
        <th>Top 100,000</th>
        <th>Top 1,000,000</th>
        <th>Top 10,000,000</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">1</td>
        <td>Magento</td>
        <td>Salesforce Commerce Cloud</td>
        <td>Shopify</td>
        <td>Shopify</td>
        <td>WooCommerce</td>
      </tr>
      <tr>
        <td class="numeric">2</td>
        <td>Amazon Webstore</td>
        <td>Fourthwall</td>
        <td>Magento</td>
        <td>WooCommerce</td>
        <td>Shopify</td>
      </tr>
      <tr>
        <td class="numeric">3</td>
        <td>Fourthwall</td>
        <td>Amazon Webstore</td>
        <td>Salesforce Commerce Cloud</td>
        <td>Magento</td>
        <td>Squarespace Commerce</td>
      </tr>
      <tr>
        <td class="numeric">4</td>
        <td>HCL Commerce</td>
        <td>Magento</td>
        <td>WooCommerce</td>
        <td>PrestaShop</td>
        <td>PrestaShop</td>
      </tr>
      <tr>
        <td class="numeric">5</td>
        <td>Pattern by Etsy</td>
        <td>SAP Commerce Cloud</td>
        <td>Amazon Webstore</td>
        <td class="numeric">1C-Bitrix</td>
        <td>Magento</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="TODO.",
      sheets_gid="TODO",
      sql_file="TODO.sql",
    ) }}
  </figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Position</th>
        <th>Top 1,000</th>
        <th>Top 10,000</th>
        <th>Top 100,000</th>
        <th>Top 1,000,000</th>
        <th>Top 10,000,000</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">1</td>
        <td>Magento</td>
        <td>Salesforce Commerce Cloud</td>
        <td>Shopify</td>
        <td>Shopify</td>
        <td>WooCommerce</td>
      </tr>
      <tr>
        <td class="numeric">2</td>
        <td>Fourthwall</td>
        <td>Fourthwall</td>
        <td>Magento</td>
        <td>WooCommerce</td>
        <td>Shopify</td>
      </tr>
      <tr>
        <td class="numeric">3</td>
        <td>HCL Commerce</td>
        <td>Amazon Webstore</td>
        <td>Salesforce Commerce Cloud</td>
        <td>Magento</td>
        <td>Squarespace Commerce</td>
      </tr>
      <tr>
        <td class="numeric">4</td>
        <td>Amazon Webstore</td>
        <td>Magento</td>
        <td>WooCommerce</td>
        <td>PrestaShop</td>
        <td>PrestaShop</td>
      </tr>
      <tr>
        <td class="numeric">5</td>
        <td>Pattern by Etsy</td>
        <td>SAP Commerce Cloud</td>
        <td>Amazon Webstore</td>
        <td class="numeric">1C-Bitrix</td>
        <td>Wix eCommerce</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="TODO.",
      sheets_gid="TODO",
      sql_file="TODO.sql",
    ) }}
  </figcaption>
</figure>

- In the very top ranks, enterprise and bespoke ecosystems show up more often.
- In the broader web, the long‑tail winners (especially WooCommerce) dominate by volume.

### Top platforms by geography

Platform dominance changes by region because of language, local payment rails, agency ecosystems, and the historical footprint of vendors.

{{ figure_markup(
  image="top-ecommerce-platform-by-country.png",
  caption="Top ecommerce platform by country in 2025.",
  description="Map showing the most popular ecommerce platform by country in 2025. WooCommerce leads in most regions, with Shopify and 1C-Bitrix leading in several markets, and regional leaders including Tiendanube, Shoptet, Cafe24, and Salla.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSLJnACGZxfgmNdBbsBBCiMfyBd3l0dp4FWbyHkjZcwXVqMDWHzcEYmqsrr9XTQDye4NA4qSMFX9xZG/pubchart?oid=1194862163&format=interactive",
  sheets_gid="1132201023",
  sql_file="top_shopsystem_by_geo.sql"
  )
}}

- On desktop, WooCommerce is the most common platform in 43 of 63 geographies in our country‑level view on the most popular platform.
- On mobile, WooCommerce leads even more often: 74 of 95.

There are also meaningful regional exceptions:

- 1C‑Bitrix leads in parts of Eastern Europe and Central Asia (e.g., Russian Federation, Belarus, Kazakhstan, Kyrgyzstan).
- Tiendanube stands out in Argentina.
- Shoptet appears as a leader in Czechia.
- Cafe24 leads in South Korea.
- Salla shows up strongly in Saudi Arabia.

## Core Web Vitals in ecommerce

Ecommerce sites are unusually sensitive to performance because every extra second compounds: slower category pages reduce product views; slower product pages reduce add‑to‑carts; slower checkout flows reduce conversion.

We use Core Web Vitals (CWV) field metrics to summarize real‑user experience:

- **LCP (Largest Contentful Paint):** measures _loading_ performance. It captures how quickly the main content becomes visible. In ecommerce, it often maps to hero imagery, product grids, and critical CSS/JS that blocks rendering.
- **INP (Interaction to Next Paint):** measures _responsiveness_. It captures the delay between a user action (tap/click) and the next visual update. It is sensitive to heavy JavaScript, third-party tags, and main-thread contention.
- **CLS (Cumulative Layout Shift):** measures _visual stability_. It captures how much content shifts as the page loads. It's especially relevant to ecommerce because late-loading product images, personalization widgets, and promo banners can cause mis-clicks.

A site is considered "good" on CWV when it passes all three thresholds.

{{ figure_markup(
  image="desktop-core-web-vitals-by-platform.png",
  caption="Desktop Core Web Vitals pass rate by platform in 2025.",
  description="Bar chart showing the share of desktop ecommerce origins with good Core Web Vitals across leading platforms in 2025.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSLJnACGZxfgmNdBbsBBCiMfyBd3l0dp4FWbyHkjZcwXVqMDWHzcEYmqsrr9XTQDye4NA4qSMFX9xZG/pubchart?oid=1640167201&format=interactive",
  sheets_gid="871753253",
  sql_file="core_web_vitals_by_platform.sql"
  )
}}

{{ figure_markup(
  image="mobile-core-web-vitals-by-platform.png",
  caption="Mobile Core Web Vitals pass rate by platform in 2025.",
  description="Bar chart showing the share of mobile ecommerce origins with good Core Web Vitals across leading platforms in 2025.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSLJnACGZxfgmNdBbsBBCiMfyBd3l0dp4FWbyHkjZcwXVqMDWHzcEYmqsrr9XTQDye4NA4qSMFX9xZG/pubchart?oid=433690173&format=interactive",
  sheets_gid="871753253",
  sql_file="core_web_vitals_by_platform.sql"
  )
}}

### CWV by platform

<figure>
  <table>
    <thead>
      <tr>
        <th>Platform</th>
        <th>Origins</th>
        <th>Good LCP</th>
        <th>Good INP</th>
        <th>Good CLS</th>
        <th>Good CWV</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WooCommerce</td>
        <td class="numeric">401,579</td>
        <td class="numeric">45.5%</td>
        <td class="numeric">99.3%</td>
        <td class="numeric">67.7%</td>
        <td class="numeric">33.5%</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">286,618</td>
        <td class="numeric">92.5%</td>
        <td class="numeric">99.3%</td>
        <td class="numeric">82.2%</td>
        <td class="numeric">75.9%</td>
      </tr>
      <tr>
        <td>Squarespace Commerce</td>
        <td class="numeric">82,393</td>
        <td class="numeric">90.3%</td>
        <td class="numeric">99.7%</td>
        <td class="numeric">77.6%</td>
        <td class="numeric">69.3%</td>
      </tr>
      <tr>
        <td>Wix eCommerce</td>
        <td class="numeric">56,104</td>
        <td class="numeric">76.0%</td>
        <td class="numeric">99.4%</td>
        <td class="numeric">90.4%</td>
        <td class="numeric">68.8%</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">46,479</td>
        <td class="numeric">74.5%</td>
        <td class="numeric">98.6%</td>
        <td class="numeric">71.1%</td>
        <td class="numeric">53.7%</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">37,153</td>
        <td class="numeric">60.0%</td>
        <td class="numeric">99.0%</td>
        <td class="numeric">55.3%</td>
        <td class="numeric">36.6%</td>
      </tr>
      <tr>
        <td class="numeric">1C-Bitrix</td>
        <td class="numeric">31,699</td>
        <td class="numeric">85.9%</td>
        <td class="numeric">99.4%</td>
        <td class="numeric">79.9%</td>
        <td class="numeric">68.2%</td>
      </tr>
      <tr>
        <td>OpenCart</td>
        <td class="numeric">14,476</td>
        <td class="numeric">86.6%</td>
        <td class="numeric">99.1%</td>
        <td class="numeric">80.0%</td>
        <td class="numeric">70.3%</td>
      </tr>
      <tr>
        <td>Cafe24</td>
        <td class="numeric">13,557</td>
        <td class="numeric">98.3%</td>
        <td class="numeric">97.6%</td>
        <td class="numeric">47.4%</td>
        <td class="numeric">45.8%</td>
      </tr>
      <tr>
        <td>BigCommerce</td>
        <td class="numeric">12,133</td>
        <td class="numeric">91.5%</td>
        <td class="numeric">99.4%</td>
        <td class="numeric">59.5%</td>
        <td class="numeric">55.2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="TODO.",
      sheets_gid="TODO",
      sql_file="TODO.sql",
    ) }}
  </figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Platform</th>
        <th>Origins</th>
        <th>Good LCP</th>
        <th>Good INP</th>
        <th>Good CLS</th>
        <th>Good CWV</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WooCommerce</td>
        <td class="numeric">401,579</td>
        <td class="numeric">45.5%</td>
        <td class="numeric">99.3%</td>
        <td class="numeric">67.7%</td>
        <td class="numeric">33.5%</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">286,618</td>
        <td class="numeric">92.5%</td>
        <td class="numeric">99.3%</td>
        <td class="numeric">82.2%</td>
        <td class="numeric">75.9%</td>
      </tr>
      <tr>
        <td>Squarespace Commerce</td>
        <td class="numeric">82,393</td>
        <td class="numeric">90.3%</td>
        <td class="numeric">99.7%</td>
        <td class="numeric">77.6%</td>
        <td class="numeric">69.3%</td>
      </tr>
      <tr>
        <td>Wix eCommerce</td>
        <td class="numeric">56,104</td>
        <td class="numeric">76.0%</td>
        <td class="numeric">99.4%</td>
        <td class="numeric">90.4%</td>
        <td class="numeric">68.8%</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">46,479</td>
        <td class="numeric">74.5%</td>
        <td class="numeric">98.6%</td>
        <td class="numeric">71.1%</td>
        <td class="numeric">53.7%</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">37,153</td>
        <td class="numeric">60.0%</td>
        <td class="numeric">99.0%</td>
        <td class="numeric">55.3%</td>
        <td class="numeric">36.6%</td>
      </tr>
      <tr>
        <td class="numeric">1C-Bitrix</td>
        <td class="numeric">31,699</td>
        <td class="numeric">85.9%</td>
        <td class="numeric">99.4%</td>
        <td class="numeric">79.9%</td>
        <td class="numeric">68.2%</td>
      </tr>
      <tr>
        <td>OpenCart</td>
        <td class="numeric">14,476</td>
        <td class="numeric">86.6%</td>
        <td class="numeric">99.1%</td>
        <td class="numeric">80.0%</td>
        <td class="numeric">70.3%</td>
      </tr>
      <tr>
        <td>Cafe24</td>
        <td class="numeric">13,557</td>
        <td class="numeric">98.3%</td>
        <td class="numeric">97.6%</td>
        <td class="numeric">47.4%</td>
        <td class="numeric">45.8%</td>
      </tr>
      <tr>
        <td>BigCommerce</td>
        <td class="numeric">12,133</td>
        <td class="numeric">91.5%</td>
        <td class="numeric">99.4%</td>
        <td class="numeric">59.5%</td>
        <td class="numeric">55.2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Mobile (2025, top platforms by origin count).",
      sheets_gid="TODO",
      sql_file="TODO.sql",
    ) }}
  </figcaption>
</figure>

A few patterns show up repeatedly:

- INP is generally strong on desktop across most major platforms, suggesting that modern JS stacks and browser improvements are helping responsiveness.
- LCP is the biggest differentiator-platforms that ship fast themes and tightly controlled app ecosystems tend to score better.
- WooCommerce has scale, but not automatic speed: its CWV pass rates lag behind SaaS-heavy ecosystems, which is consistent with its infinite customizatio" nature.

### Year-over-year movement

Looking at the largest platforms from 2024 → 2025, most ecosystems improved their "good" Core Web Vitals share, but the magnitude differs:

- Wix eCommerce sees the biggest jump (≈ 16.2% on mobile and 18.8% on desktop).
- Shopify also improves materially (≈ 7.9% mobile; 5.8% desktop).
- WooCommerce improves more modestly (≈ 4.9% mobile; 4.1% desktop).

This is the tradeoff you should expect: platforms that centralize more of the stack can deliver performance improvements to millions of stores at once. Platforms that decentralize responsibility (themes, plugins, hosting, agencies) tend to improve more slowly because the bottleneck is coordination.

## Lighthouse

Lighthouse is the HTTP Archive's lab-based audit. Unlike Core Web Vitals (field data), it runs in a controlled environment (simulated device, throttled network/CPU) and produces scores for Performance, Accessibility, SEO, and Best Practices:

- **Performance**: Lighthouse Performance is a lab score (0–100) summarizing load and responsiveness under a controlled test profile. It's most useful for relative comparisons across platforms.
- **Accessibility**: Lighthouse Accessibility is based on automated checks (it cannot catch everything), but it's a useful baseline signal for common issues like missing labels, low contrast, and incorrect semantics.
- **SEO**: The Lighthouse SEO score reflects technical SEO fundamentals (e.g., title/meta, basic crawlability signals). High medians are common because these checks are straightforward to pass.
- **Best Practices**: Best Practices is a grab bag of security and reliability checks (HTTPS, safe JS patterns, modern APIs). It often reflects platform defaults and theme quality.

Lighthouse is useful for comparisons across large sets of sites, but it won't perfectly match what real users experience.

### Median Lighthouse scores by platform

<figure>
  <table>
    <thead>
      <tr>
        <th>Platform</th>
        <th>Sites tested</th>
        <th>Performance (median)</th>
        <th>Accessibility (median)</th>
        <th>SEO (median)</th>
        <th>Best Practices (median)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WooCommerce</td>
        <td class="numeric">886,516</td>
        <td class="numeric">56</td>
        <td class="numeric">85</td>
        <td class="numeric">92</td>
        <td class="numeric">78</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">486,573</td>
        <td class="numeric">71</td>
        <td class="numeric">88</td>
        <td class="numeric">92</td>
        <td class="numeric">78</td>
      </tr>
      <tr>
        <td>Squarespace Commerce</td>
        <td class="numeric">227,616</td>
        <td class="numeric">60</td>
        <td class="numeric">93</td>
        <td class="numeric">92</td>
        <td class="numeric">100</td>
      </tr>
      <tr>
        <td>Wix eCommerce</td>
        <td class="numeric">175,056</td>
        <td class="numeric">82</td>
        <td class="numeric">95</td>
        <td class="numeric">100</td>
        <td class="numeric">78</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">87,551</td>
        <td class="numeric">53</td>
        <td class="numeric">78</td>
        <td class="numeric">92</td>
        <td class="numeric">78</td>
      </tr>
      <tr>
        <td class="numeric">1C-Bitrix</td>
        <td class="numeric">61,876</td>
        <td class="numeric">51</td>
        <td class="numeric">75</td>
        <td class="numeric">92</td>
        <td class="numeric">56</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">58,287</td>
        <td class="numeric">55</td>
        <td class="numeric">76</td>
        <td class="numeric">91</td>
        <td class="numeric">74</td>
      </tr>
      <tr>
        <td>OpenCart</td>
        <td class="numeric">26,934</td>
        <td class="numeric">56</td>
        <td class="numeric">79</td>
        <td class="numeric">91</td>
        <td class="numeric">78</td>
      </tr>
      <tr>
        <td>Cafe24</td>
        <td class="numeric">22,221</td>
        <td class="numeric">34</td>
        <td class="numeric">71</td>
        <td class="numeric">85</td>
        <td class="numeric">56</td>
      </tr>
      <tr>
        <td>BigCommerce</td>
        <td class="numeric">20,120</td>
        <td class="numeric">64</td>
        <td class="numeric">79</td>
        <td class="numeric">92</td>
        <td class="numeric">74</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Desktop (top platforms by test count).",
      sheets_gid="TODO",
      sql_file="TODO.sql",
    ) }}
  </figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Platform</th>
        <th>Sites tested</th>
        <th>Performance (median)</th>
        <th>Accessibility (median)</th>
        <th>SEO (median)</th>
        <th>Best Practices (median)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WooCommerce</td>
        <td class="numeric">1,116,462</td>
        <td class="numeric">32</td>
        <td class="numeric">85</td>
        <td class="numeric">92</td>
        <td class="numeric">79</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">573,370</td>
        <td class="numeric">43</td>
        <td class="numeric">88</td>
        <td class="numeric">92</td>
        <td class="numeric">79</td>
      </tr>
      <tr>
        <td>Wix eCommerce</td>
        <td class="numeric">250,295</td>
        <td class="numeric">52</td>
        <td class="numeric">95</td>
        <td class="numeric">100</td>
        <td class="numeric">79</td>
      </tr>
      <tr>
        <td>Squarespace Commerce</td>
        <td class="numeric">243,490</td>
        <td class="numeric">30</td>
        <td class="numeric">94</td>
        <td class="numeric">92</td>
        <td class="numeric">96</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">103,104</td>
        <td class="numeric">30</td>
        <td class="numeric">79</td>
        <td class="numeric">92</td>
        <td class="numeric">79</td>
      </tr>
      <tr>
        <td class="numeric">1C-Bitrix</td>
        <td class="numeric">90,214</td>
        <td class="numeric">33</td>
        <td class="numeric">75</td>
        <td class="numeric">92</td>
        <td class="numeric">57</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">61,633</td>
        <td class="numeric">31</td>
        <td class="numeric">77</td>
        <td class="numeric">91</td>
        <td class="numeric">75</td>
      </tr>
      <tr>
        <td>OpenCart</td>
        <td class="numeric">35,585</td>
        <td class="numeric">35</td>
        <td class="numeric">77</td>
        <td class="numeric">91</td>
        <td class="numeric">79</td>
      </tr>
      <tr>
        <td>Mercado Shops</td>
        <td class="numeric">24,413</td>
        <td class="numeric">36</td>
        <td class="numeric">86</td>
        <td class="numeric">92</td>
        <td class="numeric">96</td>
      </tr>
      <tr>
        <td>Tiendanube</td>
        <td class="numeric">23,106</td>
        <td class="numeric">58</td>
        <td class="numeric">93</td>
        <td class="numeric">92</td>
        <td class="numeric">75</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Mobile (top platforms by test count).",
      sheets_gid="TODO",
      sql_file="TODO.sql",
    ) }}
  </figcaption>
</figure>

A few high-level patterns:

- SaaS storefronts tend to cluster higher on the Performance category (especially on desktop), consistent with tighter control over themes and defaults.
- Accessibility medians are generally strong across top platforms, but medians can hide long-tail variance.
- SEO and Best Practices scores are high for most platforms-where teams usually win or lose is performance and implementation discipline, not basic technical SEO.

## Payment providers

Payments are where ecommerce becomes real. They also represent a major dependency surface area: third‑party scripts, redirects, fraud tooling, and compliance constraints.

{{ figure_markup(
  image="payment-provider-distribution.png",
  caption="Payment provider distribution on ecommerce sites in 2025.",
  description="Bar chart showing the distribution of payment providers detected on ecommerce sites in 2025, led by PayPal, Apple Pay, Shop Pay, Visa, and Mastercard.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSLJnACGZxfgmNdBbsBBCiMfyBd3l0dp4FWbyHkjZcwXVqMDWHzcEYmqsrr9XTQDye4NA4qSMFX9xZG/pubchart?oid=1053919780&format=interactive",
  sheets_gid="1631427419",
  sql_file="top_payment_providers.sql"
  )
}}

The following tables show the most commonly detected payment providers in 2025.

<figure>
  <table>
    <thead>
      <tr>
        <th>Payment provider</th>
        <th>Share of payment detections</th>
        <th>Share of all sites</th>
        <th>Detected sites</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>PayPal</td>
        <td class="numeric">18.6%</td>
        <td class="numeric">3.9%</td>
        <td class="numeric">485,370</td>
      </tr>
      <tr>
        <td>Apple Pay</td>
        <td class="numeric">13.4%</td>
        <td class="numeric">2.8%</td>
        <td class="numeric">350,570</td>
      </tr>
      <tr>
        <td>Shop Pay</td>
        <td class="numeric">12.1%</td>
        <td class="numeric">2.5%</td>
        <td class="numeric">316,918</td>
      </tr>
      <tr>
        <td>Visa</td>
        <td class="numeric">10.3%</td>
        <td class="numeric">2.1%</td>
        <td class="numeric">268,465</td>
      </tr>
      <tr>
        <td>Mastercard</td>
        <td class="numeric">10.3%</td>
        <td class="numeric">2.1%</td>
        <td class="numeric">268,295</td>
      </tr>
      <tr>
        <td>American Express</td>
        <td class="numeric">9.2%</td>
        <td class="numeric">1.9%</td>
        <td class="numeric">240,071</td>
      </tr>
      <tr>
        <td>Stripe</td>
        <td class="numeric">8.6%</td>
        <td class="numeric">1.8%</td>
        <td class="numeric">225,053</td>
      </tr>
      <tr>
        <td>Google Pay</td>
        <td class="numeric">8.3%</td>
        <td class="numeric">1.7%</td>
        <td class="numeric">218,246</td>
      </tr>
      <tr>
        <td>Venmo</td>
        <td class="numeric">2.5%</td>
        <td class="numeric">0.5%</td>
        <td class="numeric">65,331</td>
      </tr>
      <tr>
        <td>Klarna Checkout</td>
        <td class="numeric">1.2%</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">30,852</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Desktop (2025, top payment providers).",
      sheets_gid="TODO",
      sql_file="TODO.sql",
    ) }}
  </figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Payment provider</th>
        <th>Share of payment detections</th>
        <th>Share of all sites</th>
        <th>Detected sites</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>PayPal</td>
        <td class="numeric">18.8%</td>
        <td class="numeric">3.5%</td>
        <td class="numeric">548,276</td>
      </tr>
      <tr>
        <td>Apple Pay</td>
        <td class="numeric">13.4%</td>
        <td class="numeric">2.5%</td>
        <td class="numeric">390,665</td>
      </tr>
      <tr>
        <td>Shop Pay</td>
        <td class="numeric">11.9%</td>
        <td class="numeric">2.2%</td>
        <td class="numeric">348,267</td>
      </tr>
      <tr>
        <td>Visa</td>
        <td class="numeric">10.6%</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">309,054</td>
      </tr>
      <tr>
        <td>Mastercard</td>
        <td class="numeric">10.6%</td>
        <td class="numeric">2.0%</td>
        <td class="numeric">308,874</td>
      </tr>
      <tr>
        <td>American Express</td>
        <td class="numeric">9.4%</td>
        <td class="numeric">1.8%</td>
        <td class="numeric">273,942</td>
      </tr>
      <tr>
        <td>Google Pay</td>
        <td class="numeric">8.6%</td>
        <td class="numeric">1.6%</td>
        <td class="numeric">250,089</td>
      </tr>
      <tr>
        <td>Stripe</td>
        <td class="numeric">7.9%</td>
        <td class="numeric">1.5%</td>
        <td class="numeric">230,914</td>
      </tr>
      <tr>
        <td>Venmo</td>
        <td class="numeric">2.3%</td>
        <td class="numeric">0.4%</td>
        <td class="numeric">68,549</td>
      </tr>
      <tr>
        <td>Klarna Checkout</td>
        <td class="numeric">1.3%</td>
        <td class="numeric">0.2%</td>
        <td class="numeric">38,175</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Mobile (2025, top payment providers).",
      sheets_gid="TODO",
      sql_file="TODO.sql",
    ) }}
  </figcaption>
</figure>

The top 10 payment technologies cover roughly 94.4% of detections on desktop and 94.7% on mobile-another reminder that payments consolidate quickly.

### What changed since 2022?

The most noticeable trend is that PayPal's share of payment detections declines, while wallets and processor‑first ecosystems grow:

- PayPal falls from ~39% of payment detections in 2022 to ~30% in 2025 (desktop and mobile both show this pattern).
- Stripe and Google Pay gain share over the same period.
- Apple Pay and Shop Pay stay relatively stable at high levels.

This does not mean PayPal is dying. It means the payment layer is becoming more diversified-especially as native wallets, link-based checkout, and platform-native accelerators become standard.

### Payment providers by geography

{{ figure_markup(
  image="top-payment-provider-by-country.png",
  caption="Top payment provider by country in 2025.",
  description="Map showing the top payment provider by country in 2025. PayPal leads most mobile geographies, while Stripe leads more desktop geographies.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSLJnACGZxfgmNdBbsBBCiMfyBd3l0dp4FWbyHkjZcwXVqMDWHzcEYmqsrr9XTQDye4NA4qSMFX9xZG/pubchart?oid=970649597&format=interactive",
  sheets_gid="970649597",
  sql_file="top_payment_provider_by_geo.sql"
  )
}}

- On mobile, PayPal is the top payment provider in 70 of 83 geographies in our view.
- On desktop, leadership is more split: Stripe leads in 31 geographies while PayPal leads in 22.

Notable examples:

- Apple Pay leads in New Zealand (both desktop and mobile).
- Braintree stands out in Taiwan.
- Several African and Middle Eastern markets show Stripe as the most common top provider in this dataset (e.g., Nigeria, Kenya, UAE).

## Conclusion

Ecommerce in 2025 remains both concentrated and diverse. A handful of platforms account for most detected ecommerce sites-led by WooCommerce and Shopify-while a long tail of regional and niche systems continues to matter in specific markets. Website rank adds another layer: enterprise-oriented platforms show up disproportionately in higher-traffic tiers, while long-tail sites skew toward easier-to-adopt and lower-cost solutions.

Performance remains a differentiator, not a footnote. Field metrics (Core Web Vitals) and lab audits (Lighthouse) both show that tighter platform control can correlate with better median outcomes, but the gap is not destiny-self-hosted and heavily customized stacks can perform well when engineering discipline is strong. Payment technologies also consolidate quickly: a small set of providers dominates detections, while wallets and processor-first ecosystems keep gaining share.

The next chapter of ecommerce is not just which platform, but which channels: voice, live commerce, and agentic commerce are pushing stores to become faster, more accessible, and more machine-consumable. The winners will be the ones who treat catalog quality, performance, and trust as product features-because increasingly, the shopper may not be a human clicking around a page at all.
