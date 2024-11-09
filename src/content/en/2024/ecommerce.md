---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Ecommerce
description: This chapter explores trends in the ecommerce ecosystem, examining platform popularity, performance metrics, and regional differences. Covering Core Web Vitals, Lighthouse scores, and accessibility, it highlights how platforms like WooCommerce and Shopify dominate, while newer players gain traction in specific regions and niches.
authors: [JonathanPagel]
reviewers: [nrllh]
analysts: [JonathanPagel]
editors: [tunetheweb]
translators: []
results: https://docs.google.com/spreadsheets/d/1LABlisQFCLjOyEd43tdUb-Hxs6pGuboTresntMk71Lc/edit?gid=1075995078#gid=1075995078
JonathanPagel_bio: Jonathan Pagel studied ecommerce in his bachelor's degree and has since been interested in the field, particularly in the areas of speed optimization and accessibility for shops and websites. Currently, he is freelancing in this field and pursuing a Master’s in AI and Society.
featured_quote: TODO
featured_stat_1: 37%
featured_stat_label_1: Of websites using ecommerce platforms, 37% are built with WooCommerce, the most popular platform.
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
---

## Introduction

In this chapter, we review the state of ecommerce on the web. An eCommerce website is an "online store" that sells physical or digital products. When building your online store, there are several types of platforms to choose from:

1. **Software-as-a-Service (SaaS)** platforms like Shopify minimize the technical knowledge required to open and manage an online store. They do this by restricting access to the codebase and removing the need to worry about hosting.
2. **Platform-as-a-Service (PaaS)** solutions, such as Adobe Commerce (Magento), provide an optimized technology stack and hosting environment while allowing full codebase access.
3. **Self-hosted platforms**, such as WooCommerce.
4. **Headless platforms**, like CommerceTools, that are "API-as-a-service." They provide the ecommerce backend as a SaaS, while the retailer is responsible for building and hosting the frontend experience.

Note that some platforms may fall into more than one of these categories. For example, Shopware offers SaaS, PaaS, and self-hosted options.

Our goal is to give an overview of the current state of the ecommerce ecosystem as well as its development in the last year. The first part focuses on ranking the platforms based on their usage and Core Web Vitals/Lighthouse performance results. The second part is more experimental. We checked different eCom technologies and how they have evolved over time.

## Platform Detection

