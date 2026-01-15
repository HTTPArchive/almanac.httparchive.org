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
featured_stat_1: 19.1%
featured_stat_label_1: Mobile sites that are ecommerce
featured_stat_2: 44.2%
featured_stat_label_2: Mobile ecommerce sites built with WooCommerce
featured_stat_3: 3.5%
featured_stat_label_3: Mobile sites offering PayPal as a payment method
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

### Limitations in recognizing ecommerce sites

Our methodology has limitations that affect accuracy.

- We can only recognize ecommerce sites when Wappalyzer detects an ecommerce platform or a strong ecommerce signal.
- Detecting a payment processor alone (for example, PayPal) is not sufficient to classify a site as ecommerce, because many non‑store sites also take payments.
- If the store is hosted in a subdirectory, it may be missed. We crawl the home page and one other page (the largest internal link) per site and per client (desktop and mobile).
- Headless implementations reduce platform detectability because the traditional fingerprints in HTML/JS often disappear.
- Apparent trends can be influenced by improvements or regressions in detection, not just industry shifts.
- Crawl geography matters: results may differ when sites redirect based on location.
- The underlying site set is drawn from Chrome's field data ecosystem, which biases toward sites visited by Chrome users.

## Overall adoption

{{ figure_markup(
  caption="Percent of mobile pages that are ecommerce sites.",
  content="19.2%",
  classes="big-number",
  sheets_gid="1784928999",
  sql_file="counts.sql"
  )
}}

In the 2025 dataset, we detected 19.9% of all analyzed desktop sites and 19.2% of all analyzed mobile sites where ecommerce sites.

That headline number is the first reminder that ecommerce is not just "a vertical"-it's a major slice of what real users experience on the open web.

### Adoption by rank

In general, the most popular sites are more likely to be professionally engineered, heavily optimized, and backed by larger budgets.

The following table shows how the share of sites that are ecommerce increases as we include less‑popular sites.

<figure>
  <table>
    <thead>
      <tr>
        <th>Rank tier</th>
        <th>Desktop share</th>
        <th>Mobile share</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Top 1,000</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>Top 10,000</td>
        <td class="numeric">3.5%</td>
        <td class="numeric">3.1%</td>
      </tr>
      <tr>
        <td>Top 100,000</td>
        <td class="numeric">8.0%</td>
        <td class="numeric">7.1%</td>
      </tr>
      <tr>
        <td>Top 1,000,000</td>
        <td class="numeric">17.4%</td>
        <td class="numeric">15.7%</td>
      </tr>
      <tr>
        <td>Top 10,000,000</td>
        <td class="numeric">21.7%</td>
        <td class="numeric">21.0%</td>
      </tr>
      <tr>
        <td>All sites</td>
        <td class="numeric">19.9%</td>
        <td class="numeric">19.2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Ecommerce adoption by rank",
      sheets_gid="1784928999",
      sql_file="counts.sql",
    ) }}
  </figcaption>
</figure>

The pattern is consistent:

- At the very top of the web (top 1,000), ecommerce is present but rare.
- This grows over each rank.
- By the time you reach the top 10 million, roughly one in five sites is an online store.

## Platform market share

Across both desktop and mobile, the platform landscape remains top-heavy: a small set of systems account for the majority of detected stores, while a long tail of niche and regional platforms fills the rest.

The following tables show the share of detected ecommerce sites within ecommerce (platform market share), and also how often each platform appears across all sites in the dataset.

