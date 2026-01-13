---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Ecommerce
description: This chapter explores trends in the ecommerce ecosystem, covering platform adoption, Core Web Vitals, Lighthouse metrics, payments, and regional differences. It highlights how platforms like WooCommerce and Shopify lead while newer players grow in specific markets.
hero_alt: Hero image of a Web Almanac character at a supermarket checkout loading items from a shopping basket onto the conveyor belt while another character pays with a credit card.
authors: [AmandeepSingh]
reviewers: [AmandeepSingh]
analysts: [AmandeepSingh]
editors: [AmandeepSingh]
translators: []
results: https://docs.google.com/spreadsheets/d/1tbbH4q4wzj4bpTj8ctRJ_8-NyS5KPBBcNInkemfxcR8
AmandeepSingh_bio: Amandeep Singh has been developing for the web since 2009 and writes about front end development, UI/UX, Shopify, BigCommerce, WordPress, and programming at <a hreflang="en" href="https://byaman.com/">byaman.com</a>. He is a writer, mentor, and speaker.
featured_quote: While ecommerce platforms are diverse and well distributed among different providers, a few key players dominate technologies like payment systems.
featured_stat_1: 19.8%
featured_stat_label_1: Percent of desktop sites that are ecommerce
featured_stat_2: 35.9%
featured_stat_label_2: Percent of desktop ecommerce sites built with WooCommerce
featured_stat_3: 3.9%
featured_stat_label_3: Percent of desktop sites offering PayPal as a payment method
doi: 10.5281/zenodo.14065664
---

## Introduction
Ecommerce is no longer a “special case” on the web-it *is* the web. In 2025, buying journeys start in search results, social feeds, and live streams; they continue in voice assistants, messaging apps, and “lean‑back” surfaces like smart TVs; and increasingly, they can be completed by AI agents acting on a shopper’s behalf. An ecommerce website is still an online store that sells physical or digital products, but it now sits at the intersection of product pages, payments, performance, accessibility, and trust.

When building an online store, there are a few common platform models:

1. **Software-as-a-Service (SaaS)** platforms (e.g., Shopify) minimize the technical knowledge required to run a store by controlling the codebase and abstracting hosting.
2. **Platform-as-a-Service (PaaS)** solutions (e.g., Adobe Commerce / Magento) provide an optimized technology stack and hosting environment while still allowing full code access.
3. **Self-hosted** platforms (e.g., WooCommerce, OpenCart) run on infrastructure managed by the merchant or their agency.
4. **Headless / API-first** platforms (e.g., commercetools, Medusa) provide the commerce backend as a service, while the merchant owns the frontend experience and hosting.
5. **Agentic commerce (agent-ready commerce)** layers sit alongside (or on top of) the storefront: structured product data, inventory, policies, identity, and payment flows exposed through APIs and standards so assistants and AI agents can safely discover products and execute purchases-with clear user consent and guardrails.

Platforms may fall into more than one category. For example, some vendors offer SaaS, PaaS, and self-hosted options, and many “headless” builds still rely on SaaS backends under the hood. The important variables are who controls hosting, who controls the runtime and upgrade path, and how much freedom you have to change the frontend and backend.

## Platform detection
We used an open‑source tool called **Wappalyzer** to detect technologies used by websites. It can detect ecommerce platforms, content management systems, JavaScript frameworks, analytics, and more.

For this analysis, we considered a site to be ecommerce if we detected either:

* Use of a known ecommerce platform, or
* Use of a technology that strongly implies an online store (for example, enhanced ecommerce analytics).

## Limitations
Our methodology has limitations that affect accuracy.

### Limitations in recognizing ecommerce sites
* We can only recognize ecommerce sites when Wappalyzer detects an ecommerce platform or a strong ecommerce signal.
* Detecting a payment processor alone (e.g., PayPal) is **not** sufficient to classify a site as ecommerce, because many non‑store sites also take payments.
* If the store is hosted in a subdirectory (and we only analyze the homepage), it may be missed.
* Headless implementations reduce platform detectability because the traditional “fingerprints” in HTML/JS often disappear.

