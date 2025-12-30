---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: SEO  
description: SEO chapter of the 2025 Web Almanac covering crawlability, indexability, page experience, on-page SEO, links, AMP, internationalization, and more.  
hero_alt: Hero image of various web pages beneath a search field with Web Almanac characters shine a light on the pages and make various checks.  
authors: [Amaka Chukwuma, Chris Green, Sophie Brannon]  
reviewers: [Jamie Indigo]  
analysts: [Augustin Delporte, Chris Green]  
editors: [Michael Lewittes, Montserrat Cano, Sharon McClintic]  
translators: []  
results: https://docs.google.com/spreadsheets/d/1MoWoxogYWH6fv5r485EttvVgJuw7dMzzcot66X3MWu4/edit

augustin_delporte_bio: Technical SEO expert specializing in the data portion of things. Augustin has more than a decade of experience in the industry and has worked both agency and client side.

amaka_chulwuma_bio: Amaka is an SEO and content strategist who has spent the last seven years shaping how brands show up online. She has worked with agencies in the UK, US, and Australia, including Whitecoat SEO and Switch Key Digital, where she builds content systems, technical SEO foundations, and search-led storytelling for clients in legal, health care, home services, and B2B. Her work reflects a mix of clarity, thoughtful strategy, and empathy. She brings those same qualities into her life outside work, especially when spending time with her daughter, who remains her favourite part of every day.

chris_green_bio: Chris Green is a Technical Director at <a href="https://www.torquepartnership.com/">Torque Partnership</a> and a search veteran of 15+ years. He advises Fortune 500 companies on search strategy and the evolving relationship between brands, algorithms, and AI systems.

jamie_indigo_bio: Jamie Indigo isn't a robot, but speaks bot. As director of technical SEO at <a hreflang="en" href="https://www.coxautoinc.com/">Cox Automotive</a>, they study how search engines crawl, render, and index the web. Jamie loves to tame wild JavaScript and optimize rendering strategies. When not working, they like horror movies, graphic novels, and terrorizing lawful good paladins in Dungeons & Dragons.

michael_lewittes_bio: Michael Lewittes is the founder of <a hreflang="en" href="https://www.ranktify.com">Ranktify</a>, a software company that improves the quality and trustworthiness of content so that it can rise higher in search engine results as well as the LLMs. Michael previously founded and sold Gossip Cop to a PE-backed publisher, as well as wrote for and edited more than 75,000 articles for several major U.S. publications. This is the third time he's worked on the Web Almanac.

montserrat_cano_bio: Montserrat Cano is an integrated digital manager, specialised in SEO and project management for product and ecommerce <a hreflang="en" href="https://montserrat-cano.com">MC. International Digital Marketing</a>. Montserrat brings in a strategic outlook and over 20+ years' experience to drive business results in both in-house and contract roles. A business and university trainer, she also mentors professionals to democratise digital and SEO, and strengthen the industry. This is her second time contributing to the Web Almanac.

sharon_mcclintic_bio:  Sharon McClintic is a B2B SaaS content and campaigns specialist currently based in England. As the Senior Content Marketing Lead at <a href="https://www.lumar.io/">Lumar (formerly Deepcrawl)</a>, she oversees both editorial content and ad campaigns.. With a background that bridges both business strategy and creative writing, she's enthusiastic about bringing an editorial mindset to B2B communications. She holds an MBA in marketing, an MA in creative writing, and undergraduate degrees in journalism and literature, alongside 15+ years of international marketing experience across both the US and UK. You can <a href="https://www.linkedin.com/in/sharonmcclintic/">connect with Sharon on LinkedIn here</a>.

sophie_brannon_bio: Sophie Brannon is the co-founder & director of StudioHawk US, based in Atlanta. With over a decade of SEO experience spanning agency, in-house, and consultancy roles, she has worked across a wide range of industries including eCommerce, finance, gaming, health, and SaaS. Sophie brings a strategic, data-driven approach to organic growth, helping brands scale sustainably through technical SEO, user experience testing, content and digital PR. She's passionate about making SEO accessible and mentoring the next generation of search marketers.

featured_quote: As AI search reshapes how content is discovered, the web's fundamentals matter more than ever, and reassuringly, the data suggests those foundations are holding firm.

featured_stat_1: 2.10%  
featured_stat_label_1: 2.10% of mobile sites employ llms.txt files  
featured_stat_2: 92%  
featured_stat_label_2: HTTPS adoption reached \~91.7% (desktop) and \~91.5% (mobile). A stable but important step upward from \~89%.  
featured_stat_3: 50%  
featured_stat_label_3: Structured data adoption reached 50% of all pages   
doi: ""  
---

## Introduction  {#introduction}

Search Engine Optimization (SEO) continues to play a central role in how information is discovered and understood online. It encompasses the technical, structural, and content practices that determine whether a website can be effectively crawled, indexed, and surfaced in search results. 

Strong SEO foundations not only support visibility in traditional search engines but are becoming increasingly important as AI systems begin to interpret and summarize web content in new ways.

This 2025 SEO chapter of the Web Almanac draws its data and insights from the HTTP Archive crawl, Lighthouse reports, Chrome User Experience (CrUX) reports, and custom metrics. Our goal is to document how the technical state of the web is evolving and to identify the factors that most influence organic visibility today. 

While many SEO metrics have stabilized across the web, the context surrounding them is changing rapidly. The rise of AI crawlers, emergence of `llms.txt` and a growing emphasis on machine readability suggest that optimization is no longer only about being *found* by bots, but about being *understood* by them. How will these changing contexts in online search influence optimization moving forward  and how do the latest data points already reflect AI's influence on SEO?  

## Crawlability & indexability {#crawlability-&-indexability}

For web content to gain visibility in search results, it must first be crawled and indexed by search engine crawlers.  Crawlability determines whether bots can  find and access a page, while indexability defines whether that page is eligible to appear in search results. Together, these concepts form the foundational elements of search visibility. A page cannot rank or be served to users if it cannot first be found and understood by the bots. Similarly, content cannot be cited on AI platforms unless a site is indexable.