<figure>
  <table>
    <thead>
      <tr>
        <th>Platform</th>
        <th>% ecommerce sites</th>
        <th>% all sites</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WooCommerce</td>
        <td class="numeric">35.4%</td>
        <td class="numeric">7.1%</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">21.5%</td>
        <td class="numeric">4.3%</td>
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
        <td>1C-Bitrix</td>
        <td class="numeric">2.2%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">2.1%</td>
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
        <td class="numeric">0.8%</td>
        <td class="numeric">0.2%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Most popular ecommerce platforms on desktop.",
      sheets_gid="1752605080",
      sql_file="top_ecommerce.sql",
    ) }}
  </figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>Platform</th>
        <th>% ecommerce sites</th>
        <th>% all sites</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>WooCommerce</td>
        <td class="numeric">44.4%</td>
        <td class="numeric">7.0%</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">25.3%</td>
        <td class="numeric">4.0%</td>
      </tr>
      <tr>
        <td>Wix eCommerce</td>
        <td class="numeric">11.1%</td>
        <td class="numeric">1.8%</td>
      </tr>
      <tr>
        <td>Squarespace Commerce</td>
        <td class="numeric">9.9%</td>
        <td class="numeric">1.6%</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">3.7%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>1C-Bitrix</td>
        <td class="numeric">3.3%</td>
        <td class="numeric">0.5%</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">2.2%</td>
        <td class="numeric">0.3%</td>
      </tr>
      <tr>
        <td>OpenCart</td>
        <td class="numeric">1.4%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>Tiendanube</td>
        <td class="numeric">1.0%</td>
        <td class="numeric">0.2%</td>
      </tr>
      <tr>
        <td>Square Online</td>
        <td class="numeric">0.9%</td>
        <td class="numeric">0.1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Most popular ecommerce platforms on mobile.",
      sheets_gid="1752605080",
      sql_file="top_ecommerce.sql",
    ) }}
  </figcaption>
</figure>

### Trends since 2024

If you zoom out to the last few years, the story is less about disruption and more about slow consolidation:

- WooCommerce remains the largest ecosystem, staying roughly flat (about 36% → 36% of ecommerce sites from 2024 to 2025).
- Shopify continues to gain share (about 20% → 21%).
- Wix eCommerce is the fastest climber in the top 5 (about 7% → 8%).
- PrestaShop continues to trend down in share (about 4% → 3%).

In other words: the default choices are getting more default, and smaller open‑source ecosystems are having to compete harder on developer experience, hosting simplicity, and performance out of the box.

### Top platforms by tier

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
        <th>All</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">1</td>
        <td>Amazon Webstore</td>
        <td>Amazon Webstore</td>
        <td>Shopify</td>
        <td>Shopify</td>
        <td>WooCommerce</td>
        <td>WooCommerce</td>
      </tr>
      <tr>
        <td class="numeric">2</td>
        <td>Magento</td>
        <td>Salesforce Commerce Cloud</td>
        <td>Magento</td>
        <td>WooCommerce</td>
        <td>Shopify</td>
        <td>Shopify</td>
      </tr>
      <tr>
        <td class="numeric">3</td>
        <td>Pattern by Etsy</td>
        <td>SAP Commerce Cloud</td>
        <td>Salesforce Commerce Cloud</td>
        <td>Magento</td>
        <td>Squarespace Commerce</td>
        <td>Squarespace Commerce</td>
      </tr>
      <tr>
        <td class="numeric">4</td>
        <td></td>
        <td>Magento</td>
        <td>Amazon Webstore</td>
        <td>PrestaShop</td>
        <td>PrestaShop</td>
        <td>Wix eCommerce</td>
      </tr>
      <tr>
        <td class="numeric">5</td>
        <td></td>
        <td>Shopify/td>
        <td>WooCommerce/td>
        <td>1C-Bitrix/td>
        <td>Wix eCommerce/td>
        <td>PrestaShop</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Top platforms by rank tier (desktop).",
      sheets_gid="301153684",
      sql_file="top_vendors_crux_rank.sql",
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
        <th>All</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="numeric">1</td>
        <td>Magento</td>
        <td>Amazon Webstore</td>
        <td>Shopify</td>
        <td>Shopify</td>
        <td>WooCommerce</td>
        <td>WooCommerce</td>
      </tr>
      <tr>
        <td class="numeric">2</td>
        <td>Amazon Webstore</td>
        <td>Salesforce Commerce Cloud</td>
        <td>Magento</td>
        <td>WooCommerce</td>
        <td>Shopify</td>
        <td>Shopify</td>
      </tr>
      <tr>
        <td class="numeric">3</td>
        <td>Pattern by Etsy</td>
        <td>SAP Commerce Cloud</td>
        <td>Salesforce Commerce Clous</td>
        <td>Magento</td>
        <td>Squarespace Commerce</td>
        <td>Wix eCommerce</td>
      </tr>
      <tr>
        <td class="numeric">4</td>
        <td></td>
        <td>Magento</td>
        <td>Amazon Webstore</td>
        <td>PrestaShop</td>
        <td>PrestaShop</td>
        <td>Squarespace Commerce</td>
      </tr>
      <tr>
        <td class="numeric">5</td>
        <td></td>
        <td>Shopify/td>
        <td>WooCommerce/td>
        <td>1C-Bitrix/td>
        <td>Wix eCommerce/td>
        <td>PrestaShop</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Top platforms by rank tier (mobile).",
      sheets_gid="301153684",
      sql_file="top_vendors_crux_rank.sql",
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
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRlrzXpWshCjsSpSxJnhK5A732UtlRUtWfbtSt39JlV1rbI1YRoA1fRLWUr05vJBKNsS-i7ReTMudhN/pubchart?oid=571594362&format=interactive",
  sheets_gid="2084734046",
  sql_file="top_shopsystem_by_geo.sql"
  )
}}