### Accuracy of metrics and commentary
* Apparent trends can be influenced by improvements or regressions in detection, not just industry shifts.
* Crawl geography matters: results may differ when sites redirect based on location.
* The underlying site set is drawn from Chrome’s field data ecosystem, which biases toward sites visited by Chrome users.

## Top ecommerce platforms (updated with 2025 data)

{{ figure_markup(
  image="ecommerce-platforms-distribution.png",
  caption="Distribution of ecommerce platforms in 2025.",
  description="Pie chart showing the distribution of ecommerce platforms used in 2025. WooCommerce leads with about 36%, followed by Shopify at about 21%, then Squarespace Commerce at about 9% and Wix eCommerce at about 8%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSLJnACGZxfgmNdBbsBBCiMfyBd3l0dp4FWbyHkjZcwXVqMDWHzcEYmqsrr9XTQDye4NA4qSMFX9xZG/pubchart?oid=1786385507&format=interactive",
  sheets_gid="1000255969",
  sql_file="top_ecommerce.sql"
  )
}}

### Overall adoption
In the 2025 dataset, we detected **2,485,569** ecommerce sites on desktop and **2,966,560** on mobile. That corresponds to **19.8%** of all analyzed desktop sites and **19.1%** of all analyzed mobile sites.

That headline number is the first reminder that ecommerce is not just “a vertical”-it’s a major slice of what real users experience on the open web.


### Platform market share (share of ecommerce sites, 2025)
Across both desktop and mobile, the platform landscape remains top-heavy: a small set of systems account for the majority of detected stores, while a long tail of niche and regional platforms fills the rest.

#### Overall platform share
The tables below show the share of detected ecommerce sites **within ecommerce** (platform market share), and also how often each platform appears **across all sites** in the dataset.

**Desktop (top platforms, 2025)**
| Platform | Share of ecommerce sites | Share of all sites | Detected sites |
| --- | ---: | ---: | ---: |
| WooCommerce | 35.9% | 7.1% | 893,081 |
| Shopify | 21.2% | 4.2% | 526,567 |
| Squarespace Commerce | 9.1% | 1.8% | 227,292 |
| Wix eCommerce | 7.8% | 1.6% | 194,177 |
| PrestaShop | 3.2% | 0.6% | 79,850 |
| 1C-Bitrix | 2.4% | 0.5% | 58,832 |
| Magento | 2.0% | 0.4% | 50,872 |
| OpenCart | 1.1% | 0.2% | 28,007 |
| Cafe24 | 1.0% | 0.2% | 24,229 |
| BigCommerce | 0.7% | 0.1% | 18,216 |

**Mobile (top platforms, 2025)**
| Platform | Share of ecommerce sites | Share of all sites | Detected sites |
| --- | ---: | ---: | ---: |
| WooCommerce | 37.1% | 7.1% | 1,099,863 |
| Shopify | 20.6% | 3.9% | 612,387 |
| Wix eCommerce | 8.9% | 1.7% | 262,643 |
| Squarespace Commerce | 8.1% | 1.5% | 239,580 |
| PrestaShop | 3.1% | 0.6% | 92,484 |
| 1C-Bitrix | 2.8% | 0.5% | 82,394 |
| Magento | 1.8% | 0.3% | 53,179 |
| OpenCart | 1.2% | 0.2% | 35,493 |
| Tiendanube | 0.8% | 0.2% | 23,333 |
| Square Online | 0.7% | 0.1% | 20,942 |

### Trends 2022–2025 (top 5 platforms)
If you zoom out to the last few years, the story is less about disruption and more about **slow consolidation**:

* **WooCommerce** remains the largest ecosystem, staying roughly flat (about 37.2% → 35.9% of ecommerce sites from 2022 to 2025).
* **Shopify** continues to gain share (about 17.7% → 21.2%).
* **Wix eCommerce** is the fastest climber in the top 5 (about 4.5% → 7.8%).
* **PrestaShop** continues to trend down in share (about 4.6% → 3.2%).

In other words: the “default choices” are getting more default, and smaller open‑source ecosystems are having to compete harder on developer experience, hosting simplicity, and performance out of the box.

## Top ecommerce platforms by rank
A useful proxy for “where the big stores live” is to segment by site popularity. In general, the most popular sites are more likely to be professionally engineered, heavily optimized, and backed by larger budgets.

The table below shows how the **share of sites that are ecommerce** increases as we include less‑popular sites.

| Rank tier | Desktop ecommerce share | Mobile ecommerce share |
| --- | ---: | ---: |
| Top 1,000 | 1.7% | 1.4% |
| Top 10,000 | 3.7% | 3.2% |
| Top 100,000 | 7.8% | 6.9% |
| Top 1,000,000 | 17.0% | 15.5% |
| Top 10,000,000 | 21.3% | 20.7% |

The pattern is consistent:

* At the very top of the web (top 1,000), ecommerce is present but rare.
* By the time you reach the top 10 million, roughly **one in five** sites is an online store.


### Which platforms dominate each tier?
The “top platform” depends on the tier.

* In the very top ranks, enterprise and bespoke ecosystems show up more often.
* In the broader web, the long‑tail winners (especially WooCommerce) dominate by volume.

**Desktop: top platforms by popularity tier (2025)**

| Position | Top 1,000 | Top 10,000 | Top 100,000 | Top 1,000,000 | Top 10,000,000 |
| --- | --- | --- | --- | --- | --- |
| 1 | Magento | Salesforce Commerce Cloud | Shopify | Shopify | WooCommerce |
| 2 | Amazon Webstore | Fourthwall | Magento | WooCommerce | Shopify |
| 3 | Fourthwall | Amazon Webstore | Salesforce Commerce Cloud | Magento | Squarespace Commerce |
| 4 | HCL Commerce | Magento | WooCommerce | PrestaShop | PrestaShop |
| 5 | Pattern by Etsy | SAP Commerce Cloud | Amazon Webstore | 1C-Bitrix | Magento |

**Mobile: top platforms by popularity tier (2025)**

| Position | Top 1,000 | Top 10,000 | Top 100,000 | Top 1,000,000 | Top 10,000,000 |
| --- | --- | --- | --- | --- | --- |
| 1 | Magento | Salesforce Commerce Cloud | Shopify | Shopify | WooCommerce |
| 2 | Fourthwall | Fourthwall | Magento | WooCommerce | Shopify |
| 3 | HCL Commerce | Amazon Webstore | Salesforce Commerce Cloud | Magento | Squarespace Commerce |
| 4 | Amazon Webstore | Magento | WooCommerce | PrestaShop | PrestaShop |
| 5 | Pattern by Etsy | SAP Commerce Cloud | Amazon Webstore | 1C-Bitrix | Wix eCommerce |

## Top ecommerce platform by geography
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

* On **desktop**, **WooCommerce** is the most common platform in **43 of 63** geographies in our country‑level “most popular platform” view.
* On **mobile**, WooCommerce leads even more often: **74 of 95**.

There are also meaningful regional exceptions:

* **1C‑Bitrix** leads in parts of Eastern Europe and Central Asia (e.g., Russian Federation, Belarus, Kazakhstan, Kyrgyzstan).
* **Tiendanube** stands out in **Argentina**.
* **Shoptet** appears as a leader in **Czechia**.
* **Cafe24** leads in **South Korea**.
* **Salla** shows up strongly in **Saudi Arabia**.

## Core Web Vitals in ecommerce
Ecommerce sites are unusually sensitive to performance because every extra second compounds: slower category pages reduce product views; slower product pages reduce add‑to‑carts; slower checkout flows reduce conversion.

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

