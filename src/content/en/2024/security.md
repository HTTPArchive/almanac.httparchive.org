---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Security
description: Security chapter of the 2024 Web Almanac covering Transport Layer Security, content inclusion (CSP, Feature Policy, SRI), web defense mechanisms (tackling XSS, XS-Leaks), and drivers of security mechanism adoptions.
authors: [GJFR, vikvanderlinden]
reviewers: [lord-r3, SaptakS, AlbertoFDR, clarkio]
editors: [cqueern, joeleonjr]
analysts: [JannisBush]
translators: []
results: https://docs.google.com/spreadsheets/d/1b9IEGbfQjKCEaTBmcv_zyCyWEsq35StCa-dVOe6V1Cs/
featured_quote: TODO
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
---

## Introduction

With how much of our lives happen online these days - whether it’s staying in touch, following the news, buying, or even selling products online - web security has never been more important. Unfortunately, the more we rely on these online services, the more appealing they become to malicious actors. As we've seen time and time again, even a single weak spot in the systems we depend on can lead to disrupted services, stolen personal data, or worse. The past two years have been no exception, with a rise in [Denial-of-Service (DoS) attacks](https://blog.cloudflare.com/ddos-threat-report-for-2024-q2/), [bad bots](https://www.imperva.com/resources/resource-library/reports/2024-bad-bot-report/), and [supply-chain attacks targeting the Web](https://www.darkreading.com/vulnerabilities-threats/rising-tide-of-software-supply-chain-attacks) like never before.

In this chapter, we take a closer look at the current state of web security by analyzing the protections and security practices used by websites today. We explore key areas like Transport Layer Security (TLS), cookie protection mechanisms, and safeguards against third-party content inclusion. We'll discuss how these security measures help prevent attacks, as well as highlight common misconfigurations that can undermine them. Additionally, we examine some of the harmful practices still present on the web, such as the widespread use of cryptominers.

We also investigate the factors driving security practices, analyzing whether elements like country, website category, or technology stack influence the security measures in place. By comparing this year’s findings with those from the [2022 Web Almanac](https://almanac.httparchive.org/en/2022/security), we highlight key changes and assess long-term trends. This allows us to provide a broader perspective on the evolution of web security practices and the progress made over the years.