The three leading platforms take the top spot in most countries: WooCommerce (violet), Shopify (green), and 1C-Bitrix (red).

- On desktop, WooCommerce is the most common platform in 42 of 59 geographies in our country‑level view (excluding the ALL aggregate).
- On mobile, WooCommerce leads even more often: 71 of 89 (excluding the ALL aggregate).

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
  sheets_gid="755277706",
  sql_file="core_web_vitals_by_platform.sql"
  )
}}

{{ figure_markup(
  image="mobile-core-web-vitals-by-platform.png",
  caption="Mobile Core Web Vitals pass rate by platform in 2025.",
  description="Bar chart showing the share of mobile ecommerce origins with good Core Web Vitals across leading platforms in 2025.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSLJnACGZxfgmNdBbsBBCiMfyBd3l0dp4FWbyHkjZcwXVqMDWHzcEYmqsrr9XTQDye4NA4qSMFX9xZG/pubchart?oid=433690173&format=interactive",
  sheets_gid="755277706",
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
        <td class="numeric">394,462</td>
        <td class="numeric">45%</td>
        <td class="numeric">99%</td>
        <td class="numeric">68%</td>
        <td class="numeric">33%</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">289,885</td>
        <td class="numeric">92%</td>
        <td class="numeric">99%</td>
        <td class="numeric">82%</td>
        <td class="numeric">76%</td>
      </tr>
      <tr>
        <td>Squarespace Commerce</td>
        <td class="numeric">80,900</td>
        <td class="numeric">90%</td>
        <td class="numeric">100%</td>
        <td class="numeric">78%</td>
        <td class="numeric">69%</td>
      </tr>
      <tr>
        <td>Wix eCommerce</td>
        <td class="numeric">55,706</td>
        <td class="numeric">77%</td>
        <td class="numeric">99%</td>
        <td class="numeric">91%</td>
        <td class="numeric">70%</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">45,256</td>
        <td class="numeric">74%</td>
        <td class="numeric">99%</td>
        <td class="numeric">72%</td>
        <td class="numeric">54%</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">36,988</td>
        <td class="numeric">59%</td>
        <td class="numeric">99%</td>
        <td class="numeric">55%</td>
        <td class="numeric">36%</td>
      </tr>
      <tr>
        <td>1C-Bitrix</td>
        <td class="numeric">31,150</td>
        <td class="numeric">86%</td>
        <td class="numeric">99%</td>
        <td class="numeric">80%</td>
        <td class="numeric">68%</td>
      </tr>
      <tr>
        <td>OpenCart</td>
        <td class="numeric">14,452</td>
        <td class="numeric">87%</td>
        <td class="numeric">99%</td>
        <td class="numeric">80%</td>
        <td class="numeric">70%</td>
      </tr>
      <tr>
        <td>Cafe24</td>
        <td class="numeric">13,661</td>
        <td class="numeric">98%</td>
        <td class="numeric">100%</td>
        <td class="numeric">46%</td>
        <td class="numeric">45%</td>
      </tr>
      <tr>
        <td>BigCommerce</td>
        <td class="numeric">12,376</td>
        <td class="numeric">91%</td>
        <td class="numeric">99%</td>
        <td class="numeric">60%</td>
        <td class="numeric">55%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Top eCommerce platforms Core Web Vitals good rates (desktop).",
      sheets_gid="755277706",
      sql_file="core_web_vitals_by_platform.sql",
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
        <td class="numeric">995,782</td>
        <td class="numeric">39%</td>
        <td class="numeric">88%</td>
        <td class="numeric">85%</td>
        <td class="numeric">35%</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">567,932</td>
        <td class="numeric">86%</td>
        <td class="numeric">90%</td>
        <td class="numeric">92%</td>
        <td class="numeric">76%</td>
      </tr>
      <tr>
        <td>Wix eCommerce</td>
        <td class="numeric">234,055</td>
        <td class="numeric">76%</td>
        <td class="numeric">85%</td>
        <td class="numeric">95%</td>
        <td class="numeric">66%</td>
      </tr>
      <tr>
        <td>Squarespace Commerce</td>
        <td class="numeric">209,650</td>
        <td class="numeric">76%</td>
        <td class="numeric">96%</td>
        <td class="numeric">89%</td>
        <td class="numeric">69%</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">87,486</td>
        <td class="numeric">65%</td>
        <td class="numeric">89%</td>
        <td class="numeric">81%</td>
        <td class="numeric">50%</td>
      </tr>
      <tr>
        <td>1C-Bitrix</td>
        <td class="numeric">76,080</td>
        <td class="numeric">71%</td>
        <td class="numeric">71%</td>
        <td class="numeric">86%</td>
        <td class="numeric">50%</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">50,983</td>
        <td class="numeric">52%</td>
        <td class="numeric">87%</td>
        <td class="numeric">64%</td>
        <td class="numeric">35%</td>
      </tr>
      <tr>
        <td>OpenCart</td>
        <td class="numeric">32,914</td>
        <td class="numeric">80%</td>
        <td class="numeric">93%</td>
        <td class="numeric">88%</td>
        <td class="numeric">68%</td>
      </tr>
      <tr>
        <td>Tiendanube</td>
        <td class="numeric">21,836</td>
        <td class="numeric">60%</td>
        <td class="numeric">95%</td>
        <td class="numeric">84%</td>
        <td class="numeric">51%</td>
      </tr>
        <tr>
        <td>Square Online</td>
        <td class="numeric">18,812</td>
        <td>0%</td>
        <td class="numeric">39%</td>
        <td>0%</td>
        <td>0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Top eCommerce platforms Core Web Vitals good rates (mobile).",
      sheets_gid="755277706",
      sql_file="core_web_vitals_by_platform.sql",
    ) }}
  </figcaption>