We use Core Web Vitals (CWV) field metrics to summarize real‑user experience:

* **LCP (Largest Contentful Paint):** loading performance.
* **INP (Interaction to Next Paint):** responsiveness.
* **CLS (Cumulative Layout Shift):** visual stability.

A site is considered “good” on CWV when it passes all three thresholds.

### Largest Contentful Paint (LCP)
LCP is a loading metric: it captures how quickly the main content becomes visible. In ecommerce, it often maps to hero imagery, product grids, and critical CSS/JS that blocks rendering.

### Cumulative Layout Shift (CLS)
CLS measures visual stability-how much content shifts as the page loads. It’s especially relevant to ecommerce because late-loading product images, personalization widgets, and promo banners can cause mis-clicks.

### Interaction to Next Paint (INP)
INP measures responsiveness, capturing the delay between a user action (tap/click) and the next visual update. It is sensitive to heavy JavaScript, third-party tags, and main-thread contention.

### CWV by platform (top origins)
**Desktop (2025, top platforms by origin count)**
| Platform | Origins | Good LCP | Good INP | Good CLS | Good CWV |
| --- | ---: | ---: | ---: | ---: | ---: |
| WooCommerce | 401,579 | 45.5% | 99.3% | 67.7% | 33.5% |
| Shopify | 286,618 | 92.5% | 99.3% | 82.2% | 75.9% |
| Squarespace Commerce | 82,393 | 90.3% | 99.7% | 77.6% | 69.3% |
| Wix eCommerce | 56,104 | 76.0% | 99.4% | 90.4% | 68.8% |
| PrestaShop | 46,479 | 74.5% | 98.6% | 71.1% | 53.7% |
| Magento | 37,153 | 60.0% | 99.0% | 55.3% | 36.6% |
| 1C-Bitrix | 31,699 | 85.9% | 99.4% | 79.9% | 68.2% |
| OpenCart | 14,476 | 86.6% | 99.1% | 80.0% | 70.3% |
| Cafe24 | 13,557 | 98.3% | 97.6% | 47.4% | 45.8% |
| BigCommerce | 12,133 | 91.5% | 99.4% | 59.5% | 55.2% |

**Mobile (2025, top platforms by origin count)**
| Platform | Origins | Good LCP | Good INP | Good CLS | Good CWV |
| --- | ---: | ---: | ---: | ---: | ---: |
| WooCommerce | 991,835 | 39.2% | 87.2% | 83.1% | 33.9% |
| Shopify | 554,518 | 85.8% | 89.3% | 91.1% | 74.4% |
| Wix eCommerce | 225,691 | 73.4% | 84.7% | 94.1% | 63.8% |
| Squarespace Commerce | 205,743 | 75.2% | 95.9% | 88.2% | 68.0% |
| PrestaShop | 87,404 | 64.6% | 88.6% | 73.1% | 44.2% |
| 1C-Bitrix | 75,601 | 69.8% | 69.9% | 81.7% | 45.7% |
| Magento | 50,654 | 51.4% | 86.3% | 53.7% | 28.9% |
| OpenCart | 32,544 | 79.4% | 92.2% | 86.6% | 66.2% |
| Tiendanube | 21,235 | 48.2% | 94.6% | 81.9% | 39.7% |
| Square Online | 17,910 | 0.1% | 38.6% | 0.2% | 0.0% |

A few patterns show up repeatedly:

* **INP is generally strong on desktop** across most major platforms, suggesting that modern JS stacks and browser improvements are helping responsiveness.
* **LCP is the biggest differentiator**-platforms that ship fast themes and tightly controlled app ecosystems tend to score better.
* **WooCommerce has scale, but not automatic speed**: its CWV pass rates lag behind SaaS-heavy ecosystems, which is consistent with its “infinite customization” nature.

### Year-over-year movement
Looking at the largest platforms from 2024 → 2025, most ecosystems improved their “good CWV” share, but the magnitude differs:

* **Wix eCommerce** sees the biggest jump (≈ 16.2% on mobile and 18.8% on desktop).
* **Shopify** also improves materially (≈ 7.9% mobile; 5.8% desktop).
* **WooCommerce** improves more modestly (≈ 4.9% mobile; 4.1% desktop).

This is the tradeoff you should expect: platforms that centralize more of the stack can deliver performance improvements to millions of stores at once. Platforms that decentralize responsibility (themes, plugins, hosting, agencies) tend to improve more slowly because the bottleneck is coordination.

## Lighthouse
Lighthouse is the HTTP Archive’s lab-based audit. Unlike Core Web Vitals (field data), it runs in a controlled environment (simulated device, throttled network/CPU) and produces scores for Performance, Accessibility, SEO, and Best Practices.

This makes Lighthouse useful for *comparisons* across large sets of sites, but it won’t perfectly match what real users experience.

### Performance
Lighthouse Performance is a lab score (0–100) summarizing load and responsiveness under a controlled test profile. It’s most useful for *relative* comparisons across platforms.

### Accessibility
Lighthouse Accessibility is based on automated checks (it cannot catch everything), but it’s a useful baseline signal for common issues like missing labels, low contrast, and incorrect semantics.

### SEO
The Lighthouse SEO score reflects technical SEO fundamentals (e.g., title/meta, basic crawlability signals). High medians are common because these checks are straightforward to pass.

### Best Practices
Best Practices is a grab bag of security and reliability checks (HTTPS, safe JS patterns, modern APIs). It often reflects platform defaults and theme quality.

### Median Lighthouse scores by platform (2025)

**Desktop (top platforms by test count)**
| Platform | Sites tested | Performance (median) | Accessibility (median) | SEO (median) | Best Practices (median) |
| --- | --- | --- | --- | --- | --- |
| WooCommerce | 886,516 | 56 | 85 | 92 | 78 |
| Shopify | 486,573 | 71 | 88 | 92 | 78 |
| Squarespace Commerce | 227,616 | 60 | 93 | 92 | 100 |
| Wix eCommerce | 175,056 | 82 | 95 | 100 | 78 |
| PrestaShop | 87,551 | 53 | 78 | 92 | 78 |
| 1C-Bitrix | 61,876 | 51 | 75 | 92 | 56 |
| Magento | 58,287 | 55 | 76 | 91 | 74 |
| OpenCart | 26,934 | 56 | 79 | 91 | 78 |
| Cafe24 | 22,221 | 34 | 71 | 85 | 56 |
| BigCommerce | 20,120 | 64 | 79 | 92 | 74 |

**Mobile (top platforms by test count)**
| Platform | Sites tested | Performance (median) | Accessibility (median) | SEO (median) | Best Practices (median) |
| --- | --- | --- | --- | --- | --- |
| WooCommerce | 1,116,462 | 32 | 85 | 92 | 79 |
| Shopify | 573,370 | 43 | 88 | 92 | 79 |
| Wix eCommerce | 250,295 | 52 | 95 | 100 | 79 |
| Squarespace Commerce | 243,490 | 30 | 94 | 92 | 96 |
| PrestaShop | 103,104 | 30 | 79 | 92 | 79 |
| 1C-Bitrix | 90,214 | 33 | 75 | 92 | 57 |
| Magento | 61,633 | 31 | 77 | 91 | 75 |
| OpenCart | 35,585 | 35 | 77 | 91 | 79 |
| Mercado Shops | 24,413 | 36 | 86 | 92 | 96 |
| Tiendanube | 23,106 | 58 | 93 | 92 | 75 |

A few high-level patterns:

* **SaaS storefronts tend to cluster higher on Performance** (especially on desktop), consistent with tighter control over themes and defaults.
* **Accessibility medians are generally strong** across top platforms, but medians can hide long-tail variance.
* **SEO and Best Practices are high for most platforms**-where teams usually win or lose is performance and implementation discipline, not basic technical SEO.

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