[Google's documentation](https://developers.google.com/search/docs/crawling-indexing/robots/robots_txt) clarifies that compliance with crawling rules depends not only on the presence of a `robots.txt` file but also on how correctly this file is structured. Search engines also apply practical limits and standardized caching behavior to ensure directives can be parsed efficiently and interpreted consistently.

At the same time, as [Cloudflare explains](https://www.cloudflare.com/learning/bots/what-is-robots-txt/), `robots.txt` functions more as a code of conduct than a command that will always be obeyed. While reputable bots respect these signals, others may ignore them entirely. This mix of cooperation and unpredictability defines the modern crawling environment and sets the stage for examining how sites actually manage crawler access.

### **Robots.txt** {#robots.txt}

Serving as the web's de facto "visitors' center" for crawlers, the `robots.txt` file is where bots learn which parts of a site are open or restricted. Since the [IETF's standardization](https://www.ietf.org/about/) of the Robots Exclusion Protocol ([RFC 9309](https://datatracker.ietf.org/doc/html/rfc9309)) three years ago, its syntax, caching behavior, and error handling have been clearly defined, providing a stable framework for how crawlers interpret access rules.

Efforts to refine that framework are ongoing. In late 2024, the [IETF introduced](https://garyillyes.github.io/ietf-rep-ext/draft-illyes-repext.html) a working draft known as REPext, which builds on RFC 9309 by exploring page-level crawl controls through response headers and HTML `meta` tags, an approach that could make future implementations more granular and flexible.

For now, however, the `robots.txt` file remains the foundation of crawl management. Most websites now serve a valid file, with only a small minority omitting it entirely. Among those that do, site owners typically favor simple, universal directives rather than complex, bot-specific rules. The sections that follow examine how these preferences appear in the 2025 data.

#### **Robots.txt status codes** {#robots.txt-status-codes}

In 2025, 84.88% (desktop) and 84.94% (mobile) of requests for `robots.txt` files returned valid 200 status codes, up from 83.5% (desktop) and 83.9% (mobile) in 2024\. The steady rise suggests ongoing trickle-down from the 2022 standardization and wider CMS defaults that serve valid `robots.txt` files. Importantly, however, a 200 response only confirms that a file exists. It does not guarantee that its directives are correct or beneficial to the site.

The mobile–desktop gap has effectively disappeared when it comes to valid (200) `robots.txt` status codes, with mobile now having just a 0.06% lead compared to desktop. This mirrors the industry's move away from separate m-dot sites toward responsive design with unified configurations.

The rate of 404 errors for `robots.txt` files declined to 13.33% (desktop) and 13.21% (mobile) from 14.3% and 14.1% in 2024\. Fewer missing files imply that more sites are explicitly serving `robots.txt` files rather than leaving them absent, which would otherwise default to unrestricted crawling.

Timeouts are \~1.0% (0.97% desktop; 1.05% mobile), 403 responses are \~0.5%, and 5xx are \~0.1%. Although uncommon, [5xx responses](https://developers.google.com/search/docs/crawling-indexing/robots/robots_txt#:~:text=Other%20errors-,A%20robots.,treated%20as%20a%20server%20error.) on a `robots.txt` file can cause search engines to temporarily treat the site as blocked until a cached file or a later successful fetch is available.

{{ figure_markup(  
  image="",  
  caption="\`robots.txt\` status codes.",  
  description="Bar chart showing the distribution of HTTP status codes returned when accessing `robots.txt` files. A 200 status code (success) is returned for 84.88% of desktop sites and 84.94% of mobile sites. A 404 status code (not found) is returned for 13.33% of desktop sites and 13.21% of mobile sites. A 403 status code (forbidden) is returned for 0.52% of desktop sites and 0.53% of mobile sites. A 500 status code (server error) is returned for 0.10% of desktop sites and 0.09% of mobile sites.",  
  chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1134590836\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1134590836&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="robots-txt-status-codes \-2025.sql"  
  )  
}}

#### **Robots.txt file size** {#robots.txt-file-size}

Nearly all `robots.txt` files stay well under size limits ([Google enforces a 500 KB](https://developers.google.com/search/docs/crawling-indexing/robots/robots_txt#:~:text=Google%20enforces%20a%20robots.,the%20size%20of%20the%20robots.) parsing cutoff) and comply with standards such as not serving an empty file. 

A small share of sites serve completely empty `robots.txt` files, now 1.82% on desktop and 1.71% on mobile, slightly up from 2024\. While most [major crawlers treat an empty file as permissive](https://developers.google.com/search/docs/crawling-indexing/robots/robots_txt#:~:text=For%20the%20first%2012%20hours,checking%20for%20a%20new%20version\).), the standard ([RFC 9309](https://www.rfc-editor.org/rfc/rfc9309.html)) doesn't define this behavior explicitly, leaving room for inconsistent handling by lesser-known bots. A safer approach is to either return a valid file or a 404 if no restrictions are intended.

In 2025, 97.59% of desktop and 97.51% of mobile files were under 100 KB, only slightly down from 97.80% (desktop) and 97.82% (mobile) in 2024\. The minor change year over year points to a stable and mature implementation pattern.

Files between 100–200 KB accounted for 0.34% (desktop) and 0.33% (mobile) `robots.txt`, and 200–300 KB for just 0.11% (both desktop and mobile) of `robots.txt`, virtually unchanged from last year. Only 0.07% (desktop) and 0.11% of (mobile) sites exceeded the 500 KB parsing cutoff enforced by Google, confirming strong adherence to crawler limits and reinforcing that oversized `robots.txt` files are an edge case.

Robots.txt file size rarely poses a barrier to crawlability. The more pressing issue continues to be empty or misconfigured files, which introduce uncertainty in how crawlers interpret site rules.


{{ figure_markup(  
  image="",  
  caption="\`robots.txt\` size.",  
  description="Bar chart showing the file size distribution of `robots.txt` files. Files with 0-100 bytes account for 97.51% of desktop sites and 97.59% of mobile sites. Files with 100-200 bytes account for 0.34% of desktop sites and 0.33% of mobile sites. Files with 200-300 bytes account for 0.11% of desktop sites and 0.11% of mobile sites. Files with 300-400 bytes account for 0.12% of desktop sites and 0.11% of mobile sites. Files with 400-500 bytes account for 0.03% of desktop sites and 0.03% of mobile sites. Files larger than 500 bytes account for 0.07% of desktop sites and 0.11% of mobile sites.",  
  chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=379008836\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=379008836&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="robots-txt-size-2025.sql"  
  )  
}}

#### **Robots.txt user agent usage** {#robots.txt-user-agent-usage}

The catch-all user agent `*` is the most common approach to crawler directives  found in `robots.txt` files today. In 2025, it appeared in 77.04% of desktop and 77.14% of mobile files—up from 76.6% (desktop) and 76.9% (mobile) in 2024, and from the mid-70% range in 2022\. The steady rise indicates that most site owners prefer to implement broad, universal rules rather than maintaining complex bot-specific instructions.

Where specific user agents *are* mentioned in `robots.txt` files, Google's advertising crawler (adsbot-google) and AhrefsBots take the lead again, as they did last year. 

Targeting of `adsbot-google` in `robots.txt` directives rose to 9.82% (desktop) and 9.51% (mobile) in 2025, compared with 9.1% (desktop) and 8.9% (mobile) in 2024\. 

AhrefsBot also remained a leading named crawler, specified in 9.29% of desktop and 9.50% of mobile `robots.txt` files. Combined with AhrefsSiteAudit (4.57% desktop / 4.27% mobile), this reflects the ongoing importance of controlling access by SEO tools, which can generate significant crawl activity.

Other named crawlers that appeared in notable volumes this year include:

* MJ12Bot (Majestic): 7.31% desktop / 7.28% mobile

* Googlebot: 6.22% desktop / 6.66% mobile

* Nutch: 5.03% desktop / 4.81% mobile

##### **Bingbot rarely named in robots.txt**  {#bingbot-rarely-named-in-robots.txt}

Bingbot ranks 22nd among named user agents in `robots.txt` files and appears in less than 3% of `robots.txt` (2.67% desktop and 2.57% mobile). When a bot appears in `robots.txt` files, it means website managers care enough about that crawler to explicitly control its behavior, either allowing it, restricting it, or setting crawl rates. Low appearance rates suggest benign neglect. Despite Microsoft's massive [investment in AI](https://blogs.microsoft.com/on-the-issues/2025/01/03/the-golden-opportunity-for-american-ai/) and its integration of [ChatGPT into Bing](https://blogs.microsoft.com/blog/2023/02/07/reinventing-search-with-a-new-ai-powered-microsoft-bing-and-edge-your-copilot-for-the-web/), the crawler itself hasn't become more prominent in `robots.txt` files. Even with its AI enhancements, Bing's web footprint and importance to site operators remain largely unchanged, a quiet contrast to the rapid rise of AI-focused crawlers like GPTbot named in `robots.txt` files (more on that below).

##### **Slight growth in use of named user agents** {#slight-growth-in-use-of-named-user-agents}

Overall, compared to 2024, a slightly larger share of `robots.txt` files in 2025 include directives for named crawlers rather than relying solely on the universal wildcard \*. For instance, MJ12Bot rose from 6.6% (mobile) last year to 7.3% (mobile) in 2025, Googlebot rose from 6.4% (mobile) to 6.7% (mobile), and Nutch from 4.3% (mobile) to 4.81% (mobile) this year.  These modest gains point to gradual refinement — more site owners are setting tailored crawl rules where it matters, without moving away from the simplicity of universal controls.

The continued dominance of `*` alongside rising mentions of specific bots in `robots.txt` suggests a pragmatic balance. Universal directives remain the norm, but targeted rules are added where business concerns justify them. Not all crawlers interpret `*` consistently. Google's AdsBot ignores it, and Applebot falls back to Googlebot rules before applying `*` making explicit targeting necessary in certain cases.


{{ figure_markup(  
  image="",  
  caption="\`robots.txt\` user agents.",  
  description="Bar chart showing the most common user agents specified in `robots.txt` files. The wildcard user agent (\\\*) appears in 77.04% of desktop sites and 77.14% of mobile sites. adsbot-google appears in 9.82% of desktop sites and 9.51% of mobile sites. ahrefsbot appears in 9.29% of desktop sites and 9.50% of mobile sites. mj12bot appears in 7.31% of desktop sites and 7.28% of mobile sites. googlebot appears in 6.22% of desktop sites and 6.66% of mobile sites. nutch appears in 5.03% of desktop sites and 4.81% of mobile sites. dotbot appears in 4.58% of desktop sites and 5.02% of mobile sites. adsbot-google-mobile appears in 4.76% of desktop sites and 4.71% of mobile sites. pinterest appears in 4.59% of desktop sites and 4.35% of mobile sites. ahrefssiteaudit appears in 4.57% of desktop sites and 4.27% of mobile sites. Additional user agents are shown in the chart.",  
  chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=315238915\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=315238915&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="robots-txt-user-agent-usage-2025.sql"  
  )  
}}  
*Description:*

{{ figure_markup(  
  image="",  
  caption="\`robots.txt\` SEO tool related user agents.",  
  description="Bar chart showing the prevalence of SEO crawler bots mentioned in `robots.txt` files. AhrefsBot appears in 9.29% of desktop sites and 9.50% of mobile sites. AhrefsSiteAudit appears in 4.57% of desktop sites and 4.27% of mobile sites. MJ12Bot appears in 7.31% of desktop sites and 7.28% of mobile sites. SEMrushBot appears in 3.01% of desktop sites and 3.05% of mobile sites.",  
  chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=646503191\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=646503191&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="robots-txt-user-agent-usage-2025.sql"  
  )  
}}

##### **AI crawlers named in robots.txt** {#ai-crawlers-named-in-robots.txt}

The rise of AI crawlers has transformed `robots.txt` from a traditional search optimization tool into a broader mechanism for managing content permissions. In 2025, directives targeting AI-related bots showed substantial growth from 2024 levels.

The year-over-year comparison reveals accelerating adoption:

* **GPTBot**: 4.49% (desktop), 4.19% (mobile) is up from 2.9% (desktop) and 2.7% (mobile) in 2024, representing a \~55% increase  
* **CCBot**: 3.50% (desktop), 3.23% (mobile) is up from 2.7% (desktop) and 2.4% (mobile) in 2024  
* **PetalBot**: 3.96% (desktop), 4.38% (mobile) this year; was not separately tracked in 2024  
* **ClaudeBot**: 3.64% (desktop), 3.43% (mobile) is up from 1.9% (desktop) and 1.6% (mobile) in 2024, nearly doubling

Notably, 2024's data included broader categories like "anthropic-ai" (2.0% desktop and 1.7% mobile last year) and "chatgpt-user" (2.0% desktop and 1.7% mobile last year), while our 2025 data shows more specific bot targeting. 

Other entrants in the AI crawler space this year include **Amazonbot** (3.34% desktop, 3.0% mobile), **Google-Extended** (3.37% desktop, 2.96% mobile), **PerplexityBot** (2.81% desktop, 2.65% mobile), **ChatGPT-User** (2.84% desktop, 2.50% mobile), **FacebookBot** (2.86% desktop, 2.46% mobile), and **Meta-ExternalAgent** (2.81% desktop, 2.48% mobile).

**While overall user agent targeting has grown only gradually year over year, the adoption of AI crawlers has been far more abrupt.** GPTBot's near-doubling since 2024, alongside measurable adoption for PetalBot, ClaudeBot, and others, represents one of the fastest expansions of robots.txt directives for named user agents in recent memory, moving from a marginal presence in 2023 to multi-percent adoption rates by 2025\.

This shift introduces new complexity for site owners. Instead of only asking, "Should this page be indexed for search?" they must now also ask, "Should this content be used to train AI models?" These are distinct considerations with different business and ethical implications.

Robots.txt has become a dual-purpose control point, balancing visibility in search with protection against large-scale data harvesting. This trend is likely to intensify as AI models and crawlers proliferate.

*Description:* 

{{ figure_markup(  
  image="",  
  caption="\`robots.txt\` AI-related user agents.",  
  description="Bar chart showing the growth in named user agent usage in `robots.txt` files. GPTBot appears in 4.49% of desktop sites and 4.19% of mobile sites. PetalBot appears in 3.96% of desktop sites and 4.38% of mobile sites. ClaudeBot appears in 3.64% of desktop sites and 3.43% of mobile sites. CCBot appears in 3.50% of desktop sites and 3.23% of mobile sites. AmazonBot appears in 3.34% of desktop sites and 3.00% of mobile sites. Google-Extended appears in 3.37% of desktop sites and 2.96% of mobile sites. PerplexityBot appears in 2.81% of desktop sites and 2.65% of mobile sites. ChatGPT-User appears in 2.84% of desktop sites and 2.50% of mobile sites. FacebookBot appears in 2.86% of desktop sites and 2.46% of mobile sites. Meta-ExternalAgent appears in 2.81% of desktop sites and 2.48% of mobile sites.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=725000646\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=725000646&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="robots-txt-user-agent-usage-2025.sql"  
  )  
}}

## llms.txt {#llms.txt}

The `llms.txt` file has been proposed as a new standard ​​"to provide information to help LLMs use a website at inference time. (Per [llmstxt.org](http://llmstxt.org).)This text file contains a highly simplified version of the website's content in Markdown format, with a view toward making it easier for LLMs to ingest and subsequently use in generated responses.

This standard, has, it must be noted, not been adopted widely and has become a point of controversy within the broader SEO industry. Google has often stated that they do not use `llms.txt`, and [no Google service currently does](https://www.seroundtable.com/google-ai-llms-txt-39607.html). Anthropic, however, has [taken a lead on `llms.txt`,](https://docs.claude.com/llms-full.txt), raising optimism that the format may evolve into a reliable mechanism for managing and optimizing content utilization during model inference. 

### llms.txt, adoption rate {#llms.txt,-adoption-rate}

Regardless of whether using `llms.txt` proves to be a valid approach for SEO or AI optimization, the introduction of a new file format and proposed standard like this could influence how websites are built and optimized moving forward. 

As part of the 2025 Almanac, we have introduced monitors to assess the level of `llms.txt` adoption across the web. 


{{ figure_markup(  
  image="",  
  caption="Valid llms.txt",  
  description="Bar chart showing the adoption of `llms.txt` \- which appear in 2.13% of desktop sites and 2.10% of mobile sites. This leaves 97.87% of desktop sites without an `llms.txt` and 97.90% of mobile without `llms.txt`",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=637355278\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=637355278&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="llms-status-2025.sql"  
  )  
}}

We can see that the adoption rate is relatively low at 2.10% (desktop) and 2.13% (mobile) —  but these figures are arguably still notable given how new the `llms.txt` format is and that a total of 583k valid files were identified across all sites analyzed (desktop and mobile combined). 

Digging into the content of these `llms.txt` files, we see some clues about the adoption of this standard so far, and likely what is going to make this move in the future.

* 39.6% of `llms.txt` files are related to All in One SEO  
* 3.6% of `llms.txt` files are related to Yoast SEO

This was gleaned by the comments these CMS extensions leave (by default) in the files they generated, but it shows that a significant number of website owners with an `llms.txt` file in place are having them generated by their CMS/add-on extensions. Therefore, we cannot be sure this is always a conscious act or endorsement of the `llms.txt` standard or an unintentional inclusion. 

Over the last 9+ months (since January 2025), [interest in this emerging standard has grown](https://trends.google.com/trends/explore?q=llms.txt&hl=en-GB) and hinges on just one or two key AI companies' recognition. The 2026 numbers will be interesting to see, nonetheless.

## Robots directives {#robots-directives}

A robots directive provides page-level control over how a specific page is indexed and displayed in search results. While they have a similar function to robots.txt files, the two serve different purposes: 

* Robots *directives* influence **indexing and serving**   
* Whereas robots.txt governs **crawling**

For a directive to be applied, the crawler must be able to access the page. If a page is blocked by robots.txt, its directives may never be seen or obeyed.

#### Robots directives implementation {#robots-directives-implementation}

There are two main ways to implement robots directives:

1. Using a [meta robots](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/meta/name/robots) tag (placed within the \<head\> section of a webpage)  
2. Using an [x-robots](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/X-Robots-Tag) HTTP header

The method you choose depends on your specific use case, as well as the means and methods at your disposal.

Meta robots tags are primarily for HTML pages and are widely supported by most major CMSs either natively or through add-ons, and other common, well-supported frameworks.

X-Robots Tags have a major advantage in that they can be implemented for other non-HTMLs file types, such as PDFs or documents. However, setting them is often not as easy or simple for CMS users, so they may not always be an option.

{{ figure_markup(  
  image="",  
  caption="Robots directive implementation",  
  description="Bar chart showing robots directive implementation methods across websites. Meta Robots directives are used on 47.0% of desktop sites and 47.9% of mobile sites. X-Robots-Tag directives are used on 0.6% of desktop sites and 0.7% of mobile sites. Both Meta Robots and X-Robots-Tag directives are used together on 0.4% of desktop sites and 0.4% of mobile sites.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=736143902\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=736143902&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="seo-stats-2025.sql"  
  )  
}}

By a large margin, Meta robots is the most widely used method for implementing robots directives, appearing on 47% of desktop pages and 47.9% of mobile pages. X-Robots come in a distant second at 0.6% (desktop) and 0.7% (mobile).

The number of pages implementing meta robots increased from 45.5% (desktop) and  46.2% (mobile)recorded last year to 47% (desktop) and 47.9% (mobile) in 2025, showing growth year-over-year (YoY). In contrast, X-Robots-Tag implementation has stayed roughly the same YoY. Inner pages are 50% likely to use a robots directive, compared to home pages which are 46%.

Some pages (0.4% on both desktop and mobile) have both Meta robots and X-Robot-Tag implemented at the same time. This figure of 0.4% is stable from last year but this is not a widely recommended practice, as it  increases the likelihood of generating  conflicting signals between the two methods of implementation.

#### Robots directives rules {#robots-directives-rules}

The method of implementation is only part of the picture when it comes to robots directives; [the directive rules](https://developers.google.com/search/docs/crawling-indexing/robots-meta-tag#directives) determine how the page or document should be handled. 

Rules can be added to either Meta robots or X-Robots-Tag as comma-separated values. 

For our study of directive rules, we relied on the rendered HTML.


{{ figure_markup(  
  image="",  
  caption="Robots directive rules",  
  description="Bar chart showing the implementation of robots directives across pages. The follow directive appears in 64.0% of desktop sites and 60.5% of mobile sites. The index directive appears in 69.0% of desktop sites and 59.3% of mobile sites. The nofollow directive appears in 2.4% of desktop sites and 2.8% of mobile sites. The noindex directive appears in 3.5% of desktop sites and 2.4% of mobile sites. The max-image-preview directive appears in 5.0% of desktop sites and 2.8% of mobile sites. The max-snippet directive appears in 2.2% of desktop sites and 1.1% of mobile sites. The max-video-preview directive appears in 1.6% of desktop sites and 0.8% of mobile sites. The noarchive directive appears in 2.5% of desktop sites and 1.8% of mobile sites. The nosnippet directive appears in 0.1% of desktop sites and 0.1% of mobile sites. The notranslate directive appears in 0.0% of desktop sites and 0.0% of mobile sites. Additional directives are shown in the chart.  
",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=779209791\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=779209791&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="robots-meta-usage-2025.sql"  
  )  
}}

*Follow* and *index*, the two most-used rules, are considered the default values (and are ignored by Google) in the absence of other rules like *noindex* and *nofollow*, which have the opposite purpose. 

Their inclusion means that robots should index the page and follow the links from it. Their mobile usage at 60.5% and 59.3% for follow and index, respectively, implies these two tags are likely to be found together and are generally complementary.

A possible cause for this high number of a technically unnecessary combination of Meta robots rules is Yoast SEO, [which applies "index,follow" by default](https://developer.yoast.com/features/seo-tags/meta-robots/functional-specification/#:~:text=Unless%20otherwise%20defined%20by%20the%20user%20\(or%20via%20page/template/filtering%20logic\)%2C%20%7B%7Bvalues%7D%7D%20outputs%20index%2C%20follow.). Yoast has an approximate 16% adoption (desktop and mobile) when looking at home page use of SEO tools/plugins and, of [all identified SEO tools](https://www.wappalyzer.com/technologies/seo/), it is used nearly 70% of the time.

Nofollow and noindex, the next two most-used Meta robots rules, are used at a considerably lower frequency, showing up on 2.8% of desktop pages and 2.4% of mobile pages.  


*Description:* 

{{ figure_markup(  
  image="",  
  caption="SEO Tools",  
  description="Bar chart showing the most common robots directive rules implemented across websites. Yoast SEO appears in 15.96% of desktop sites and 15.49% of mobile sites. RankMath SEO appears in 3.56% of desktop sites and 3.60% of mobile sites. All in One SEO appears in 2.96% of desktop sites and 2.92% of mobile sites. Yoast SEO Premium appears in 1.42% of desktop sites and 1.30% of mobile sites. Ahrefs appears in 0.28% of desktop sites and 0.25% of mobile sites. The SEO Framework appears in 0.18% of desktop sites and 0.15% of mobile sites. SEOmatic appears in 0.07% of desktop sites and 0.05% of mobile sites. Avada SEO appears in 0.06% of desktop sites and 0.06% of mobile sites. Yoast SEO for Shopify appears in 0.03% of desktop sites and 0.02% of mobile sites. BrightEdge appears in 0.01% of desktop sites and 0.01% of mobile sites. Additional SEO tools and plugins are shown in the chart.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1233372001\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1233372001&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="wordpress_seo_plugin-2025.sql"  
  )  
}}

Another element of Meta robots directives is the "name" attribute, which enables us to specify whether these directives address a specific user-agent of a robot/crawler. We can, for example, tailor behavior if some crawlers require specific rules and others do not.

The most-named crawlers within this attribute are consistent with 2024: Bingbot, MSNbot, Googlebot, and Google-news appear most frequently, alongside the default "robots."


{{ figure_markup(  
  image="",  
  caption="Robots directive rules by name",  
  description="A bar chart comparing robots directive rules by crawler named in robots directives for mobile pages. The named bots are Bingbot, MSNBot, Googlebot, Googlebot-News. The values were applied as follows: follow: 94.9%, 78.8%, 61.0%, 75.6%, 54.0%. index: 92.6%, 66.8%, 60.7%, 77.3%, 58.3%. nofollow: 0.8%, 3.9%, 1.9%, 2.4%, 3.9%. noindex: 1.4%, 5.0%, 3.5%, 3.5%, 9.1%. max_image_preview: 84.4%, 0.5%, 71.1%, 25.2%, 3.8%. max_snippet: 84.4%, 0.5%, 42.1%, 24.9%, 1.6%. max_video_preview: 84.2%, 0.5%, 42.1%, 24.6%, 1.2%. noarchive: 2.0%, 3.5%, 0.9%, 4.5%, 1.1%. nosnippet: 0.1%, 0.1%, 0.1%, 0.8%, 5.5%. notranslate: 0.0%, 0.0%, 0.0%, 1.2%, 0.1%. noimageindex: 0.1%, 0.0%, 0.1%, 0.7%, 0.1%",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1906268341\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1906268341&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="robots-meta-usage-2025.sql"  
  )  
}}

MSNbot is a legacy crawler that has been replaced by Bingbot. Its continued presence in robots directives suggests a delay in updating or removing outdated crawler names. Additional evidence of this lag can be seen in the fact that newer robots rules—such as "max_image_preview", "max_snippet", and "max_video_preview"—are commonly applied to Googlebot and Bingbot, but not to MSNbot. 

### Indexifembedded tag {#indexifembedded-tag}

A now well-established Meta robots rule, **indexifembedded** is a highly specific tag that enables us to specify when we want iframe content to be treated as being part of the page which it is embedded on. This needs to be paired with "noindex" in order to work, and is a rule which only Google currently supports.  

{{ figure_markup(  
  image="",  
  caption="\`indexifembedded\` usage in \`iframe\` content",  
  description="Bar chart showing the prevalence of invalid HTML elements found within the head section of web pages. \`iframe\` elements with \`indexifembedded\` usage appear in 88.89% of desktop sites and 87.67% of mobile sites.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=489480572\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=489480572&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="robots-meta-usage-2025.sql"  
  )  
}}

Within iFrame content, the indexifembedded rule is found almost 90% of the time (88.89% on desktop, 87.67% on mobile). What is interesting is that after seeing raises in use from 2022 to 2024, 2025 saw a decline from 99.9% use.

### Invalid \<head\> elements {#invalid-<head>-elements}

Search engine crawlers follow HTML standards when parsing content. One issue they may encounter is when invalid HTML elements are found within the \<head\> of the page. This can cause the \<head\> to be treated as implicitly ending early, and all remaining \<head\> elements are then included within the \<body\> of the page. 

Negative impacts to SEO are greatest here when important meta data, such as `title`, `canonical` tags, hreflang, Meta robots directives, etc., are  located below the invalid `head` element (as their inclusion within the `body` renders them ineffective).


{{ figure_markup(  
  image="",  
  caption="Pages with invalid HTML in \`\<head\>\`",  
  description="Chart showing pages with invalid HTML in the head section. Invalid HTML elements are found in 10.10% of desktop sites and 10.33% of mobile sites.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1130119859\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1130119859&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="invalid-head-sites-2025.sql"  
  )  
}}

Invalid head elements found this year are continuing the downward trend we saw in 2024's data; that is, we are once again seeing fewer invalid elements in pages' \<head\> sections year over year. 

In 2025, we are seeing 10.10% invalid \<head\> elements on desktop pages and 10.33% invalid elements on mobile pages. Compared to 2024's data (10.6% on desktop and 10.9% on mobile), this represents drops  of 4.7% (desktop) and 5.2% (mobile). 

The definition of "invalid" \<head\> elements includes anything included in the page's \<head\> that is not based on W3C standards. There are eight valid elements that may be used in the \<head\>, according to [Google Search documentation](https://developers.google.com/search/docs/crawling-indexing/valid-page-metadata#use-valid-elements-in-the-head-element). These are:

* \<title\>  
* \<meta\>  
* \<link\>  
* \<script\>  
* \<style\>  
* \<base\>  
* \<noscript\>  
* \<template\>


  
The invalid elements which are most prevalent in 2025 are the same as they were in 2024's data: \<img\>, \<div\>, and \<a\> tags.  
{{ figure_markup(  
  image="",  
  caption="Invalid \`head\` elements",  
  description="Bar chart showing invalid HTML elements found within the \`head\` section of web pages. The \`img\` element appears incorrectly in 27.18% of desktop sites and 23.00% of mobile sites. The \`div\` element appears in 11.50% of desktop sites and 10.64% of mobile sites. The \`a\` element appears in 5.16% of desktop sites and 4.88% of mobile sites. The \`iframe\` element appears in 3.50% of desktop sites and 3.05% of mobile sites. The \`p\` element appears in 3.27% of desktop sites and 3.15% of mobile sites. The \`span\` element appears in 3.16% of desktop sites and 3.09% of mobile sites. The \`br\` element appears in 2.56% of desktop sites and 2.48% of mobile sites. The \`input\` element appears in 2.44% of desktop sites and 2.42% of mobile sites. The \`li\` element appears in 1.94% of desktop sites and 2.16% of mobile sites. The \`ul\` element appears in 1.94% of desktop sites and 2.16% of mobile sites.",  
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=9729751\&format=interactive",  
  sheets_gid="1895020036",  
  sql_file="invalid-head-sites-2025.sql"  
  )  
}}

For invalid \<img\> tags, 2024 saw a sharp increase from 2022, whereas 2025's results are more stable (27.18% on desktop, 23% mobile this year vs 29% on desktop and 22% on mobile last year). Specifically, desktop usage has dropped, while mobile increased, albeit, by a small proportion.

\<div\> tags have no noticeable change at 11.5% on desktop and 10.64% on mobile. \<a\> tags similarly have seen no significant change from last year at 5.16% (desktop) and 4.88% (mobile). 

## Canonicalization  {#canonicalization}

`Canonical` tags tell search engines which version of a page is the main one when there are duplicates or near-duplicates. Without them, crawlers may split ranking signals, waste crawl budget, and show the wrong URL in search results. With them, all authority and indexing preferences point to a single, definitive page.

`Canonical` tags are not directives (like Meta robots); they are "strong hints" which provide a supporting signal that minimizes ranking issues through their correct implementation.

We have  seen another increase in `canonical` tag usage, up from 65% on both mobile and desktop last year, to 68% (desktop) and 67% (mobile) in 2025\.

###

{{ figure_markup(  
  image="",  
  caption="Canonical usage",  
  description="Bar chart showing `canonical` tag usage across desktop and mobile pages. On desktop, 68% of pages have a `canonical` tag, compared to 67% on mobile. Additionally, 7% of desktop pages and 9% of mobile pages are canonicalized (i.e., referenced as the canonical version by other pages).",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=180455031\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=180455031&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="seo-stats-2025.sql"  
  )  
}}

A page is "canonicalized" when its canonical URL points to a page which is not itself. Canonicalized pages have also seen an increase this year, up from 6% (desktop) and 8% (mobile)  in 2024 to 7% (desktop) and 9% (mobile) in 2025\. 

### Canonical implementation {#canonical-implementation}

`Canonical` tags, similar to Meta robots, can be implemented as part of the HTTP response or within the `head` of the page. The motivations behind each implementation method may be dependent on your platform and requirements, with associated pros and cons.

`Canonicals` within the `head` of the page (`rel="canonical"`): These are the most frequently utilized (as they are standardized by most CMS) and signal the canonical URL for the page. 

HTTP canonicals: These can do the same and have the added advantage of being able to be used with other file types, such as PDFs. They are, however, not as widely implemented and require more technical understanding.

###

{{ figure_markup(  
  image="",  
  caption="Canonical implementation",  
  description="Bar chart showing canonical implementation methods across websites. HTTP `Canonical` tags are found in 0.58% of desktop sites and 0.50% of mobile sites. Raw `Canonical` tags appear in 64.40% of desktop sites and 64.27% of mobile sites. Rendered `Canonical` tags are present in 66.01% of desktop sites and 66.11% of mobile sites.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=580513321\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=580513321&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="pages-canonical-stats-2025.sql"  
  )  
}}

HTTP canonical implementation is still very low in comparison to `rel="canonical"` tags, sitting at 0.58% (desktop) and 0.5% (mobile) in 2025\. These data represent only small drops against 2024's numbers, which came in at 0.68% (desktop) and 0.59% (mobile).

**Raw vs. rendered canonical tags**

`Canonical` tags, placed within the `head` of a page, can appear in the raw HTML, the rendered HTML, or both, depending on how the site is built. The most reliable approach, however, is to include a `canonical` tag in the raw HTML to ensure it remains unchanged after rendering.

For JavaScript-driven pages, the `canonical` tag is often inserted or updated in the browser once the page finishes rendering. The raw/rendered canonical results show us that only in around 2% of cases is there a `canonical` missing in the raw HTML but present in the rendered DOM. This indicates that most sites opt to include a `canonical` in the raw HTML, and it is not then removed at page render.

In 2025's data, we see that the raw HTML canonical numbers at 64.4% (desktop) and 64.27% (mobile)are on par with 2024's data. The rendered canonicals, however, have seen an increase in 2025 to 66% (desktop) 66.1% (mobile), compared to 64% (desktop) and 65% (mobile) last year.

### Canonical conflicts {#canonical-conflicts}

While rendering the `canonical` tag within the `head` can work, it introduces more room for error, so a static, server-side `canonical` tag is generally the safer option. Where the `canonical` tags mismatch, it undermines their usage and can cause unexpected results. Canonical mismatches saw a 0.1% drop from 2024's numbers, decreasing 0.8% (on desktop and mobile) to 0.7% this year.


  
*Description:* 

{{ figure_markup(  
  image="",  
  caption="Canonical inconsistency",  
  description="Bar chart showing canonical inconsistency issues across websites. Canonical Mismatch issues are detected in 0.72% of desktop sites and 0.71% of mobile sites. Rendered Change Canonical issues occur in 2.71% of desktop sites and 3.02% of mobile sites. HTTP Header Changed Canonical issues are found in 0.25% of desktop sites and 0.21% of mobile sites.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=284369724\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=284369724&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="pages-canonical-stats-2025.sql"  
  )  
}}

## Page experience {#page-experience}

Page experience captures how users actually feel when interacting with a web page beyond what the content says or how well it ranks. Originally introduced by Google as part of its ranking systems in 2020, these signals measure usability factors such as page speed, mobile responsiveness, visual stability, and security. While Google has since folded the standalone page experience system into its [core ranking framework](https://developers.google.com/search/blog/2020/11/timing-for-page-experience), the underlying metrics continue to guide both SEO and UX best practices.

In 2025, the data reflects a web that's technically mature but still uneven in experience quality. HTTPS adoption is nearly universal, mobile-friendliness is now an expectation rather than a differentiator, and Core Web Vitals (CWV) have become the industry standard for quantifying real-world performance. Yet, even with these advances, friction points, ranging from slow rendering to inconsistent interactivity, still persist, reminding site owners that user experience is as much about consistency as compliance.

### **HTTPS** {#https}

HTTPS was introduced to secure data exchanges between users and websites, protecting information from interception or tampering. It later became a [formal ranking signal](https://developers.google.com/search/blog/2014/08/https-as-ranking-signal) in Google's algorithm.

In 2025, HTTPS usage reached 91.72% of desktop pages and 91.51% of mobile pages, up slightly from around 89% across devices in 2024\.  While growth has slowed, HTTPS has effectively become the default for most of the web. The small remaining gap represents older or low-maintenance sites that have yet to migrate. As a result, HTTPS now functions less as a differentiator and more as a baseline expectation for both users and search engines.

Still, full universal encryption isn't trivial. [Google's transparency reports](https://transparencyreport.google.com/https/overview?hl=en) note persistent obstacles. Some countries and organisations block or degrade HTTPS traffic, and organizations with limited technical capacity may deprioritize it. Even Google's products face challenges, such as managing certificates for user-owned domains (e.g. in Blogger), as it can be complex when those domains don't natively support HTTPS. These constraints help explain why a small share of sites still lag behind.


{{ figure_markup(  
  image="",  
  caption="HTTPS usage",  
  description="Bar chart showing HTTPS usage across different page types. Home pages use HTTPS on 84.64% of desktop sites and 86.64% of mobile sites. Inner pages use HTTPS on 92.42% of desktop sites and 93.45% of mobile sites.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=2039418375\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=2039418375&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="lighthouse-seo-stats-2025.sql"  
  )  
}}

### Mobile-friendliness {#mobile-friendliness}

Google completed its migration to mobile-first indexing in 2023, meaning the mobile version of websites now determines search rankings. The following data examines how widely sites have adopted mobile-friendly design practices in response.

#### Viewport meta tag  {#viewport-meta-tag}

The `viewport` meta tag defines how a page scales and displays across different screen sizes, making it a key element of responsive web design. Introduced with the rise of mobile browsing, it ensures that content adapts smoothly to various devices without forcing users to zoom or scroll horizontally.

Use of the `viewport` meta tag is almost universal, appearing on 93.1% of desktop pages and 95.2% of mobile pages. This shows that responsive design principles are widely used across modern websites. The narrow desktop–mobile difference means developers are using consistent responsive design approaches across all devices rather than maintaining separate mobile and desktop codebases, signaling some maturity in mobile-friendly design practices.


{{ figure_markup(  
  image="",  
  caption="Meta viewport usage",  
  description="Bar chart showing `meta viewport` tag usage across websites. The median percentage of pages with `meta viewport` tags is 93.10% for desktop sites and 95.17% for mobile sites.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1734425605\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1734425605&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="lighthouse-seo-stats-2025.sql"  
  )  
}}

#### Vary header usage {#vary-header-usage}

Once a standard tool for dynamic serving, the Vary: User-Agent header is now nearly extinct. In 2025, only about 1% of pages include it, with nearly all sites opting for unified rendering. This shift aligns with the widespread adoption of the `viewport` meta tag (over 95%) and Google's move to mobile-first indexing, which reduced the need to maintain separate mobile and desktop versions of a site. The web has largely consolidated around responsive, single-version design.


{{ figure_markup(  
  image="",  
  caption="\`Vary\` header user",  
  description="Bar chart showing \`Vary\` header usage across websites, comparing client-rendered and server-rendered pages. The \`Vary\` header is not used (FALSE) on 100% of client-rendered pages and 99.77% of server-rendered pages, while it is used (TRUE) on only 0.23% of client-rendered pages and 1% of server-rendered pages.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=908000907\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=908000907&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="html-response-vary-header-used-2025.sql"  
  )  
}}

### Legible font sizes {#legible-font-sizes}

Legibility is one of the most fundamental aspects of mobile experience. Users should be able to read content comfortably without zooming or straining, and accessibility standards reinforce that. According to the Web Content Accessibility Guidelines ([WCAG](https://www.w3.org/WAI/WCAG21/Understanding/resize-text.html#)), body text should be at least 16px (1rem), with the ability to scale up to 200% without breaking layout or functionality. 

[Lighthouse's](https://developer.chrome.com/docs/lighthouse/seo/font-size) legible font size audit uses a similar benchmark, flagging pages where less than 60% of visible text exceeds 12px. In 2025, 92% of mobile pages passed this test, mirroring 2024's performance and indicating that most sites now meet basic readability standards across both home pages and inner pages.


{{ figure_markup(  
  image="",  
  caption="Legible font size used (mobile)"  
  description="Bar chart showing legible font sizes (16px or larger) usage on mobile pages. Legible font sizes are used on 92.07% of home pages and 92.93% of inner pages.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1856892869\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1856892869&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="lighthouse-seo-stats-2025.sql"  
  )  
}}

### Core Web Vitals {#core-web-vitals}

Core Web Vitals (CWV) measure how real users experience a page, focusing on loading (Largest Contentful Paint, LCP), interactivity (now measured by Interaction to Next Paint, INP), and visual stability (Cumulative Layout Shift, CLS). 

In 2025, performance across Core Web Vitals has largely stabilized after several years of steady year-on-year improvement. Desktop continues to lead in CWV performance, with around 60% of pages delivering a "good" overall CWV experience, compared to just over 50% on mobile. (We should also bear in mind that desktop, in many sectors like finance, is the preferred device.) The difference reflects desktop's inherent advantages, such as faster hardware, stronger connections, and fewer layout constraints.

Across both platforms, CLS remains the strongest metric, with around 75% of pages passing. However, LCP continues to lag near 55–60%, showing that loading speed remains the most persistent CWV challenge for websites today. As [research shows](https://www.speedcurve.com/blog/psychology-site-speed/), this affects user satisfaction, and can also impact online conversions, particularly in an AI-driven landscape. 

The visible flattening from late 2023 onward likely reflects the transition toward Google's [March 2024 replacement of First Input Delay](https://searchengineland.com/google-replace-fid-inp-core-web-vitals-414546#:~:text=Interaction%20to%20Next%20Paint%20\(INP,nearly%20all\)%20interactions%20were%20below.&text=On%20the%20left%2C%20long%20tasks,rankings%2C%E2%80%9D%20according%20to%20Splitt.) (FID) with Interaction to Next Paint (INP). INP began surfacing in performance tools ahead of the rollout, introducing stricter thresholds that exposed responsiveness issues FID often overlooked. This gradual shift raised the bar for what's considered a "good" user experience and explains the early signs of stagnation before the full change took effect.

*Description:* 

{{ figure_markup(  
  image="",  
  caption="% of good CWV experiences (desktop)"  
  description="Line chart showing the percentage of good Core Web Vitals experiences on desktop from January 2020 to June 2025\. In June 2025, 55% of pages achieved good Largest Contentful Paint (LCP) scores, 100% achieved good First Input Delay (FID) scores, 73% achieved good Cumulative Layout Shift (CLS) scores, and 56% achieved good overall Core Web Vitals (CWV) scores. Performance improved steadily over time across all metrics except FID, which remained consistently high until it was replaced by the Interaction to Next Paint (INP) metric on March 12, 2024.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1199819818\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1199819818&format=interactive) ",  
  sheets_gid="1895020036",  
  sql_file="core-web-vitals-2025.sql"  
  )  
}}


{{ figure_markup(  
  image="",  
  caption="Percentage of good CWV experiences (mobile)"  
  description="Line chart showing the percentage of good Core Web Vitals experiences on mobile from January 2020 to June 2025\. In June 2025, 56% of pages achieved good Largest Contentful Paint (LCP) scores, 100% achieved good First Input Delay (FID) scores, 79% achieved good Cumulative Layout Shift (CLS) scores, and 53% achieved good overall Core Web Vitals (CWV) scores. Performance improved significantly over time across all metrics, with FID remaining consistently high throughout the period until it was replaced by the Interaction to Next Paint (INP) metric on March 12, 2024.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1667754305\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1667754305&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="core-web-vitals-2025.sql"  
  )  
}}

### Image \`loading\` property usage {#image-`loading`-property-usage}

The `loading` attribute tells the browser when to fetch and render an image. it is a built-in performance hint that helps balance speed and resource use. Two main values shape how it behaves:

* lazy \- delays loading images until they're close to appearing on screen, reducing initial page weight and improving perceived performance.

* eager \- fetches images as soon as the page loads, ensuring instant visibility for above-the-fold visuals like hero banners or logos.

This attribute allows developers to fine-tune loading behavior for different contexts, prioritizing key visuals while deferring less critical ones to improve load times and bandwidth efficiency.

In 2025, around 68% of images (across both desktop and mobile) have no image loading attribute set, leaving loading behavior to browser defaults. Meanwhile, around 26% use lazy loading, and just 4-5% explicitly use eager loading.

The pattern is consistent across page types:

* Home pages: 27.3% (desktop) and 27.7% (mobile) lazy loaded  
* Inner pages: 25.6% (desktop) and 25.3% (mobile) lazy loaded


The dominance of missing image loading attributes suggests lazy loading adoption remains concentrated among performance-focused sites, while many others (likely legacy or CMS-driven sites)  haven't implemented explicit loading strategies. Given near-universal browser support for `loading="lazy" and responsive design`, the majority of images could benefit from explicit lazy loading to improve perceived performance and reduce bandwidth usage.

*Description:* 

{{ figure_markup(  
  image="",  
  caption="Image \`loading\` properties"  
  description="Bar chart showing image loading attribute usage across websites. The lazy loading attribute is used on 68.10% of desktop images and 68.18% of mobile images. The eager loading attribute is used on 26.5% of desktop images and 26.6% of mobile images. The auto loading attribute is used on 5.06% of desktop images and 5.04% of mobile images. Images with missing loading attributes account for 0.11% on both desktop and mobile.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1802101112\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1802101112&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="image-loading-property-usage-2025.sql"  
  )  
}}

*Description:* 

{{ figure_markup(  
  image="",  
  caption="Home page Image \`loading\` properties"  
  description="Bar chart showing image \`loading\` attribute usage on home pages. The \`missing\` loading attribute is used on 66.97% of desktop home page images and 66.67% of mobile home page images. The \`lazy\` loading attribute is used on 27.30% of desktop home page images and 27.66% of mobile home page images. The \`eager\` loading attribute is used on 5.40% of desktop home page images and 5.43% of mobile home page images.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=186621260\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=186621260&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="image-loading-property-usage-2025.sql"  
  )  
}}


{{ figure_markup(  
  image="",  
  caption="Inner page Image \`loading\` properties"  
  description="Bar chart showing image \`loading\` attribute usage on inner pages. Images with missing \`loading\` attributes account for 69.86% of desktop inner page images and 69.86% of mobile inner page images. The \`lazy\` loading attribute is used on 25.34% of desktop inner page images and 25.34% of mobile inner page images. The eager loading attribute is used on 4.60% of desktop inner page images as well as on mobile inner page images. The \`auto\` loading attribute is used on 0.10% of desktop inner page images and 0.10% of mobile inner page images. Images with invalid \`loading\` attributes account for 0.06% on both desktop and mobile inner pages. Images with blank \`loading\` attributes account for 0.04% on both desktop and mobile inner pages.",  
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=132795067\&format=interactive",  
  sheets_gid="1895020036",  
  sql_file="image-loading-property-usage-2025.sql"  
  )  
}}

### \`lazy\` loading vs. \`eager\` loading iframes {#`lazy`-loading-vs.-`eager`-loading-iframes}

Simply adding `loading="lazy"` to an iframe delays loading until it is near the viewport, saving around 500KB for a [YouTube embed](https://web.dev/articles/iframe-lazy-loading) or [200KB for a Facebook widget](https://web.dev/learn/performance/lazy-load-images-and-iframe-elements). Yet, iframe loading attributes remain significantly underutilized in 2025, with 91.5% of desktop pages and 91.2% of mobile pages lacking any declared iframe loading properties—down only slightly from 92.8% (desktop) and 92.6% (mobile) in 2024\. 

Explicit iframe lazy loading attributes appear on roughly 13% of pages (3.5% standalone, plus 9.3% mixed with missing declarations), often inconsistently applied alongside non-declared iframes. As in previous years, this pattern likely reflects the dominance of embedded third-party elements such as ads, videos, and analytics dashboards, which publishers have limited control over. Explicit `eager` declarations remain virtually nonexistent (0.2% for both desktop and mobile), as they simply restate browser defaults. Despite the opportunity for substantial performance gains, iframe lazy loading adoption continues to lag far behind image lazy loading.

The inconsistency largely reflects how third-party embeds—such as ads, video players, and analytics dashboards—dominate iframe usage. Because these elements are controlled externally, publishers have limited ability to define loading behavior or add attributes directly. In many cases, third-party scripts inject iframes dynamically after load, which means crawlers and audits don't detect their `loading` attributes even when they exist. As a result, some of the apparent "missing" attributes may represent visibility gaps in measurement rather than true omissions.

This also ties to developer prioritization: teams typically focus on optimizing the performance of first-party assets (images, scripts, Core Web Vitals) before addressing iframe behavior, which is harder to control and yields smaller incremental gains. 


{{ figure_markup(  
  image="",  
  caption="\`iframe\` image loading properties"  
  description="Bar chart showing \`iframe\` loading attribute usage patterns. Iframes with missing loading attributes appear in 91.5% of desktop sites and 91.2% of mobile sites. Iframes with lazy loading and missing attributes appear in 9.5% of desktop sites and 9.3% of mobile sites. Iframes with lazy loading appear in 3.2% of desktop sites and 3.5% of mobile sites. Iframes with auto loading and missing attributes appear in 0.9% of desktop sites and 0.8% of mobile sites. Iframes with eager loading and missing attributes appear in 0.2% of desktop sites and 0.2% of mobile sites. Iframes with auto loading appear in 0.1% of desktop sites and 0.1% of mobile sites.",  
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1842542140\&format=interactive",  
  sheets_gid="1895020036",  
  sql_file="iframe-loading-property-usage-2025.sql"  
  )  
}}

## On-Page {#on-page}

Page structure still matters in the current AI-driven landscape. Titles, meta descriptions, and headings communicate meaning and intent, while media attributes reinforce clarity and accessibility. The 2025 data shows overall stability in how these elements are used, with only minor shifts reflecting incremental adjustments rather than major changes.

### **Metadata** {#metadata}

Title tag adoption remains nearly universal, climbing slightly in 2025 to 98.62% of desktop pages and 98.54% of mobile pages, up from 2024's 98.0% desktop and 98.2% mobile rates. This steadiness reflects the element's enduring role in SEO strategy despite widespread title rewrites in search results. Publishers seem to still view title tags as foundational regardless of display control.

Meta descriptions, by contrast, have followed a different trajectory. After falling from appearing on 71% of pages in 2022 to 66.7% (desktop) and 66.4% (mobile) in 2024, they rebounded modestly in 2025 to 67.71% (desktop) and 67.19% (mobile). While adoption has not fully recovered to earlier 2022 levels, the uptick this year suggests publishers continue to see value in meta descriptions for click-through optimization and cross-platform consistency, even though Google may rewrite them.


{{ figure_markup(  
  image="",  
  caption="\`title\` tag and meta description"  
  description="Bar chart showing title tag and meta description presence across websites. Title tags are present on 98.62% of desktop pages and 98.54% of mobile pages. Meta descriptions are present on 67.71% of desktop pages and 67.19% of mobile pages.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=870468193\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=870468193&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="seo-stats-2025.sql"  
  )  
}}

### **\`\<title\>\` element length** {#`<title>`-element-length}

Title tags are one of the clearest signals of a page's topic for both users and algorithms, but their effectiveness depends partly on length. Too short, and they miss context; too long, and they risk truncation in search results. The 2025 data shows that publishers continue to cluster around stable midpoints, with little change from 2024\.

* **Words:** The median title tag contains 12 words across both desktop and mobile, unchanged from last year. At the 75th percentile, titles rise to 18 words, and at the 90th percentile, they extend to 24 words on desktop and 25 on mobile.

* **Characters:** Median title lengths sit at 77 characters on desktop and 79 on mobile, nearly identical to 2024\. At the 75th percentile, lengths climb to 116–117, while the 90th percentile reaches 150–154 characters.

These numbers sit well above the often-cited 50–60 character "safe range" for titles, suggesting publishers are prioritizing keyword coverage and context even if display is truncated. 

The persistence of this pattern from 2024 into 2025 may also reflect Google's rewriting practices. Since titles are frequently modified in the SERPs, publishers face less incentive to fine-tune them to pixel-perfect display limits.


{{ figure_markup(  
  image="",  
  caption="Title words by percentile"  
  description="Line chart showing \`title\` tag word count distribution across percentiles. At the 10th percentile, \`title\` tags contain 3 words on desktop and 4 words on mobile. At the 25th percentile, they contain 7 words on both desktop and mobile. At the 50th percentile (median), they contain 12 words on both desktop and mobile. At the 75th percentile, they contain 18 words on both desktop and mobile. At the 90th percentile, they contain 24 words on desktop and 25 words on mobile.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=737860354\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=737860354&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="seo-stats-by-percentile-2025.sql"  
  )  
}}


{{ figure_markup(  
  image="",  
  caption="Title characters by percentile"  
  description="Bar chart showing \`title\` tag character count distribution across percentiles. At the 10th percentile, \`title\` tags contain 28 characters on both desktop and mobile. At the 25th percentile, they contain 46 characters on desktop and 47 on mobile. At the 50th percentile (median), they contain 77 characters on desktop and 79 on mobile. At the 75th percentile, they contain 116 characters on desktop and 117 on mobile. At the 90th percentile, they contain 150 characters on desktop and 154 on mobile.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1675479095\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1675479095&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="seo-stats-by-percentile-2025.sql"  
  )  
}}

### Meta description length  {#meta-description-length}

Distribution patterns have largely stabilized after the sharp growth between 2022 and 2024\. This year's data shows:

* **Median (50th percentile):** 40 words and 274 characters for both desktop and mobile, unchanged from 2024 but more than double the 2022 median of 19 words and \~135 characters.  
* **10th percentile:** 4 words and \~69–70 characters, the same as last year.  
* **25th percentile:** 18–19 words and 166–168 characters.  
* **75th percentile:** 51 words and 329–330 characters.  
* **90th percentile:** 79 words and 533–537 characters.

This distribution confirms that publishers have settled into a comfortable range: long enough to provide substance but generally capped below \~80 words or \~540 characters. Even with Google frequently rewriting snippets, maintaining well-structured descriptions gives site owners a measure of influence over how their content is presented elsewhere. 

In practice, snippet display is constrained by pixel width, (roughly [920–980px](https://ux.stackexchange.com/questions/125770/does-the-980px-screen-width-rule-still-stand) on desktop and 680px on mobile) so truncation varies by character width.

If this pattern holds, well-structured meta descriptions become more than traditional SERP signals: they help determine whether a page is even surfaced for AI-driven summarization or citation.


{{ figure_markup(  
  image="",  
  caption="Meta description by percentile"  
  description="Line chart showing meta description word count distribution across percentiles. At the 10th percentile, meta descriptions contain 4 words on both desktop and mobile. At the 25th percentile, meta descriptions contain 18 words on desktop and 19 on mobile. At the 50th percentile (median), meta descriptions contain 40 words on both desktop and mobile. At the 75th percentile, meta descriptions contain 51 words on both desktop and mobile. At the 90th percentile, meta descriptions contain 79 words on both desktop and mobile.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=2126645889\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=2126645889&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="seo-stats-by-percentile-2025.sql"  
  )  
}}


{{ figure_markup(  
  image="",  
  caption="Meta description by percentile"  
  description="Line chart showing meta description character count distribution across percentiles. At the 10th percentile, meta descriptions contain 69 characters on desktop and 70 on mobile. At the 25th percentile, meta descriptions contain 166 characters on desktop and 168 on mobile. At the 50th percentile (median), meta descriptions contain 274 characters on both desktop and mobile. At the 75th percentile, meta descriptions contain 329 characters on desktop and 330 on mobile. At the 90th percentile, meta descriptions contain 537 characters on desktop and 533 on mobile.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1000016762\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1000016762&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="seo-stats-by-percentile-2025.sql"  
  )  
}}

### **Heading tags** {#heading-tags}

Well-structured headings do more than format text; they map the logical flow of a page, guiding both readers and crawlers through its main ideas. The 2025 data shows stability across all major tags, with only marginal shifts from last year.

* \<h1\>: Present on 71% of desktop pages and 70% of mobile pages. Non-empty usage is slightly lower at 66% for both.

* \<h2\>: The most widely adopted, at 72% of desktop pages and 71% of mobile, with nearly all non-empty.

* \<h3\>: Used by 60% of pages, with 58% non-empty, unchanged from 2024\.

* \<h4\>: Present on 37% of desktop pages and 36% of mobile, with 35–36% containing meaningful content.

Adoption of heading tags has clearly leveled off. Earlier years saw \<h1\> growth and \<h3\>/\<h4\> declines, but 2025 confirms a steady pattern. 

The non-empty data is especially telling. The gap between "present" and "non-empty" is now just a few percentage points, compared to wider gaps in 2022 (around 6% of desktop \<h1\>s were empty). This suggests cleaner, more semantically structured markup, with empty headings now the exception rather than the norm.

Beyond accessibility and SEO, this refinement in heading structure also aligns with a wider trend: publishers optimizing on-page clarity for AI-driven platforms. As AI overviews, summarizers, and citation systems increasingly rely on clean semantic hierarchies to extract and attribute information, well-structured headings have become part of ensuring a page's ideas are accurately represented \- and credited \- in AI outputs.

Still, progress has limits. \<h1\>s appear on 70% of pages, but only 66% are non-empty. That 4% gap points to a ceiling effect, a natural upper limit where adoption is unlikely to reach 100%. Some designs, like single-page apps or minimalist home pages, deliberately skip meaningful \<h1\>s. These cases reflect design choices rather than errors.


*Description:*

{{ figure_markup(  
  image="",  
  caption="Presence of heading elements"  
  description="Bar chart showing the presence of heading elements across websites. H1 are present on 71% of desktop pages and 70% of mobile pages. H2 elements are present on 72% desktop and 71% mobile. H3 elements are present on 60% desktop and 60% mobile. H4 elements are present on 37% desktop and 36% mobile.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=2085727321\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=2085727321&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="seo-stats-2025.sql"  
  )  
}}


{{ figure_markup(  
  image="",  
  caption="Non-empty heading elements"  
  description="Bar chart showing non-empty heading elements across websites. Non-empty H1 elements are present on 66% of desktop pages and mobile pages. Non-empty H2 elements are present on 71% of desktop pages and 70% of mobile pages. Non-empty H3 elements are present on 58% of desktop pages and mobile pages. Non-empty H4 elements are present on 36% of desktop pages and 35% of mobile pages.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=813206574\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=813206574&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="seo-stats-2025.sql"  
  )  
}}

### **Images** {#images}

The 2025 data on image usage shows broad consistency with prior years, but also underscores how image use scales dramatically toward the upper end of sites.

* At the median (50th percentile), home pages include 20 images on desktop and 19 on mobile.

* At the 75th percentile, image counts rise to 44 images on desktop and 41 on mobile.

* At the 90th percentile, image use jumps even further to 85 on desktop and 80 on mobile.

By comparison, the 25th percentile sits at just 8 images, showing the wide variation in home page design. Yet across the distribution, desktop and mobile numbers remain closely aligned, suggesting responsive design practices continue to keep image use consistent across devices.

{{ figure_markup(  
  image="",  
  caption="Home page images per device"  
  description="Line chart showing the distribution of image counts on home pages across percentiles. At the 10th percentile, home pages have 2 images on both desktop and mobile. At the 25th percentile, 8 images on both desktop and mobile. At the 50th percentile have 20 images on desktop and 19 on mobile. At the 75th percentile have 44 images on desktop and 41 on mobile. At the 90th percentile have 85 images on desktop and 80 on mobile.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1589362695\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1589362695&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="image-alt-stats-2025.sql"  
  )  
}}  

{{ figure_markup(  
  image="",  
  caption="Images per page"  
  description="Line chart showing the distribution of image counts per page across percentiles. At the 10th percentile, pages have 4 images on desktop and 3 on mobile. At the 25th percentile, pages have 16 images on desktop and 8 on mobile. At the 50th percentile (median), pages have 39 images on desktop and 21 on mobile. At the 75th percentile, pages have 85 images on desktop and 52 on mobile. At the 90th percentile, pages have 165 images on desktop and 109 on mobile.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1981015938\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1981015938&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="image-alt-stats-2025.sql"  
  )  
}}

#### **Alt attributes** {#alt-attributes}

The `alt` attribute is central to accessibility and also supports image indexing in search. This year sees steady improvement in adoption, with fewer missing attributes overall, but also a slight rise in blank values worth noting.

* **Presence:** At the median, 60% of images on mobile pages included `alt` attributes, up from 58% in 2024\. By the 90th percentile, adoption reaches 100%, showing that a significant share of publishers consistently apply alt text to all images.

* **Blank attributes:** At the median, 15% of images on mobile pages carried blank alt values, up just one point from 14% in 2024\. At the 75th percentile, 58% were blank, and at the 90th percentile, 90% were blank—both also one point higher than last year. The increase is small, but it flags the concern that not all adoption translates into meaningful descriptions.

* **Missing attributes:** The median page again shows no missing alts, continuing the positive trend from 2022 when 12–13% of pages lacked them entirely.

The broader shift appears to be from "missing" to "blank." Images are more likely to have an attribute in place, but not always with descriptive content. While blanks are preferable to omissions, they offer limited value for screen readers and search engines.

Although the increase in blanks is small and steady rather than dramatic, it still underscores the gap between technical compliance and meaningful accessibility. With home page image counts ranging from as few as 8 to more than 80 in 2025, the importance of thoughtful alt text only grows. The web is clearly moving in the right direction, but the challenge is ensuring that progress in coverage also delivers progress in accessibility and meaning.


{{ figure_markup(  
  image="",  
  caption="Percentage of image alt attributes present"  
  description="Line chart showing the distribution of image alt attribute presence across percentiles. At the 10th percentile, 0% of images have alt attributes on both desktop and mobile. At the 25th percentile, 17% of images have alt attributes on desktop and 16% on mobile. At the 50th percentile (median), 60% of images have alt attributes on desktop and 60% on mobile. At the 75th percentile, 93% of images have alt attributes on desktop and 93% on mobile. At the 90th percentile, 100% of images have alt attributes on both desktop and mobile.",  
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=903246628\&format=interactive",  
  sheets_gid="1895020036",  
  sql_file="image-alt-stats-2025.sql"  
  )  
}}  

{{ figure_markup(  
  image="",  
  caption="Percentage of image with blank image alt"  
  description="Line chart showing the distribution of images with blank alt attributes across percentiles. At the 10th and 25th percentiles, 0% of images have blank alt attributes on both desktop and mobile. At the 50th percentile (median), 15.38% of images have blank alt attributes on both desktop and mobile. At the 75th percentile, 57% of images have blank alt attributes on desktop and 58% on mobile. At the 90th percentile, 89% of images have blank alt attributes on desktop and 90% on mobile.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1901156374\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1901156374&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="image-alt-stats-2025.sql"  
  )  
}}


{{ figure_markup(  
  image="",  
  caption="Percentage of image with alt image missing"  
  description="Line chart showing the distribution of images with missing alt attributes across percentiles. At the 10th and 25th percentiles, 0% of images are missing alt attributes on both desktop and mobile. At the 50th percentile (median), 15% of images are missing alt attributes on both desktop and mobile. At the 75th percentile, 57% of images are missing alt attributes on desktop and 58% on mobile. At the 90th percentile, 89%  of images are missing alt attributes on desktop and 90% on mobile.",  
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=385799990\&format=interactive",  
  sheets_gid="1895020036",  
  sql_file="image-alt-stats-2025.sql"  
  )  
}}

### **Video**  {#video}

Video adoption on the web continues to grow, but only gradually. In 2025, 6.40% of desktop pages and 5.68% of mobile pages included a video element, up slightly from 5.87% (desktop) and 5.13% (mobile) in 2024\. Desktop pages still feature video more often than mobile, repeating the same gap as last year.

The modest growth might reflect video's higher production and implementation costs compared to images. But the long-term trajectory remains upward. As SEO becomes more holistic and branding emerges as one of the strongest signals across the web, video is likely to play a larger role in reinforcing authority and cross-channel visibility.

The bigger challenge is optimization. While videos are appearing more often, only 0.9% of pages in 2024 used VideoObject markup, leaving most video content invisible to rich results. Until structured data adoption rises, much of video's SEO potential will remain untapped.


{{ figure_markup(  
  image="",  
  caption="Percentage of pages with video"  
  description="Chart showing the percentage of pages that contain video elements. Videos are present on 6.40% of desktop pages and 5.68% of mobile pages.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1648531612\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1648531612&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="pages-containing-a-video-element-2025.sql"  
  )  
}}

## Links {#links}

Links were once the dominant signal of importance. More links usually meant higher rankings but today they are balanced alongside content quality, relevance, and user experience. 

Our 2025 data shows that link practices have matured, with stable patterns in descriptive anchors, internal navigation, and external references, alongside selective use of attributes like rel to qualify relationships.

### **Non-descriptive links** {#non-descriptive-links}

In 2025, most sites continue to provide descriptive anchor text rather than vague phrases like "Click here" or "Read more." This is reflected in Lighthouse test pass rates, which remain high across both home pages and inner pages.

* 2024: Home pages passed at 84% (desktop) and 91% (mobile), while inner pages were stronger at 86% (desktop) and 92% (mobile).

* 2025: Home pages are nearly unchanged at 84.64% (desktop) and 86.64% (mobile), but inner pages improved to 92.42% (desktop) and 93.45% (mobile).

The gap between home pages and inner pages persists, with inner pages consistently \~6–9 points higher. This likely reflects how home pages rely more on generic navigation and promotional CTAs, while inner pages use contextual, content-driven links that are naturally more descriptive. Device parity remains close, indicating that responsive design practices are effectively maintaining accessibility standards across devices.

Overall, descriptive link practices appear mature, with only marginal year-over-year changes. The remaining opportunity lies in improving home page link clarity, where vague CTAs are still most common.

{{ figure_markup(  
  image="",  
  caption="Pages passing links have descriptive text"  
  description="Bar chart showing the percentage of pages with links that have descriptive text. Home pages have descriptive link text on 84.64% of desktop sites and 86.64% of mobile sites. Inner pages have descriptive link text on 92.42% of desktop sites and 93.45% of mobile sites.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=791832113\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=791832113&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="lighthouse-seo-stats-2025.sql"  
  )  
}}

### **Outgoing links** {#outgoing-links}

Outgoing links in 2025 see stable patterns for both internal and external linking. Internal links dominate; at the median, desktop pages contained 43 links to the same site and mobile pages 39, while at the 90th percentile those numbers jumped to 174 and 161\. 

This steep climb toward the high end might be a reflection of how larger or more complex sites (often news outlets, e-commerce platforms, or enterprise portals) surface extensive navigation through mega-menus and dense footers. Desktop pages consistently show a few more links than mobile, since developers streamline menus on smaller screens for ease of use, but they still keep the key pathways intact.

External linking remains far lighter. The median page included just six outbound links across both desktop and mobile, and even at the 90th percentile the numbers only reached 25 and 24\. This continues the flat trend noted in 2024, which itself mirrored 2022\.

Internal links have grown steadily over the years, while external links remain conservative, likely reflecting publisher focus on keeping users within their own ecosystems. Together, the figures suggest a mature equilibrium. Internal linking grows to support navigation and crawlability, while external linking holds steady at modest levels.


{{ figure_markup(  
  image="",  
  caption="Outgoing links to the same site"  
  description="Line chart showing the distribution of outgoing links to the same site across percentiles. At the 10th percentile, pages have 7 outgoing links to the same site on desktop and 6 on mobile. At the 25th percentile, pages have 19 on desktop and 17 on mobile. At the 50th, pages have 43 on desktop and 39 on mobile. At the 75th percentile, pages have 89 on desktop and 82 on mobile. At the 90th percentile, pages have 174 outgoing links on desktop and 161 on mobile.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=977071429\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=977071429&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="seo-stats-by-percentile-2025.sql"  
  )  
}}  

{{ figure_markup(  
  image="",  
  caption="Outgoing links to external sites"  
  description="Line chart showing the distribution of outgoing links to external sites across percentiles. At the 10th percentile, pages have 1 outgoing link to external sites on both desktop and mobile. At the 25th percentile, pages have 3 outgoing links on desktop and 2 on mobile. At the 50th percentile (median), pages have 6 outgoing links on both desktop and mobile. At the 75th percentile, pages have 13 outgoing links on desktop and 12 on mobile. At the 90th percentile, pages have 25 outgoing links on desktop and 24 on mobile.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=209692578\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=209692578&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="seo-stats-by-percentile-2025.sql"  
  )  
}}

### **Anchor rel attribute use** {#anchor-rel-attribute-use}

Although the `rel` attribute was originally intended to qualify links for search engines, its most common uses today are security-focused. In 2025, noopener appears on 40.9% of pages and noreferrer on 25%. Although neither affects positioning, both help increase site health and protect users by preventing tab hijacking and hiding referral data, which explains their widespread adoption.

For search-related qualifiers, nofollow continues to dominate at 32.3% of pages, nearly identical to 2024 levels. By contrast, the more specific sponsored and ugc attributes remain stuck at 0.5% each. Despite Google's efforts to promote finer-grained classifications, adoption has not moved, suggesting webmasters still see little value in going beyond the broad "nofollow vs. normal link" distinction.

Taken together, the data shows that usage patterns for rel attributes have largely stabilized, with little year-over-year movement. Security practices lead usage, SEO qualifiers remain steady, and experimental attributes show no momentum. Even outdated attributes like dofollow and follow linger on fewer than 0.5% of pages, a reminder that old SEO myths still echo in small corners of the web without a practical effect.


{{ figure_markup(  
  image="",  
  caption="Anchor \`rel\` attribute usage"  
  description="Bar chart showing anchor \`rel\` attribute usage across websites. The \`noopener\` attribute appears in 41.8% of desktop and 40.9% of mobile sites. The \`nofollow\` attribute appears in 30.8% of desktop and 32.3% of mobile sites. The \`noreferrer\` attribute appears in 25.5% of desktop and 25% of mobile sites. The \`ugc\` attribute appears in 0.6% of desktop and 0.5% of mobile sites. The \`sponsored\` attribute appears in 0.5% of desktop and 0.5% of mobile sites. The \`follow\` attribute appears in 0.4% of desktop and 0.4% of mobile sites. The \`dofollow\` attribute appears in 0.3% of desktop and 0.4% of mobile sites.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=59900496\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=59900496&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="anchor-rel-attribute-usage-2025.sql"  
  )  
}}

## **Word count** {#word-count}

### Rendered word count {#rendered-word-count}

Rendered word count refers to the number of visible words on a page after JavaScript has been executed. 

### Home pages' rendered word count  {#home-pages'-rendered-word-count}

The median mobile home page in 2025 contained 378 words, up slightly from 2024 where the median was 364 words. The median rendered word count on desktop home pages was also up slightly year over year, with 2025 showing 413 words (up from 400 words in 2024).   
Both mobile and desktop rendered word counts have seen a decline since 2022, which had a median rendered word count of 421 words on desktop and 366 words on mobile. The parity between desktop and mobile is marginally closer in 2025 compared to last year, with the gap between mobile and desktop home page word counts narrowing to just 35 words, down by 1 from 2024's report where the desktop-mobile parity was 36 words. This indicates some consistency year over year.    
*Description:* 

{{ figure_markup(  
  image="",  
  caption="Home page rendered visible words by percentile"  
  description="Line chart showing home page rendered visible word count distribution across percentiles. At the 10th percentile, home pages have 75 rendered visible words on desktop and 69 on mobile. At the 25th percentile, home pages have 196 rendered visible words on desktop and 177 on mobile. At the 50th percentile (median), home pages have 413 rendered visible words on desktop and 378 on mobile. At the 75th percentile, home pages have 760 rendered visible words on desktop and 703 on mobile. At the 90th percentile, home pages have 1,295 rendered visible words on desktop and 1,191 on mobile.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=184044274\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=184044274&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="seo-stats-by-percentile-2025.sql"  
  )  
}}

### Inner pages' rendered word count {#inner-pages'-rendered-word-count}

Inner pages tend to contain fewer words overall compared to home pages. The median mobile inner page in 2025 had 339 (desktop) words, while mobile had 323 words (This is up from 2024 when the median desktop word count was 333 and the mobile word count was 317.)

Percentiles here represent the position of a page's word count relative to the entire dataset of inner pages—for example, the 90th percentile reflects pages with more words than 90% of all tested pages. Interestingly, up until the 50th percentile, the general trend is that desktop inner pages generally have more words than mobile inner pages, but as the percentiles get higher, the gap narrows. In the 90th percentile, there is a significant increase in mobile inner page word count compared to desktop. This trend is not replicated with home page content, where desktop always has higher word counts. 

### 


{{ figure_markup(  
  image="",  
  caption="Inner page rendered visible words by percentile"  
  description="Line chart showing inner page rendered visible word count distribution across percentiles. At the 10th percentile, inner pages have 76 rendered visible words on desktop and 64 on mobile. At the 25th percentile, inner pages have 161 rendered visible words on desktop and 142 on mobile. At the 50th percentile (median), inner pages have 339 rendered visible words on desktop and 323 on mobile. At the 75th percentile, inner pages have 668 rendered visible words on desktop and 675 on mobile. At the 90th percentile, inner pages have 1,232 rendered visible words on desktop and 1,313 on mobile.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=90196654\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=90196654&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="seo-stats-by-percentile-2025.sql"  
  )  
}}

Raw word count

The raw word count refers to the total number of words included in the original HTML delivered by the server, prior to any JavaScript execution or subsequent alterations to the DOM or CSSOM.

### Home pages' raw word count {#home-pages'-raw-word-count}

The median page's raw word count in 2025 is 340 words for desktop user agents and  316 words for mobile  – up a small amount from 2024 when the median page's raw word count was 330 words for desktop and 311 words for mobile. 

###

{{ figure_markup(  
  image="",  
  caption="Home page visible raw words by percentile"  
  description="Line chart showing home page visible raw word count distribution across percentiles. At the 10th percentile, home pages have 50 visible raw words on desktop and 46 on mobile. At the 25th percentile, home pages have 151 visible raw words on desktop and 138 on mobile. At the 50th percentile (median), home pages have 340 visible raw words on desktop and 316 on mobile. At the 75th percentile, home pages have 634 visible raw words on desktop and 597 on mobile. At the 90th percentile, home pages have 1,083 visible raw words on desktop and 1,026 on mobile.",  
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=605750705\&format=interactive",  
  sheets_gid="1895020036",  
  sql_file="seo-stats-by-percentile-2025.sql"  
  )  
}}

Inner pages' raw word count

Unlike the raw word count on home pages where mobile did not contain more words than desktop in any percentile, the inner pages' visible word count showed desktop pages having fewer words than mobile pages at the 75th percentile and above.


{{ figure_markup(  
  image="",  
  caption="Inner page visible raw words by percentile"  
  description="Line chart showing inner page visible raw word count distribution across percentiles. At the 10th percentile, inner pages have 48 visible raw words on desktop and 42 on mobile. At the 25th percentile, inner pages have 121 visible raw words on desktop and 108 on mobile. At the 50th percentile (median), inner pages have 280 visible raw words on desktop and 271 on mobile. At the 75th percentile, inner pages have 587 visible raw words on desktop and 604 on mobile. At the 90th percentile, inner pages have 1,109 visible raw words on desktop and 1,204 on mobile.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=536665933\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=536665933&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="seo-stats-by-percentile-2025.sql"  
  )  
}}

### Rendered vs. raw word counts {#rendered-vs.-raw-word-counts}

When the rendered and raw word counts are compared on the home page, the discrepancy is small, with the median showing a difference of 18% on desktop vs 16% on mobile. This has seen growth on mobile, which was just 13.6% in 2024\. 

Across all percentiles, home pages served to desktop user agents have a higher percentage of words visible after rendering versus mobile. This is likely because of common layouts on mobile like accordions where content is hidden, even if it is rendering in the DOM. 

The highest difference across all percentiles between mobile and desktop is just 2%, with some lower percentiles like the 10th percentile showing equal word counts. 

### Home pages' rendered vs. raw word counts {#home-pages'-rendered-vs.-raw-word-counts}

{{ figure_markup(  
  image="",  
  caption="Home page rendered vs raw diff by percentile"  
  description="Line chart showing the difference between rendered and raw word counts on home pages across percentiles, displayed as a ratio. At the 10th percentile, the rendered-to-raw word count ratio is 33% on both desktop and mobile. At the 25th percentile, the ratio is 23% on desktop and 22% on mobile. At the 50th percentile (median), the ratio is 18% on desktop and 16% on mobile. At the 75th percentile, the ratio is 17% on desktop and 15% on mobile. At the 90th percentile, the ratio is 16% on desktop and 14% on mobile.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1342963015\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1342963015&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="seo-stats-by-percentile-2025.sql"  
  )  
}}

In 2025, we saw a significant hike in the 10th percentile with 37% on desktop and 34% on mobile, compared to 28% on desktop and 22% on mobile in 2024\. 

### Inner pages' rendered vs. raw word counts {#inner-pages'-rendered-vs.-raw-word-counts}

The gap between rendered and raw word counts on inner pages sees the biggest gap in the 10th percentile, likely due to reliance on content existing in the HTML but hidden on mobile breakpoints, such as within accordions and tabbed layouts. This closes the gap in the 25th, 50th, and 75th percentile with just a 1% difference and 2% in the 90th percentile.  

The pattern seems to be the more words, the less they rely on client-side rendering, which was also the case in the 2024 chapter.   

{{ figure_markup(  
  image="",  
  caption="Inner page rendered vs raw diff by percentile"  
  description="Line chart showing the difference between rendered and raw word counts on inner pages across percentiles, displayed as a ratio. At the 10th percentile, the rendered-to-raw word count ratio is 37% on desktop and 34% on mobile. At the 25th percentile, the ratio is 25% on desktop and 24% on mobile. At the 50th percentile (median), the ratio is 17% on desktop and 16% on mobile. At the 75th percentile, the ratio is 12% on desktop and 11% on mobile. At the 90th percentile, the ratio is 10% on desktop and 8% on mobile.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=753836011\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=753836011&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="seo-stats-by-percentile-2025.sql"  
  )  
}}

## Structured Data {#structured-data}

While not a direct ranking factor, structured data remains a powerful addition to websites to help search engines to understand the context of the page, while also powering rich results in search engine results pages (SERPs) . 

[Structured data](https://insightland.org/blog/structured-data-ai-search/#) is increasingly being used by large language models to understand what a page represents, not just what it says. Microsoft has confirmed that [Bing uses schema.org](http://schema.org) markup to help its models (including Bing Chat and Copilot) distinguish between expert articles, products, reviews, and FAQs. Google's [AI Overviews](https://www.semrush.com/blog/how-can-schema-markup-specifically-enhance-llm-visibility/) behavior suggests a similar reliance, and crawlers such as GPTBot are capable of parsing schema embedded directly in HTML.

### Home pages' structured data {#home-pages'-structured-data}


{{ figure_markup(  
  image="",  
  caption="Home page use of structured data by format"  
  description="Bar chart showing structured data format usage on home pages. JSON-LD format is used on 43% of desktop home pages and 43% of mobile home pages. Microdata format is used on 17% of desktop home pages and 16% of mobile home pages. Microformats2 format is used on 0.14% of desktop home pages and 0.17% of mobile home pages. RDFa format is used on 1% of desktop home pages and 1% of mobile home pages.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=372834420\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=372834420&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="structured-data-formats-2025.sql"  
  )  
}}

Overall usage of structured data grew to 50% on both desktop and mobile in 2025, compared to 48% of desktop home pages and 49% of mobile home pages in 2024\.

The majority of sites provide structured data in raw HTML, while just 2% of mobile and desktop crawls have structured data added via JavaScript (which has not changed compared to 2024). 

While Google can eventually process JavaScript-injected schema, providing it in the initial HTML avoids potential delays, crawling issues, and poor user experience.


{{ figure_markup(  
  image="",  
  caption="Inner page use of structured data by format"  
  description="Bar chart showing structured data format usage on inner pages. JSON-LD format is used on 39% of desktop inner pages and 37% of mobile inner pages. Microdata format is used on 19% of desktop inner pages and 19% of mobile inner pages. Microformats2 format is used on 0.2% of desktop inner pages and 0.2% of mobile inner pages. RDFa format is used on 2% of desktop inner pages and 2% of mobile inner pages.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1584817032\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1584817032&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="structured-data-formats-2025.sql"  
  )  
}}

JSON-LD remains by far the most popular format for home pages and accounts for 43% of both desktop and mobile home pages crawled compared to 41% of desktop and 40% of mobile home pages in 2024\.

Google typically [recommends using JSON-LD structured data](https://developers.google.com/search/docs/appearance/structured-data/intro-structured-data) as it is the easiest form to be implemented and maintained, although Google can still crawl and understand other formats like Microdata and RDFa. We have seen a slight drop in microdata usage, with both desktop and mobile reducing by 1% compared to 2024\. 

### Inner pages' structured data {#inner-pages'-structured-data}

For inner pages, we see a slight difference, with microdata at 19% on mobile and desktop, and JSON-LD at 39% on desktop compared to 37% on mobile. 

This may be because home pages usually receive the most SEO attention and are more likely to have JSON-LD implemented directly, often manually or through a global site template like Organization or Website schema. Because home pages are often prioritized for rich results and brand knowledge panels, JSON-LD adoption rates are typically higher and more consistent across devices. 

In contrast, inner pages like product or article pages often rely on dynamic or CMS-generated markup that can vary between desktop and mobile templates, leading to some slight discrepancies. 

### Most popular structured data types {#most-popular-structured-data-types}

{{ figure_markup(  
  image="",  
  caption="Home page structured data use"  
  description="Bar chart showing the most popular structured data types used on home pages. The schema.org/WebSite type appears on 37% of desktop home pages and 36% of mobile home pages. The schema.org/SearchAction type appears on 28% of desktop home pages and 28% of mobile home pages. The schema.org/Organization type appears on 26.74% of desktop home pages and 26% of mobile home pages. The schema.org/WebPage type appears on 25% of desktop home pages and 25% of mobile home pages. The schema.org/-UnknownType- appears on 24% of desktop home pages and 24% of mobile home pages. The schema.org/ListItem type appears on 21% of desktop home pages and 21% of mobile home pages. The schema.org/BreadcrumbList type appears on 21% of desktop home pages and 21% of mobile home pages. The schema.org/ImageObject type appears on 21% of desktop home pages and 21% of mobile home pages. The schema.org/EntryPoint type appears on 17% of desktop home pages and 17% of mobile home pages. The schema.org/ReadAction type appears on 14% of desktop home pages and 14% of mobile home pages. Additional Schema.org types are shown in the chart.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=2020786426\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=2020786426&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="structured-data-schema-types-2025.sql"  
  )  
}}

There hasn't been a major shift in the top 2 most popular structured data types, with WebSite and SearchAction being the most popular in 2022, 2024, and 2025\. These types power Google's sitelinks search box which, visually, was sunset in November 2024, but there was no need to remove the structured data that supported it. 

We have seen a slight increase in popularity for Organization schema, which overtook WebPage schema (not to be confused with Web**Site** schema) for the first time in 2025's data.

WebSite schema, still the most popular structured data type of all, has seen some slight growth in 2025 for mobile at 36% usage compared to 35% in 2024 and 30% in 2022\. Mobile structured data usage showed only minor differences year over year.  

{{ figure_markup(  
  image="",  
  caption="Inner page structured data use"  
  description="Bar chart showing the most popular structured data types used on inner pages. The schema.org/ListItem type appears on 29% of desktop inner pages and 27% of mobile inner pages. The schema.org/BreadcrumbList type appears on 28% of desktop inner pages and 27% of mobile inner pages. The schema.org/WebSite type appears on 26% of desktop inner pages and 25% of mobile inner pages. The schema.org/Organization type appears on 26% of desktop inner pages and 25% of mobile inner pages. The schema.org/-UnknownType- appears on 26% of desktop inner pages and 25% of mobile inner pages. The schema.org/WebPage type appears on 25% of desktop inner pages and 24% of mobile inner pages. The schema.org/ImageObject type appears on 22% of desktop inner pages and 21% of mobile inner pages. The schema.org/SearchAction type appears on 17% of desktop inner pages and 16% of mobile inner pages. The schema.org/EntryPoint type appears on 15% of desktop inner pages and 14% of mobile inner pages. The schema.org/ReadAction type appears on 14% of desktop inner pages and 13% of mobile inner pages. Additional Schema.org types are shown in the chart.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1147706334\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1147706334&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="structured-data-schema-types-2025.sql"  
  )  
}}

On inner pages, ListItem structured data continues to be the most popular inner page schema type, although mobile usage has dropped from 30% in 2024 to 27% in 2025\. 

Interestingly, WebSite structured data is still the third most popular structured data for inner pages, despite it being a homepage-specific schema type (at least [according to Google](https://developers.google.com/search/docs/appearance/structured-data/organization?_gl=1*jf94bx*_up*MQ..*_ga*OTY2MjgzMjIwLjE3NjIzMjkyODU.*_ga_SM8HXJ53K2*czE3NjIzMjkyODQkbzEkZzAkdDE3NjIzMjkzMDIkajQyJGwwJGgw#guidelines)). This may be due to many types of schema being templated at CMS-level, which may be duplicating it through to inner pages. 

You can find out more about schema usage  in our dedicated {\# TODO: Add internal link to structured data chapter \#} structured data chapter. 

## **AMP** {#amp}

Accelerated Mobile Pages (AMP) were once promoted as a fast-track to performance and visibility, particularly in mobile search. But with Core Web Vitals now providing direct performance metrics for all pages, AMP's role has sharply diminished. The 2025 data shows adoption at consistently low levels across home and inner pages, with usage lingering below 1%. What remains reflects niche or legacy implementations rather than mainstream strategy.

### **Home page AMP usage** {#home-page-amp-usage}

Adoption of AMP markup stayed extremely low in 2025, with inner pages showing only marginal use across all device types. rel=amphtml is the most common signal, appearing on 0.8% of desktop pages and 0.9% of mobile pages, while HTML AMP is seen on just 0.1% of mobile pages and virtually none on desktop. Other variants like AMP Emoji or AMP HTML \+ Emoji are nearly absent, registering at or below 0.2%.

Compared to 2024, the overall picture is one of stagnation. The slight uptick noted in 2024 has not carried forward, and usage continues to hover well below 1%. The shift away from AMP after Google removed its Top Stories requirement and the rise of Core Web Vitals as a universal performance measure have effectively cemented AMP as a fringe technology.

{{ figure_markup(  
  image="",  
  caption="Home page AMP markup desktop vs mobile"  
  description="Bar chart showing AMP markup usage on home pages, comparing desktop and mobile. HTML AMP appears on 0.03% of desktop home pages and 0.2% of mobile home pages. AMP Emoji appears on 0.01% of desktop home pages and 0.1% of mobile home pages. AMP HTML or Emoji appears on 0.04% of desktop home pages and 0.3% of mobile home pages. Rel AMP appears on 0.3% of desktop home pages and 0.7% of mobile home pages.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=172928571\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=172928571&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="mark-up-stats-2025.sql"  
  )  
}}


{{ figure_markup(  
  image="",  
  caption="Inner page AMP markup desktop vs mobile"  
  description="Bar chart showing AMP markup usage on inner pages, comparing desktop and mobile. HTML AMP appears on 0.03% of desktop inner pages and 0.1% of mobile inner pages. AMP Emoji appears on 0.01% of desktop inner pages and 0.02% of mobile inner pages. AMP HTML or Emoji appears on 0.04% of desktop inner pages and 0.2% of mobile inner pages. Rel AMP appears on 0.8% of desktop inner pages and 0.9% of mobile inner pages.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1904991728\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1904991728&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="mark-up-stats-2025.sql"  
  )  
}}

### **Home pages vs inner pages' AMP usage** {#home-pages-vs-inner-pages'-amp-usage}

In 2024, home pages were slightly more likely to feature AMP than inner pages. By 2025, the opposite is true. rel=amphtml appears on 1.7% of inner pages compared with 1.0% of home pages. The same holds for HTML AMP, where adoption is now evenly split (0.1% each). 


{{ figure_markup(  
  image="",  
  caption="AMP Markup Home vs Inner"  
  description="Bar chart comparing AMP markup usage between home pages and inner pages. HTML AMP appears on 0.1% of home pages and 0.1% of inner pages. AMP Emoji appears on 0.03% of home pages and 0.01% of inner pages. AMP HTML or Emoji appears on 0.3% of home pages and 0.2% of inner pages. Rel AMP appears on 1% of home pages and 1.7% of inner pages.",  
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1877255412\&format=interactive",  
  sheets_gid="1895020036",  
  sql_file="mark-up-stats-2025.sql"  
  )  
}}

## Internationalization {#internationalization}

Being a critical feature for international and multilingual websites, the hreflang attribute helps search engines serve the right language or regional version of a page to users, a critical feature for international sites. In 2025, hreflang appears on roughly 20% of pages. Adoption is most often prioritized on home pages, where international targeting has the greatest impact, while inner pages see less consistent coverage. Growth has been steady but uneven, concentrated in a small set of widely used languages.

### **Hreflang implementation** {#hreflang-implementation}

Around one in five pages now include hreflang markup; 20.3% raw (desktop) and 19.7% raw (mobile), with rendered values slightly higher at 20.8% and 20.2% respectively. This essentially doubles last year's rates, where only about 9–10% of pages carried hreflang tags.

HTTP hreflang is nearly gone, with just 0.2% of desktop pages and 0.1% of mobile pages using it. That's consistent with 2024's already tiny share and confirms HTTPS has become the default across almost all internationalized websites.

The close alignment between raw and rendered values (less than a 1% difference) suggests that most sites implementing hreflang are doing so in a technically correct way that survives rendering. This is an improvement over 2024, when gaps were slightly larger.


{{ figure_markup(  
  image="",  
  caption="AMP Markup Home vs Inner"  
  description="Bar chart showing hreflang implementation methods across websites. HTML hreflang tags are used on 0.2% of desktop sites and 0.1% of mobile sites. HTTP header hreflang is used on 20.3% of desktop sites and 19.7% of mobile sites. Sitemap hreflang is used on 20.8% of desktop sites and 20.2%of mobile sites.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1192602854\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=1192602854&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="seo-stats-2025.sql"  
  )  
}}

### **Home page hreflang Usage** {#home-page-hreflang-usage}

Hreflang usage on home pages remains highly concentrated in a few values. English ("en") continues to dominate, appearing on 7.4% of desktop home pages and 7.3% of mobile, followed closely by x-default at 7.2% (desktop) and 6.9% (mobile). 

Secondary languages such as French (3.2% on mobile), German (3.1% mobile), and Spanish (3.0% mobile) round out the next tier, while others like Italian, Russian, Portuguese, Dutch, and Japanese remain below 2.5%.

This concentration underscores that while hreflang adoption has grown to cover 20% of pages overall, most of that usage is focused on a small set of widely targeted audiences. 

Compared to 2024, when "en" appeared on 8% of both desktop and mobile home pages, the 2025 data shows a slight dip. However, adoption across secondary languages has stayed stable, keeping the overall distribution consistent year over year.


{{ figure_markup(  
  image="",  
  caption="Hreflang link usage \- home page"  
  description="Bar chart showing hreflang link usage on home pages by language code. English (en) appears on 7.8% of desktop and 7.4% of mobile. x-default appears on 7.2% of desktop and 6.9% of mobile. French (fr) appears on 3.1% of desktop and 3.2% of mobile. German (de) appears on 2.9% of desktop and 3.1% of mobile. Spanish (es) appears on 2.9% of desktop and 3% of mobile. Italian (it) appears on 2.1% of desktop and 2.4% of mobile. English US (en-us) appears on 2.2% of desktop and 1.9% of mobile. Russian (ru) appears on 1.7% of desktop and 2.1% of mobile. Portuguese (pt) appears on 1.3% of desktop and 1.6% of mobile. Dutch (nl) appears on 1.4% of desktop and 1.5% of mobile. Japanese (ja) appears on 1.2% of desktop and 1.5% of mobile.",  
 chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=247968429\&format=interactive",  
  sheets_gid="1895020036",  
  sql_file="hreflang-link-tag-usage-2025.sql"  
  )  
}}

### **Inner page hreflang usage** {#inner-page-hreflang-usage}

On inner pages, hreflang adoption mirrors the home page pattern but at slightly lower levels. English (en) leads at 7.6% (on desktop pages) and 6.9% (mobile), followed closely by x-default at 7.4% (desktop) and 6.8% (mobile). Secondary languages such as French (3.2% of inner mobile pages), German (3.1% mobile), and Spanish (3.0% mobile) again form the next tier, while all other language values remain under 2.5%.

Compared to 2024, when desktop use of x-default and en was closer to 8%, the 2025 figures suggest a small decline. The distribution again confirms that hreflang is generally prioritized on home pages rather than inner pages. The tight clustering of French, German, and Spanish (3.0-3.2% on inner mobile pages) reinforces that major European markets drive most multilingual web adoption beyond English.  

{{ figure_markup(  
  image="",  
  caption="Hreflang link usage \- home page"  
  description="Bar chart showing hreflang link usage on inner pages by language code. English (en) appears on 7.6% of desktop and 6.8% of mobile. x-default appears on 7.4% of desktop and 6.8% of mobile. French (fr) appears on 3.2% of desktop and 3.2% of mobile. German (de) appears on 3% of desktop and 3.1% of mobile. Spanish (es) appears on 2.9% of desktop and 3% of mobile. English US (en-us) appears on 2.3% of desktop and 1.9% of mobile. Russian (ru) appears on 1.7% of desktop and 2.1% of mobile. Portuguese (pt) appears on 1.3% of desktop and 1.7% of mobile. Dutch (nl) appears on 1.5% of desktop and 1.5% of mobile. Japanese (ja) appears on 1.3% of desktop and 1.6% of mobile.",  
 chart_url="[https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=268209538\&format=interactive](https://docs.google.com/spreadsheets/d/e/2PACX-1vQUdZ1uaX5U0oLrHlWn8iYc1dhPthw59zy20QFdsYCgky7zaesRm8ctLSxQ9zjlapXCjo6Xd29w_xmB/pubchart?oid=268209538&format=interactive)",  
  sheets_gid="1895020036",  
  sql_file="hreflang-link-tag-usage-2025.sql"  
  )  
}}

## Conclusion {#conclusion}

As AI search reshapes how content is discovered, the web's fundamentals matter more than ever, and reassuringly, the data suggests those foundations are holding firm. 

Crawlability and indexability are strong; most sites serve valid `robots.txt` files and `canonical` tags, and markup hygiene is improving year on year. `Robots.txt` itself is evolving, moving from a gatekeeper of access to a statement of intent about content use, with AI crawlers like GPTBot and ClaudeBot now explicitly named in millions of files. Meta robots adoption remains solid, and canonical signals are stable, giving search systems–human or machine–core foundations to work with.

Beyond these access signals, the web's middle layers \- page experience, performance, and on-page structure \- show encouraging stability. HTTPS adoption now exceeds 91%, Core Web Vitals have plateaued at historically high levels, and on-page metadata such as titles, descriptions, and headings are increasingly optimized for both search and AI-driven indexing. Structured data adoption has reached 50%, with most implementations embedded directly in HTML. All to ensure a faster, cleaner interpretation by crawlers and models alike.

`llms.txt` is the web's latest experiment in speaking directly to AI systems; site owners are being invited to think about how content is ranked, read, and reused by AI. Adoption is still low (around 2%) and mostly driven by CMS plugins rather than deliberate strategy, but its existence signals a shift in mindset. Whether `llms.txt` becomes a standard or a footnote is a core question to take into 2026\.

Much of this progress stems from CMS platforms that now embed best practices by default, quietly raising the technical baseline across the web. The overall trajectory of technical SEO is encouraging: a web that's generally more coherent, crawlable, and semantically aware than it was a year ago. 

For years, SEOs have known these fundamentals mattered (structured data, metadata, and clean architecture) but constant algorithm volatility often made them feel secondary to quick-win tactics. Now, as large language models increasingly rely on structured and well-labeled data to interpret and cite content, those same fundamentals are being revalidated. The basics were never obsolete; they've simply become the bridge between human-readable pages and machine understanding. The next evolution of SEO goes beyond ranking but being understood and represented accurately, wherever intelligence lives.





