</figure>

A few patterns show up repeatedly:

- INP is generally strong on desktop across most major platforms, suggesting that modern JS stacks and browser improvements are helping responsiveness.
- LCP is the biggest differentiator-platforms that ship fast themes and tightly controlled app ecosystems tend to score better.
- WooCommerce has scale, but not automatic speed: its CWV pass rates lag behind SaaS-heavy ecosystems, which is consistent with its infinite customization nature.

### Year-over-year movement

Looking at the largest platforms from 2024 → 2025, most ecosystems improved their "good" Core Web Vitals share, but the magnitude differs:

- Wix eCommerce sees the biggest jump (≈ 16% on mobile and 19% on desktop).
- Shopify also improves materially (≈ 8% mobile; 6% desktop).
- WooCommerce improves more modestly (≈ 5% mobile; 4% desktop).

This is the tradeoff you should expect: platforms that centralize more of the stack can deliver performance improvements to millions of stores at once. Platforms that decentralize responsibility (themes, plugins, hosting, agencies) tend to improve more slowly because the bottleneck is coordination.

## Lighthouse

Lighthouse is the HTTP Archive's lab-based audit. Unlike Core Web Vitals (field data), it runs in a controlled environment (simulated device, throttled network/CPU) and produces scores for Performance, Accessibility, SEO, and Best Practices:

- **Performance**: Lighthouse Performance is a lab score (0–100) summarizing load and responsiveness under a controlled test profile. It's most useful for relative comparisons across platforms.
- **Accessibility**: Lighthouse Accessibility is based on automated checks (it cannot catch everything), but it's a useful baseline signal for common issues like missing labels, low contrast, and incorrect semantics.
- **SEO**: The Lighthouse SEO score reflects technical SEO fundamentals (e.g., title/meta, basic crawlability signals). High medians are common because these checks are straightforward to pass.
- **Best Practices**: Best Practices is a grab bag of security and reliability checks (HTTPS, safe JS patterns, modern APIs). It often reflects platform defaults and theme quality.

Lighthouse is useful for comparisons across large sets of sites because it standardizes the test profile, but it won't perfectly match what real users experience since field data reflects the real mix of devices, networks, geographies, and user behavior.

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
        <td class="numeric">863,433</td>
        <td class="numeric">61</td>
        <td class="numeric">87</td>
        <td class="numeric">92</td>
        <td class="numeric">78</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">524,617</td>
        <td class="numeric">71</td>
        <td class="numeric">90</td>
        <td class="numeric">92</td>
        <td class="numeric">74</td>
      </tr>
      <tr>
        <td>Squarespace Commerce</td>
        <td class="numeric">223,365</td>
        <td class="numeric">65</td>
        <td class="numeric">94</td>
        <td class="numeric">92</td>
        <td class="numeric">96</td>
      </tr>
      <tr>
        <td>Wix eCommerce</td>
        <td class="numeric">191,039</td>
        <td class="numeric">88</td>
        <td class="numeric">96</td>
        <td class="numeric">100</td>
        <td class="numeric">78</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">77,374</td>
        <td class="numeric">59</td>
        <td class="numeric">78</td>
        <td class="numeric">92</td>
        <td class="numeric">81</td>
      </tr>
      <tr>
        <td>1C-Bitrix</td>
        <td class="numeric">56,914</td>
        <td class="numeric">58</td>
        <td class="numeric">75</td>
        <td class="numeric">92</td>
        <td class="numeric">59</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">50,058</td>
        <td class="numeric">60</td>
        <td class="numeric">78</td>
        <td class="numeric">92</td>
        <td class="numeric">74</td>
      </tr>
      <tr>
        <td>OpenCart</td>
        <td class="numeric">27,351</td>
        <td class="numeric">63</td>
        <td class="numeric">79</td>
        <td class="numeric">91</td>
        <td class="numeric">78</td>
      </tr>
      <tr>
        <td>Cafe24</td>
        <td class="numeric">24,052</td>
        <td class="numeric">39</td>
        <td class="numeric">69</td>
        <td class="numeric">85</td>
        <td class="numeric">56</td>
      </tr>
      <tr>
        <td>BigCommerce</td>
        <td class="numeric">18,465</td>
        <td class="numeric">72</td>
        <td class="numeric">81</td>
        <td class="numeric">92</td>
        <td class="numeric">74</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Most popular ecommerce platforms Lighthouse scores (desktop).",
      sheets_gid="1765174321",
      sql_file="median_lighthouse_score_ecommsites.sql",
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
        <td>1,084,792</td>
        <td class="numeric">38</td>
        <td class="numeric">87</td>
        <td class="numeric">92</td>
        <td class="numeric">79</td>
      </tr>
      <tr>
        <td>Shopify</td>
        <td class="numeric">618,929</td>
        <td class="numeric">55</td>
        <td class="numeric">91</td>
        <td class="numeric">92</td>
        <td class="numeric">75</td>
      </tr>
      <tr>
        <td>Wix eCommerce</td>
        <td class="numeric">270,436</td>
        <td class="numeric">64</td>
        <td class="numeric">95</td>
        <td class="numeric">100</td>
        <td class="numeric">79</td>
      </tr>
      <tr>
        <td>Squarespace Commerce</td>
        <td class="numeric">241,322</td>
        <td class="numeric">30</td>
        <td class="numeric">94</td>
        <td class="numeric">92</td>
        <td class="numeric">96</td>
      </tr>
      <tr>
        <td>PrestaShop</td>
        <td class="numeric">91,267</td>
        <td class="numeric">36</td>
        <td class="numeric">79</td>
        <td class="numeric">92</td>
        <td class="numeric">79</td>
      </tr>
      <tr>
        <td>1C-Bitrix</td>
        <td class="numeric">81,598</td>
        <td class="numeric">35</td>
        <td class="numeric">75</td>
        <td class="numeric">92</td>
        <td class="numeric">61</td>
      </tr>
      <tr>
        <td>Magento</td>
        <td class="numeric">52,885</td>
        <td class="numeric">34</td>
        <td class="numeric">79</td>
        <td class="numeric">92</td>
        <td class="numeric">75</td>
      </tr>
      <tr>
        <td>OpenCart</td>
        <td class="numeric">35,238</td>
        <td class="numeric">43</td>
        <td class="numeric">78</td>
        <td class="numeric">91</td>
        <td class="numeric">79</td>
      </tr>
      <tr>
        <td>Tiendanube</td>
        <td class="numeric">23,717</td>
        <td class="numeric">50</td>
        <td class="numeric">92</td>
        <td class="numeric">92</td>
        <td class="numeric">75</td>
      </tr>
      <tr>
        <td>Square Online</td>
        <td class="numeric">21,700</td>
        <td class="numeric">13</td>
        <td class="numeric">85</td>
        <td class="numeric">92</td>
        <td class="numeric">57</td>
      </tr>
      </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Most popular ecommerce platforms Lighthouse scores (mobile).",
      sheets_gid="1765174321",
      sql_file="median_lighthouse_score_ecommsites.sql",
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
  sheets_gid="2028626432",
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
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>PayPal</td>
        <td class="numeric">19.1%</td>
        <td class="numeric">4.1%</td>
      </tr>
      <tr>
        <td>Apple Pay</td>
        <td class="numeric">13.1%</td>
        <td class="numeric">2.8%</td>
      </tr>
      <tr>
        <td>Shop Pay</td>
        <td class="numeric">11.8%</td>
        <td class="numeric">2.5%</td>
      </tr>
      <tr>
        <td>Stripe</td>
        <td class="numeric">9.8%</td>
        <td class="numeric">2.1%</td>
      </tr>
      <tr>
        <td>Visa</td>
        <td class="numeric">9.6%</td>
        <td class="numeric">2.1%</td>
      </tr>
      <tr>
        <td>Mastercard</td>
        <td class="numeric">9.6%</td>
        <td class="numeric">2.1%</td>
      </tr>
      <tr>
        <td>American Express</td>
        <td class="numeric">8.7%</td>
        <td class="numeric">1.9%</td>
      </tr>
      <tr>
        <td>Google Pay</td>
        <td class="numeric">8.0%</td>
        <td class="numeric">1.7%</td>
      </tr>
      <tr>
        <td>Venmo</td>
        <td class="numeric">2.6%</td>
        <td class="numeric">0.6%</td>
      </tr>
      <tr>
        <td>Klarna Checkout</td>
        <td class="numeric">1.6%</td>
        <td class="numeric">0.4%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Top payment providers (desktop)).",
      sheets_gid="2028626432",
      sql_file="top_payment_providers.sql",
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
        <td class="numeric">19.2%</td>
        <td class="numeric">3.1%</td>
      </tr>
      <tr>
        <td>Apple Pay</td>
        <td class="numeric">12.9%</td>
        <td class="numeric">2.1%</td>
      </tr>
      <tr>
        <td>Shop Pay</td>
        <td class="numeric">11.5%</td>
        <td class="numeric">1.9%</td>
      </tr>
      <tr>
        <td>Visa</td>
        <td class="numeric">10.1%</td>
        <td class="numeric">1.7%</td>
      </tr>
      <tr>
        <td>Mastercard</td>
        <td class="numeric">10.1%</td>
        <td class="numeric">1.7%</td>
      </tr>
      <tr>
        <td>Stripe</td>
        <td class="numeric">9.3%</td>
        <td class="numeric">1.5%</td>
      </tr>
      <tr>
        <td>Google Pay</td>
        <td class="numeric">9.0%</td>
        <td class="numeric">1.5%</td>
      </tr>
      <tr>
        <td>American Express</td>
        <td class="numeric">9.0%</td>
        <td class="numeric">1.5%</td>
      </tr>
      <tr>
        <td>Venmo</td>
        <td class="numeric">2.2%</td>
        <td class="numeric">0.4%</td>
      </tr>
      <tr>
        <td>Klarna Checkout</td>
        <td class="numeric">1.6%</td>
        <td class="numeric">0.3%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Top payment providers (mobile)).",
      sheets_gid="2028626432",
      sql_file="top_payment_providers.sql",
    ) }}
  </figcaption>