The tables below show the most commonly detected payment providers in 2025.

**Desktop (2025, top payment providers)**
| Payment provider | Share of payment detections | Share of all sites | Detected sites |
| --- | ---: | ---: | ---: |
| PayPal | 18.6% | 3.9% | 485,370 |
| Apple Pay | 13.4% | 2.8% | 350,570 |
| Shop Pay | 12.1% | 2.5% | 316,918 |
| Visa | 10.3% | 2.1% | 268,465 |
| Mastercard | 10.3% | 2.1% | 268,295 |
| American Express | 9.2% | 1.9% | 240,071 |
| Stripe | 8.6% | 1.8% | 225,053 |
| Google Pay | 8.3% | 1.7% | 218,246 |
| Venmo | 2.5% | 0.5% | 65,331 |
| Klarna Checkout | 1.2% | 0.2% | 30,852 |

**Mobile (2025, top payment providers)**
| Payment provider | Share of payment detections | Share of all sites | Detected sites |
| --- | ---: | ---: | ---: |
| PayPal | 18.8% | 3.5% | 548,276 |
| Apple Pay | 13.4% | 2.5% | 390,665 |
| Shop Pay | 11.9% | 2.2% | 348,267 |
| Visa | 10.6% | 2.0% | 309,054 |
| Mastercard | 10.6% | 2.0% | 308,874 |
| American Express | 9.4% | 1.8% | 273,942 |
| Google Pay | 8.6% | 1.6% | 250,089 |
| Stripe | 7.9% | 1.5% | 230,914 |
| Venmo | 2.3% | 0.4% | 68,549 |
| Klarna Checkout | 1.3% | 0.2% | 38,175 |

The top 10 payment technologies cover roughly **94.4%** of detections on desktop and **94.7%** on mobile-another reminder that payments consolidate quickly.

### What changed since 2022?
The most noticeable trend is that **PayPal’s share of payment detections declines**, while wallets and processor‑first ecosystems grow:

* PayPal falls from ~39% of payment detections in 2022 to ~30% in 2025 (desktop and mobile both show this pattern).
* Stripe and Google Pay gain share over the same period.
* Apple Pay and Shop Pay stay relatively stable at high levels.

This does not mean PayPal is “dying.” It means the payment layer is becoming more diversified-especially as native wallets, link-based checkout, and platform-native accelerators become standard.

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

* On **mobile**, **PayPal** is the top payment provider in **70 of 83** geographies in our view.
* On **desktop**, leadership is more split: **Stripe** leads in **31** geographies while **PayPal** leads in **22**.

Notable examples:

* **Apple Pay** leads in **New Zealand** (both desktop and mobile).
* **Braintree** stands out in **Taiwan**.
* Several African and Middle Eastern markets show Stripe as the most common top provider in this dataset (e.g., Nigeria, Kenya, UAE).

## Conclusion
Ecommerce in 2025 remains both **concentrated and diverse**. A handful of platforms account for most detected ecommerce sites-led by WooCommerce and Shopify-while a long tail of regional and niche systems continues to matter in specific markets. Website rank adds another layer: enterprise-oriented platforms show up disproportionately in higher-traffic tiers, while long-tail sites skew toward easier-to-adopt and lower-cost solutions.

Performance remains a differentiator, not a footnote. Field metrics (Core Web Vitals) and lab audits (Lighthouse) both show that tighter platform control can correlate with better median outcomes, but the gap is not destiny-self-hosted and heavily customized stacks can perform well when engineering discipline is strong. Payment technologies also consolidate quickly: a small set of providers dominates detections, while wallets and processor-first ecosystems keep gaining share.

The next chapter of ecommerce is not just “which platform,” but **which channels**: voice, live commerce, and agentic commerce are pushing stores to become faster, more accessible, and more machine-consumable. The winners will be the ones who treat catalog quality, performance, and trust as product features-because increasingly, the shopper may not be a human clicking around a page at all.