We used an open-source tool called [Wappalyzer](https://www.wappalyzer.com/) to detect technologies used by websites. Wappalyzer can identify content management systems, ecommerce platforms, JavaScript frameworks and libraries, and more.

## Limitations

Our methodology has some limitations that may affect its accuracy.

### Limitations in Recognizing ecommerce Sites

Firstly, there are some limitations to our ability to recognize an ecommerce site:

* Wappalyzer must have detected an ecommerce platform.
* If the ecommerce platform is hosted within a subdirectory of the website, it cannot be detected since only home pages are analyzed.
* A headless implementation reduces our ability to detect the platform in use. One of the primary methods to identify an ecommerce platform is by recognizing standard HTML or JavaScript components. Therefore, a headless website that does not use the ecommerce platform front end makes it challenging to detect.

### Accuracy of Metrics and Commentary

The accuracy of metrics and commentary may also be affected by the following limitations:

* Trends observed may be influenced by changes in detection accuracy rather than reflecting industry trends. For example, an ecommerce platform may appear to become more popular simply because the detection method has improved.
* All website requests were made from the United States. If a website redirects based on geographic location, the final version analyzed will be the U.S.-specific one.
* We used the [Chrome UX Report](https://developer.chrome.com/docs/crux) dataset, which includes only data from real-world Chrome sessions, not representing the user experience across all browsers.

## Top ecommerce Platforms Over The Years

In total, we detected nearly 2.5 million websites built on ecommerce platforms in 2024, representing approximately 20% of all the websites analyzed. The most widely used ecommerce platform is WooCommerce, followed by Shopify and Squarespace.

WooCommerce (38%) and Shopify (18%) dominate the ecommerce platform landscape. OpenCart is the last of the 362 detected shop systems that manage to secure a share above 1% of the market.

{{ figure_markup(
  image="ecommerce-platforms-distribution.png",
  caption="Distribution of Ecommerce platforms.",
  description="Pie chart showing the distribution of ecommerce platforms used in 2024. WooCommerce leads with 36.7%, followed by Shopify with 18.3%, Squarespace Commerce with 9.0%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=2506095&format=interactive",
  sheets_gid="1000255969",
  sql_file="top_ecommerce.sql"
  )
}}

Over the years, the top five platforms have remained relatively consistent. However, Wix eCommerce surpassed PrestaShop in 2023, moving from 5th to 4th place. Trends indicate that the open-source project WooCommerce is slightly losing market share, decreasing from 37.3% in 2022 to 35.8% in 2024, while its commercial competitor, Shopify, is gaining market share in the same period (increasing from 17.7% to 19.6%).
{{ figure_markup(
  image="top-5-platforms-2021-2024.png",
  caption="Top 5 Ecommerce Platforms from 2021 until 2024.",
  description="Line chart showing the top 5 ecommerce platforms from 2021 to 2024. WooCommerce remains the most popular platform, followed by Shopify, Squarespace Commerce, PrestaShop, and Wix eCommerce. The chart shows minor fluctuations in platform popularity over the years, with WooCommerce consistently above 35% and Shopify around 18-19%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=91913395&format=interactive",
  sheets_gid="1000255969",
  sql_file="top_ecommerce.sql"
  )
}}

## Top ecommerce platforms by popularity

Using the Chrome User Experience Report data, we looked at how popular individual websites are. Our data shows that only a few ecommerce platforms are represented in the top 1,000 websites, while about 20% of the top 10 million websites use an ecommerce platform. This difference could be because the top 1,000 sites often use custom solutions.
{{ figure_markup(
  image="platform-adoption-by-rank.png",
  caption="Platform adoption by rank for desktop and mobile.",
  description="Bar chart displaying platform adoption rates by website rank for desktop and mobile devices in 2024. Adoption increases with rank, with 1.74% adoption at 1,000 rank, 3.74% at 10,000, 7.82% at 100,000, 16.99% at 1,000,000, and 21.30% at 10,000,000 for both desktop and mobile, highlighting broader adoption among higher-ranked sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=2037087785&format=interactive",
  sheets_gid="1407431623",
  sql_file="top_vendors_crux_rank.sql"
  )
}}
Compared to the overall web, there are noticeable differences in platform popularity among the top 10 million websites. For instance, Wix eCommerce loses its position in the top five platforms, while Magento joins the top five. In the top one million sites, Shopify overtakes WooCommerce as the most popular platform, while Squarespace and Wix eCommerce fall out of the top five and below the top 20\.

In the top 100,000 websites, Salesforce Commerce Cloud and Amazon Webstore emerge among the most used platforms, with Shopify still holding the number one spot. Finally, in the top 10,000 websites, none of the previously leading platforms are represented in the top five, which are instead dominated by commercial solutions such as Fourthwall, SAP, and Salesforce Commerce Cloud.

| Position | 10,000 | 100,000 | 1,000,000 | 10,000,000 |
| ----- | ----- | ----- | ----- | ----- |
| 1 | Salesforce Commerce Cloud | Shopify | Shopify | WooCommerce |
| 2 | Fourthwall | Magento | WooCommerce | Shopify |
| 3 | Amazon Webstore | Salesforce Commerce Cloud | Magento | Squarespace Commerce |
| 4 | Magento | WooCommerce | PrestaShop | PrestaShop |
| 5 | SAP Commerce Cloud | Amazon Webstore | 1C-Bitrix | Magento |

## Top ecommerce platform by country

There are quite a few differences in preferences between countries. We used additional data from the CrUX dataset, which categorizes the most visited websites per country. For example, google.com, while an American website, is also one of the most visited websites by all German internet users. We can see that three leading platforms take the top spot in each country: WooCommerce (violet), Shopify (green), and 1C-Bitrix (red). The following map visualizes only these three due to the limitations of Google Sheets.
{{ figure_markup(
  image="top-ecommerce-platform-by-country.png",
  caption="Top ecommerce Platform by Country.",
  description="Map showing the top ecommerce platforms by country based on popularity. The map highlights three platforms: WooCommerce (in violet), Shopify (in green), and 1C-Bitrix (in red). The data, sourced from the CrUX dataset, reveals regional preferences, with WooCommerce leading in the Americas and parts of Europe, Shopify popular in a few regions, and 1C-Bitrix dominating in Russia and nearby countries.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=826337660&format=interactive",
  sheets_gid="1132201023",
  sql_file="top_shopsystem_by_geo.sql"
  )
}}

## Core Web Vitals in ecommerce

Google's Core Web Vitals are three key performance metrics designed to evaluate crucial aspects of user experience, focusing on loading speed, interactivity, and visual stability.
Introduced in 2020 and adopted as a ranking signal in 2021, those metrics, among many others, determine how high a page is ranking in the Google search results.

Here's the percentage of sites on each platform that achieve a "good" score, meaning they meet the performance thresholds for all three Core Web Vitals: LCP (Largest Contentful Paint) under 2.5 seconds, INP (Interaction to Next Paint) under 200 milliseconds, and CLS (Cumulative Layout Shift) below 0.1.

* **LCP under 2.5 seconds**: This measures how long it takes for the largest visible element on the page to load. Achieving this threshold ensures users can view the main content quickly without excessive delays.
* **INP under 200 milliseconds**: This measures the time from a user's interaction (such as a click or tap) to the browser updating (or painting) the screen. A score under 200 milliseconds means the page is highly responsive and provides a smooth user experience.
* **CLS below 0.1**: This tracks the visual stability of the page by measuring how much elements move unexpectedly as they load. A score below 0.1 indicates minimal shifts, ensuring a more stable visual experience for use.

{{ figure_markup(
  image="mobile-core-web-vitals-performance.png",
  caption="Mobile year-over-year Core Web Vitals performance per platform.",
  description="Bar chart illustrating the year-over-year performance of Core Web Vitals for mobile across various ecommerce platforms from 2022 to 2024. The chart highlights improvement trends across platforms such as WooCommerce, Shopify, Squarespace Commerce, and others, with increasing percentages of mobile websites meeting good Core Web Vitals standards over the years.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=218915083&format=interactive",
  sheets_gid="871753253",
  sql_file="core_web_vitals_yoy.sql"
  )
}}

Some platforms made impressive improvements, like Squarespace, which increased from 33% good scores in 2022 to 60% in 2024\. Other platforms, like Magento and WooCommerce, are still struggling with real-world user experiences. This chart, and the other charts of this section, consider mobile performance only since most web traffic comes from mobile, and it’s more challenging to reach top scores.

#### Largest Contentful Paint (LCP)

Largest Contentful Paint (LCP) measures how long it takes for the main content of a webpage to load and become visible to users. It specifically tracks the loading time of the largest element on the screen, like a big image or a block of text, which makes it a good indicator of how quickly users can see something meaningful on your page.

A good LCP time should be under 2.5 seconds. If it takes too long, it can make the website feel slow, and users might leave. To improve LCP, you can optimize images, make server responses faster, and minimize blocking scripts so that key content shows up more quickly.

Despite these challenges, the top 10 eCommerce platforms have shown significant year-over-year improvements in their LCP scores. Platforms like Shopify, OpenCart, and Shopware have consistently had good LCP pass rates since 2022, while Tiendanube, a popular platform in Argentina, made impressive progress, increasing its pass rate from 28% in 2022 to 61% in 2024\. On the other hand, WooCommerce lags behind with a pass rate of just 34%.

{{ figure_markup(
  image="mobile-lcp-performance.png",
  caption="Mobile year-over-year Platform LCP performance.",
  description="Bar chart displaying the year-over-year performance for Largest Contentful Paint (LCP) on mobile devices across various ecommerce platforms from 2022 to 2024. The chart illustrates progressive improvement in the percentage of mobile websites achieving good LCP scores for platforms including WooCommerce, Shopify, Squarespace Commerce, and others, indicating enhanced load performance over the years.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=523370223&format=interactive",
  sheets_gid="871753253",
  sql_file="core_web_vitals_yoy.sql"
  )
}}

#### Cumulative Layout Shift (CLS)

Cumulative Layout Shift (CLS) measures how stable the layout of a page is by tracking how much content unexpectedly shifts as the page loads. A good CLS score means that 75% or more of a website's visits register a score of 0.1 or lower, indicating a stable, user-friendly experience.

{{ figure_markup(
  image="mobile-cls-performance.png",
  caption="Mobile year-over-year Platform CLS performance.",
  description="Bar chart showcasing the year-over-year performance for Cumulative Layout Shift (CLS) on mobile across various ecommerce platforms from 2022 to 2024. This chart highlights improvement trends in the percentage of mobile websites meeting good CLS scores for platforms such as WooCommerce, Shopify, Squarespace Commerce, Wix eCommerce, and others, reflecting increased stability and reduced layout shifts over time.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=1657299227&format=interactive",
  sheets_gid="871753253",
  sql_file="core_web_vitals_yoy.sql"
  )
}}

In comparison to LCP, improvements in CLS have been less dramatic. Many platforms have only made modest progress, with Magento struggling more than others. WooCommerce, while facing challenges in other metrics, performs exceptionally well in CLS, similar to many other platforms.

#### Interaction to Next Paint (INP)

INP captures the time taken from the moment a user interacts with a page (e.g., clicking a button) to when the browser visually responds to that interaction. A good [INP score is 200 milliseconds or less](https://web.dev/articles/inp), which ensures a smooth and responsive experience.

{{ figure_markup(
  image="mobile-inp-performance.png",
  caption="Mobile year-over-year Platform INP performance.",
  description="Bar chart illustrating the year-over-year performance for Interaction to Next Paint (INP) on mobile across various ecommerce platforms from 2022 to 2024. The chart shows improvement trends in the percentage of mobile websites achieving good INP scores for platforms including WooCommerce, Shopify, Squarespace Commerce, and others, reflecting enhanced interactivity and response times over time.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=596833810&format=interactive",
  sheets_gid="871753253",
  sql_file="core_web_vitals_yoy.sql"
  )
}}

While most platforms have improved their INP scores, some still lag behind, including Magento and BigCommerce, with pass rates of 49% and 67%, respectively. However, most platforms have a pass rate above 75%, indicating substantial progress across the industry.

## Lighthouse

[Lighthouse](https://developers.google.com/web/tools/lighthouse/) is an open-source, automated tool for auditing web page quality. It provides metrics and reports on aspects like performance, accessibility, best practices, and search engine optimization (SEO).

It generates reports with lab data that offer developers actionable suggestions for enhancing websites. However, it's important to note that Lighthouse scores do not directly impact the real-world field data collected by [CrUX](https://developers.google.com/web/tools/chrome-user-experience-report).  The HTTP Archive runs Lighthouse on mobile and desktop web pages, simulating a [slow 4G connection with throttled CPU performance](https://almanac.httparchive.org/en/2022/methodology#lighthouse). Lighthouse Performance is a lab-based assessment of website performance tailored to specific test profiles for desktop and mobile users. To better understand the differences between both metrics, refer t[o this article](https://web.dev/articles/lab-and-field-data-differences).

While Core Web Vitals offer real-world data, they provide a limited set of metrics. Lighthouse, on the other hand, gives us lab data for a wide variety of metrics. You can also run a Lighthouse test for this page using Chrome DevTools. In the following section, we focus on ecommerce systems that were detected more than 50,000 times to emphasize the systems people commonly use and recognize in our charts. However, the complete data is available in the sheets, and for exceptional cases, we also mention smaller shop systems.

### Performance

The Lighthouse [performance score](https://web.dev/performance-scoring/) is a metric that summarizes the overall performance of a web page, mainly focusing on how quickly and smoothly it loads and becomes usable for visitors. This score ranges from 0 to 100, where higher scores indicate better performance.

The Lighthouse performance score is a weighted average of the five metric scores—First Contentful Paint (10%), Speed Index (10%), Largest Contentful Paint (25%), Total Blocking Time (30%), Cumulative Layout Shift (25%).

We can see that Wix eCommerce performs very well on both desktop and mobile compared to other systems. This is surprising, as the ranking data shows that it is primarily used for websites outside the top 10 million, which are likely less professional stores. This performance could also be due to the limited customization options compared to open-source systems like WooCommerce.

{{ figure_markup(
  image="median-lighthouse-performance-score.png",
  caption="Median Lighthouse performance score for various ecommerce platforms on desktop and mobile.",
  description="Bar chart comparing the median Lighthouse performance scores across different ecommerce platforms for desktop and mobile devices in 2024.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=31552374&format=interactive",
  sheets_gid="1875368844",
  sql_file="median_lighthouse_score_ecommsites.sql"
  )
}}

If we lower the threshold to platforms that appear at least 5,000 times instead of 50,000 times, Gumroad scores very well, with a median score of 87 on desktop and 59 on mobile. Additionally, Argentina's most popular shop system, Tiendanube, also scores well, with 74 on desktop and 58 on mobile.

### Accessibility

Accessibility is an increasingly important topic, not just for moral reasons but also for legal reasons. Lighthouse uses the [Axe framework](https://github.com/dequelabs/axe-core/blob/develop/doc/rule-descriptions.md) to determine the accessibility score. The accessibility score shows how easy it is for everyone, including people with disabilities, to use your website. The score ranges from 0 to 100, with a higher number meaning the website is easier for more people to use.

The score is based on a series of tests. For example, it checks if images have descriptions for people using screen readers and if buttons are clearly labeled. It also looks for issues like proper use of headings and good color contrast to ensure the website is understandable and easy to navigate. We also have an entire chapter dedicated to accessibility that goes into more detail.

It's important to note that a good accessibility score does not necessarily mean the website is fully accessible, as many problems cannot be detected by automated tools. For example, an incorrect description of an image is an issue, but Lighthouse won't flag it.

{{ figure_markup(
  image="median-lighthouse-accessibility-score.png",
  caption="Median Lighthouse accessibility score for various ecommerce platforms on desktop and mobile.",
  description="Bar chart showing median Lighthouse accessibility scores across ecommerce platforms on desktop and mobile in 2024. Squarespace Commerce, Wix eCommerce, and WooCommerce have high scores, indicating strong accessibility efforts. Shopify also scores well, while PrestaShop, Magento, and 1C-Bitrix have slightly lower scores, but still perform reasonably.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=1033635068&format=interactive",
  sheets_gid="1875368844",
  sql_file="median_lighthouse_score_ecommsites.sql"
  )
}}

The commercial platforms Wix, Squarespace, and Shopify perform well, while none of the systems have a notable bad result.

### SEO

The Lighthouse SEO score shows how well a website is set up to be found by search engines like Google. The score ranges from 0 to 100, with a higher score meaning a site is better optimized for search engines, which helps more people find it. The test checks for meta description, title, and correct headings structure.

{{ figure_markup(
  image="median-lighthouse-seo-score.png",
  caption="Median Lighthouse SEO score for various ecommerce platforms on desktop and mobile.",
  description="Bar chart displaying median Lighthouse SEO scores across ecommerce platforms on both desktop and mobile devices in 2024. Most platforms, including Squarespace Commerce, WooCommerce, and Shopify, consistently achieve high SEO scores, reflecting strong SEO practices across the industry. Wix eCommerce scores a perfect 100 for mobile and desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=2064035544&format=interactive",
  sheets_gid="1875368844",
  sql_file="median_lighthouse_score_ecommsites.sql"
  )
}}

The importance of SEO is reflected in the lighthouse results since most platforms score really well, led by Wix, which has a perfect median score of 100\.

### Best practices

The Best practices score shows how well your website follows general rules for good web development, focusing on making the site secure and reliable. It checks things like whether your site uses secure HTTPS connections, if JavaScript features are used safely, and if images and resources load properly. The goal is to ensure your website avoids common problems that could make it less secure, slow, or unreliable for users.

{{ figure_markup(
  image="median-lighthouse-best-practices-score.png",
  caption="Median Lighthouse best practices score for various ecommerce platforms on desktop and mobile.",
  description="Bar chart showing median Lighthouse best practices scores for ecommerce platforms on desktop and mobile in 2024. Squarespace Commerce leads with high scores, achieving a perfect 100 on desktop and 96 on mobile. WooCommerce, Wix eCommerce, Shopify, and PrestaShop maintain consistent scores around 78–79, while 1C-Bitrix has the lowest scores, showing potential room for improvement in best practices compliance.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=1049035792&format=interactive",
  sheets_gid="1875368844",
  sql_file="median_lighthouse_score_ecommsites.sql"
  )
}}

Squarespace is leading by far among platforms with more than 50,000 pages in our dataset, with a 22-point difference over the second place, WooCommerce.

## Payment providers

The detection of payment providers is not as advanced or precise as the detection of different ecommerce platforms. This may be because we only analyze the home page rather than the entire website, which might not provide clear indications of the payment providers used. You can refer to the [checkpoint on the Wappalyzer GitHub](https://github.com/HTTPArchive/wappalyzer) profile to understand how different payment providers are detected. Multiple payment providers can be used on the same website. In such cases, the website is counted for each payment provider detected.

The following section focuses on each website with detected payment providers, even if no ecommerce system was identified.

The data reveals that PayPal is the most commonly detected payment method on mobile websites, appearing on 3.48% of all pages in the dataset. This means PayPal was found on approximately 560,000 mobile pages out of more than 16 million analyzed.

Apple Pay ranks second, being detected more frequently than Google Pay, which shows its growing presence in mobile eCommerce. Meanwhile, Shop Pay, a payment solution provided by Shopify, secures third place in the rankings.

{{ figure_markup(
  image="mobile-payment-provider-distribution.png",
  caption="Mobile year-over-year payment provider distribution.",
  description="Bar chart showing the distribution of payment providers used on mobile ecommerce sites from 2022 to 2024. PayPal remains the most popular payment provider, followed by Apple Pay, Shop Pay, and Visa. The chart indicates a gradual increase in adoption for most providers over the years.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTQYSD_rO7eGM-ViE3WD7wQOV0itRwjmNy1lkKOyeF7L_b5EDvDlHjAgIzKBnVwExUzC_PSbg0t-3k5/pubchart?oid=611186794&format=interactive",
  sheets_gid="1631427419",
  sql_file="top_payment_yoy.sql"
  )
}}

## Conclusion

ecommerce is still evolving, with platform preferences varying by region and website size. While WooCommerce remains the go-to platform for many, Shopify has steadily gained ground, especially among higher-traffic websites. Interestingly, platforms like Wix eCommerce perform well in terms of user experience metrics despite being more popular with smaller sites. Overall, we can observe improvements in most metrics, from performance to accessibility, over the past few years, benefiting everyone.

While ecommerce platforms are diverse and well distributed among different providers, a few key players dominate technologies like payment systems. It will be interesting to see how this landscape continues to evolve in the coming years.