</figure>

The top 10 payment technologies account for the bulk of payment detections on both devices-another reminder that payments consolidate quickly.

### What changed since 2022?

The most noticeable trend is that PayPal's share of payment detections declines, while wallets and processor‑first ecosystems grow:

- PayPal falls from ~39% of payment detections in 2022 to ~30% in 2025 (desktop and mobile both show this pattern).
- Stripe and Google Pay gain share over the same period.
- Apple Pay and Shop Pay stay relatively stable at high levels.

This does not mean PayPal is dying. It means the payment layer is becoming more diversified-especially as native wallets, link-based checkout, and platform-native accelerators become standard.

### Payment providers by geography

{{ figure_markup(
  caption="Countries in which PayPal is the top payment provider.",
  content="70 out of 83",
  classes="big-number",
  sheets_gid="732986771",
  sql_file="top_payment_by_geo.sql"
  )
}}

- On mobile, PayPal is the top payment provider in 70 of 83 geographies.
- On desktop, leadership is more split: Stripe leads in 31 geographies while PayPal leads in 22.

Notable examples:

- Apple Pay leads in New Zealand (both desktop and mobile).
- Braintree stands out in Taiwan.
- Several African and Middle Eastern markets show Stripe as the most common top provider in this dataset (e.g., Nigeria, Kenya, UAE).

## Conclusion

Ecommerce in 2025 remains both concentrated and diverse. A handful of platforms account for most detected ecommerce sites-led by WooCommerce and Shopify-while a long tail of regional and niche systems continues to matter in specific markets. Website rank adds another layer: enterprise-oriented platforms show up disproportionately in higher-traffic tiers, while long-tail sites skew toward easier-to-adopt and lower-cost solutions.

Performance remains a differentiator, not a footnote. Field metrics (Core Web Vitals) and lab audits (Lighthouse) both show that tighter platform control can correlate with better median outcomes, but the gap is not destiny-self-hosted and heavily customized stacks can perform well when engineering discipline is strong. Payment technologies also consolidate quickly: a small set of providers dominates detections, while wallets and processor-first ecosystems keep gaining share.

The next chapter of ecommerce is not just which platform, but which channels: voice, live commerce, and agentic commerce are pushing stores to become faster, more accessible, and more machine-consumable. The winners will be the ones who treat catalog quality, performance, and trust as product features-because increasingly, the shopper may not be a human clicking around a page at all.
