---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Sustainability
description: Sustainability chapter of the 2024 Web Almanac covering environmental impacts of web pages, where they come from and how to reduce them
authors: [ldevernay, burakguneli, ines-akrap, AlexDawsonUK, mgifford, timfrick]
reviewers: [lebreRafael]
editors: [cqueern]
analysts: [Falafelqueen, burakguneli, mgifford]
translators: []
results: https://docs.google.com/spreadsheets/d/1E6wPVck2-5NDUpFKWjbJXKJKNx0E9fWwIdeM9hUKl8c/edit#gid=806519964
ldevernay_bio: Laurent Devernay Satygraha is a Digital Sobriety Expert for <a hreflang="en" href="https://greenspector.com/en/home/">Greenspector</a>. You can find him blogging <a hreflang="en" href="https://ldevernay.github.io/">on his own</a> or <a hreflang="en" href="https://greenspector.com/fr/blog/">for this company</a> but almost always about web sustainability. Which makes him either an enthusiast or a monomaniac.  Connect with <a href="https://www.linkedin.com/in/laurent-devernay-satyagraha-2610b85/">Laurent on LinkedIn</a>.
burakguneli_bio: Burak is Frontend Software Engineer who strive to understand how things work under the hood to unravel their mysteries, especially in Javascript. He is based in Berlin and if you're also living in Berlin, there's a good chance you might bump into each other at an indoor cycling class.
ines-akrap: Ines Akrap is a Frontend Software Engineer passionate about optimizing websites to be fast, sustainable, and provide the best user experience for every user. She works in Storyblok as a Solutions Engineer. She enjoys sharing her knowledge through talks, podcasts, workshops, and courses.
AlexDawsonUK_bio: Alexander Dawson is a Web Developer, Sustainability Researcher, and editor of the <a href="https://w3c.github.io/sustyweb/">Web Sustainability Guidelines</a>. You can find more details about him at <a href="https://alexanderdawson.com/">alexanderdawson.com</a>.
mgifford_bio: Mike Gifford is CivicActions’ Open Standards & Practices Lead. He is also a thought leader on open government, digital accessibility and sustainability. He has served as a Drupal Core Accessibility Maintainer and also a W3C Invited Expert. He is a recognized authoring tool accessibility expert and contributor to the W3C's Draft Web Sustainability Guidelines (WSG) 1.0.
timfrick_bio: Tim Frick is President of <a href="https://mightybytes.com">Mightybytes</a>, a digital agency and Certified B Corp located in Chicago. A seasoned public speaker, he regularly presents on sustainable design, measuring impact, and problem solving in the digital economy. Tim is also the author of four books, including <a href="https://www.oreilly.com/library/view/designing-for-sustainability/9781491935767/">Designing for Sustainability, A Guide to Building Greener Digital Products and Services</a>, from O'Reilly Media. Connect with <a href="https://www.linkedin.com/in/timfrick/">Tim on LinkedIn</a>.
featured_quote: This is the second Web Almanac chapter about Sustainability and, guess what, climactic events didn't get any better. There are still a lot of opportunities to make digital more sustainable, starting with the web. We'll see that a lot happened since 2022 in the sustainability field and offer even more opportunities to make the web more resilient.
featured_stat_1: 14%
featured_stat_label_1: Websites relying on more sustainable hosting
featured_stat_2: 1.36
featured_stat_label_2: GHG emissions (g eqCO2) for the 90th percentile web pages on mobile
featured_stat_3: 25.13%
featured_stat_label_3: Mobile websites not using cache at all
---

## Introduction

In the current chapter, we will rely as much as possible on <a hreflang="en" href="../2022/sustainability">the 2022 Sustainability chapter</a>. If you haven't yet, you should read it right now. Yes, recycling/reusing is a major part of sustainability.

Since the 2022 Almanac, the field of digital sustainability has advanced considerably. That said, it is very much in its infancy, as this is a complex problem. We cannot know, with absolute certainty, what the full effects of our digital lives are on our physical planet. What we can be confident in is that the full impacts are bigger than generally accounted for. Water, land, rare minerals, and electricity are all consumed by our "clean" digital interfaces, and toxic waste is often produced.

In addition, it has been recognized by many working in sustainability that the impact of other primary fields such as web performance, accessibility, security, privacy, etc. can lead to emissions as a secondary consequence of poor planning and decision-making.

Since the last Almanac, we have seen the creation of open standards, open source software, and open data on the impacts of our digital lives. Although still in development, we have the beginning of an evidence-based approach to emission reductions. There are courses, certifications, books, videos, podcasts, and conferences <a hreflang="en" href="https://w3c.github.io/sustyweb/intro.html#resources">on the subject</a>. Yet, this is still an issue that takes backstage with other efforts to reduce emissions.

We need to get better at reducing the impacts of our data centers and start seeing digital devices as part of a circular economy. But more importantly, we need to begin reducing our demand for more and bigger digital experiences.

Where possible, we will be leveraging the Draft W3C Sustainable Web Community Group Web Sustainability Guidelines (WSG). We will be building on the experience of the 2022 Almanac to highlight data to give us a snapshot of where we are today.

But first, here's a quick recap of what happened in the sustainability field since 2022.

### What's new in web sustainability?

Since 2022, we have seen a steep increase in awareness of web sustainability. Along the way, a lot has happened.

The <a hreflang="en" href="https://sci.greensoftware.foundation/">Software Carbon Intensity (SCI) Specification</a> has become an <a hreflang="en" href="https://greensoftware.foundation/articles/sci-specification-achieves-iso-standard-status">ISO standard</a>. Based on the rate of carbon emissions, this specification is a way to track the environmental efficiency of a digital service. This could be a good starting point. However, it could be important to go further through additional ecological factors (depletion of abiotic resources, water usage, etc) and consider all steps of the lifecycle of a project to reach for frugality and moderation.

This quest for efficiency saw some other achievements such as <a hreflang="en" href="https://hackernoon.com/carbon-aware-computing-next-green-breakthrough-or-new-greenwashing">carbon-aware code</a> and major cloud providers aiming for a reduction of their environmental impacts, mostly based on carbon emissions. Sustainability also <a hreflang="en" href="https://thenewstack.io/sustainability-how-did-amazon-azure-google-perform-in-2023/">met some drawbacks</a> because of the rise of artificial intelligence, which in itself gets massive media coverage but not necessarily for its environmental impacts. This emergence hindered the efforts of some major cloud providers to reach for the reduction of environmental impacts. This helps illustrate that efficiency is not enough and frugality should be our top priority. It also highlights that widely adopting new technologies without considering their environmental (and social) impacts should be avoided.

This is where we should mention new repositories for best practices:
- The W3C (World Wide Web Consortium) Sustainable Web Community Group published the <a hreflang="en" href="https://w3c.github.io/sustyweb/">Web Sustainability Guidelines (WSG) 1.0</a>. These offer a higher perspective on web sustainability and should help teams adopt sustainability on a larger scale (more on this later in this chapter).
- France institutions also released the <a hreflang="en" href="https://en.arcep.fr/news/press-releases/view/n/environment-rgesn-170524.html">General policy framework for the ecodesign of digital services</a>. The purpose here is to offer a framework for sustainable digital services and to aim for a wider adoption of these best practices.
- <a hreflang="en" href="https://www.iso.org/standard/86105.html">An ISO standard for Digital Services Ecodesign</a> is also on the way.

More and more <a hreflang="en" href="https://w3c.github.io/sustyweb/intro.html#books">books</a> are also being published, such as <a hreflang="en" href="https://www.oreilly.com/library/view/building-green-software/9781098150617/">Building Green Software</a> by Anne Currie.

In addition to this, tools for estimating the environmental impacts of the web are still evolving and new ones keep appearing. Some existing tools (such as Screaming Frog SEO and Webpagetest) are adding features to estimate environmental impacts. As such, the <a hreflang="en" href="https://sustainablewebdesign.org/estimating-digital-emissions/">Sustainable Web Design Model</a> is often used. However, accurately estimating impacts is still an important topic and no consensus has been reached yet. As is often the case with environmental considerations, the topic remains complex.

To give more context to all these breakthroughs, more general studies about the environmental impacts of digital should be conducted worldwide, <a hreflang="en" href="https://en.arcep.fr/news/press-releases/view/n/the-environement-210324.html">as is already the case in France</a>. Such a large perspective would help estimate the benefits of all the ongoing efforts but also give insights on where more focus is needed.

### Limitations and hypothesis

There are many ways to assess environmental impacts, but there are a few things to keep in mind:
- Most free tools only rely on transferred data, the number of HTTP requests, and DOM size. This is insufficient to capture the overconsumption related to animations, heavy calculations (especially using JS) but also benefits from dark mode. To achieve this, other metrics are needed, such as CPU/GPU, Energy, and RAM/memory usage should be measured.
- Tools usually stick to page loading and sometimes scrolling. This is not always relevant to real usage and often misses some obvious things, such as accepting cookies, client-side cache, playing videos, etc. Real user journeys should be measured, based on analytics and user feedback.
- GHG is often used as a proxy for environmental impacts, but this is not enough. To avoid impact transfers and greenwashing, other indicators should be used, as <a hreflang="en" href="https://librairie.ademe.fr/ged/7595/R__f__rentiel_rcp_services_num__riques.pdf">stated by the ADEME</a> (PDF, French, 980 kB).

These notions are detailed in this <a hreflang="en" href="https://greenspector.com/en/reduce-the-weight-of-a-web-page-which-elements-have-the-greatest-impact/">article about the environmental impacts of web elements</a>

_Embedded environmental impact needs to be factored into our calculations. The web should not require users to update their devices every 2-3 years. We need to ensure that the lifespans of our digital infrastructure are extended._

### Intersectional environmental issues

Sustainability ultimately involves people, as the planet will ultimately take care of itself. Building a just society that supports the needs of its people within the boundaries of its population is key. Throughout our lives, all of us require accommodation. Our ability to navigate the physical and digital world changes, and a sustainable economy supports that. One in five people has a permanent disability, and everyone will have both temporary and situational disabilities throughout their life. For more on this, you should read <a hreflang="en" href="./accessibility">the Accessibility chapter</a>.

In building sustainable digital interfaces, we must consider the user, including those with disabilities.  Sustainable digital interfaces allow users to quickly navigate to accomplish their tasks. An inaccessible interface may ultimately require a user to take a less sustainable path to accomplish their goals.

Similarly, one must consider human diversity. Race, class, gender, and sexual identity have been used to divide people. A sustainable web should promote climate justice.

For further information, refer to:
- The WSGs 1.0 - SC 3.5.

### Legal obligations and reporting standards

Digital sustainability is becoming a greater concern in the regulatory landscape. Recent legislative changes worldwide have introduced requirements that everyone must comply with.

Where organizations once faced minimal obligations, they are now confronted with new regulations designed to start accounting for their environmental impact. The urgency of the climate crisis has accelerated this shift, with governments increasingly holding businesses accountable for their ecological footprint.

The European Union currently leads the world in terms of sustainability regulation. The Corporate Sustainability Reporting Directive (CSRD) and the European Sustainability Reporting Standards (ESRSs) mandate that large corporations report on Scope 1, 2, and 3 emissions annually, encompassing direct, indirect, and value chain emissions. Scope 1 covers direct greenhouse gas (GHG) emissions made by a business, Scope 2 covers indirect emissions from a business such as electricity to heat or cool a building, and Scope 3 covers all other emissions associated, not with the company directly, but that the organization is indirectly responsible for.

Meanwhile, the Ecodesign for Sustainable Products Regulation (ESPR) and Energy Efficiency Directive focus on mandating physical infrastructure (such as data centers) and products towards circular economies and general sustainability principles. Furthermore, the Corporate Sustainability Due Diligence Directive (CS3D) mandates that organizations foster sustainable behavior relating to workplaces and employees.

Additionally, The Green Claims Directive explicitly legislates around claims of sustainability or related terms (such as being green) to fight against greenwashing. The Digital Operational Resilience Act (DORA) mandates the sustainability of operations relating to DevOps activities. The EU Artificial Intelligence (AI) Act provides necessary regulation around Artificial Intelligence and the environmental impact of such technologies.

It should be noted that many of these European Union laws apply to both citizens and residents of the EU. This also applies to companies who do business with Members of the EU or with people living within the EU. Like the GDPR, the ramifications of these laws have global significance.

Two best practice repositories from the EU known as the Handbook of Sustainable Design of Digital Services (GR491) and the European Digital Rights and Principles have become widely associated with their legislative move towards sustainability.

France established itself as an early leader in digital sustainability through the publication of its REEN legislation alongside the General Policy Framework for the Ecodesign of Digital Services (RGESN). This framework provides clear and actionable guidance on best practices, setting a high standard for sustainable digital service design. There is a huge focus on training engineers on how to build more energy-efficient digital products/services. With its circular economy anti-waste law AGEC also in effect, and its other best practice AFNOR Spec 2201 also available, the country is working hard to tackle environmental issues.

In Germany, progress is also being made regarding sustainability through the development of the Energy Efficiency Act (EnEfG) which mandates that data centers use less energy on the grounds of climate protection, and the Supply Chain and Due Diligence Act (SCDDA) legislating on the human side of sustainability providing legal protections across supply chains.

California's new emissions reporting law, the Climate Corporate Data Accountability Act (S.B. 253) along with its sister legislation Climate-Related Financial Risk Act (CFRA), are a landmark regulation package with potential global ramifications. They will require companies with revenues exceeding $1 billion and business operations in California to disclose their greenhouse gas emissions. Given California's role as a global hub for digital technology, these laws will likely influence practices and standards internationally, making it essential for digital agencies worldwide to take note.

India is the final country of note that has crafted sustainability legislation, in this case, the Business Responsibility and Sustainability Report (BRSR) which is much like the EU's CSRD, except for those living or trading in this nation, enforcing reporting scope emissions.

Much like web accessibility, digital sustainability is becoming a non-negotiable aspect of doing business. Non-compliance with the emerging sustainability standards is no longer an option, and businesses face a range of potential penalties.

The regulations affecting digital sustainability are diverse. Some, like the CSRD, focus on enhancing transparency and accountability in emissions reporting, while others aim to prevent greenwashing by enforcing accurate and responsible communication about products and services.

Standards such as the Global Reporting Initiative (GRI) provide essential frameworks to help digital agencies meet these new obligations. It may be helpful to think of laws to dictate what must be done, standards to provide the roadmap for compliance, and best practices to ensure that compliance is achieved effectively and ethically.

Digital professionals should look at what legislation, standards, and best practices for digital sustainability apply to them prior to the creation of their product or service and monitor any developments as their product evolves (to meet an evolving compliance landscape).

The benefits of adopting sustainable practices from the offset extend beyond mere compliance; they offer a competitive edge in a market increasingly driven by the need for excellent customer experience and increasing environmental considerations and can lead to time and cost savings when not having to be retrofitted into existing works. As this report outlines, integrating sustainability into your business strategy is not just about avoiding penalties, but about seizing new opportunities in a rapidly evolving landscape.

Organizations are beginning to add a /sustainability page to the footer of their webpage to allow them to report on their CO2 emissions as well as describe what they are doing to reduce emissions for their digital services.

For further information on specific regulations and standards, refer to:
- <a hreflang="en" href="https://w3c.github.io/sustyweb/policies.html">WSG: Web Sustainability Laws & Policies</a>
- <a hreflang="en" href="https://w3c.github.io/sustyweb/star.html">WSG: Draft Sustainable Tooling And Reporting (STAR) 1.0</a>
- <a hreflang="en" href="https://www.globalreporting.org/how-to-use-the-gri-standards/gri-standards-english-language/">GRI: Global Reporting Initiative</a>
- <a hreflang="en" href="https://gr491.isit-europe.org/en/">GR491, The Handbook of sustainable design of digital services | ISIT</a>
- <a hreflang="en" href="https://apolitical.co/solution-articles/en/keeping-tech-sustainable">Apolitical: Keeping tech sustainable</a>

## Evaluating the environmental impact of websites

Evaluating the environmental impact of a website is everything but an easy task. It usually involves assessing the energy consumption and carbon footprint associated with its operation, from the servers that host it to the devices that access it. This evaluation considers various factors, including the efficiency of the hosting infrastructure, the amount of data transferred during page loads, the use of renewable versus non-renewable energy by data centers, and the overall optimization of the website's code and assets. Websites that are heavy in images, videos, and other large files require more energy to load and transmit, contributing to higher carbon emissions. By understanding and optimizing these elements, website owners can reduce their digital carbon footprint, contributing to a more sustainable web and helping to minimize their environmental impact.

It is very important to keep in mind that there is still no available tool that would allow for precise measurement of every single part of the system, allowing for a nice overall sum. Therefore, we can measure isolated parts of the systems our teams work on or resources to the use of the models that allow us to do an estimation based on specific inputs. One model that is currently used in many different website carbon calculators and is being worked on and improved is the <a hreflang="en" href="https://sustainablewebdesign.org/estimating-digital-emissions/">Sustainable Web Design Model</a>. This model can be a slightly controversial way of estimating, as well as any currently out there. However, it has been present for a while, allowing comparison over time, and simplifying this complex process allows for better understanding and, hopefully, recognition of the problem itself.

Usually, we talk about CO2 but it would be more accurate to talk about eqCO2 or CO2e: values equivalent to CO2 emissions but rather applies to all kinds of greenhouse gasses (GHG). Also, other environmental impacts should be considered (as is the case in Life Cycle Assessment for instance) to avoid impact transfers (e.g. when reducing GHG emissions proves detrimental to water consumption) and debatable claims such as "carbon neutrality".

For further information, refer to:
- The WSGs 1.0 - SC 2.1, 2.25, and 5.5.

### A quick note on assessing environmental impacts

The queries from last year have been updated to reflect the new data structure. For most, there has been no effective difference in the results.

The update of the CO2 emissions calculations is reflected in the global page, SSG, CMS, and e-commerce emissions calculation. We have updated the calculations to the version 4 model of emissions calculation based on <a hreflang="en" href="https://sustainablewebdesign.org/estimating-digital-emissions/">https://sustainablewebdesign.org/estimating-digital-emissions/</a>

Main differences:
- The global carbon intensity has changed from 442g/kWh to 494g/kWh.
- Previously the website CO2 per visit was a 'simple' equation considering the page weight (data transferred in GB), multiplied by the estimated energy usage of loading one GB (0,81) and multiplying it with the carbon intensity.
- In the updated formula segments the energy consumption by data centers, network, and energy consumed by user devices for greater insight.
- Each system segment is further broken down into two categories — operational and embodied emissions.
    - **Operational:** The emissions attributed to the use of the devices in a segment.
    - **Embodied:** The emissions attributed to the production of the devices in a segment.
- Each segment is attributed a certain weight in the calculation reflecting its estimated contribution to the total emissions -> for example, each segment has its estimated carbon intensity for both operation and embodied energy consumption.
- At the end, this allows us to estimate this for each segment, and then sum the totals to get the total estimated emissions.

### Page weight

The Sustainable Web Design Model uses data transfer as a proxy. While we can debate whether this input gives us an accurate carbon emission estimate, it's clear that the increasing bloat of websites over the years is contributing to the problem. More data needs more servers to store them, more energy to deliver them, and more processing power to display them on-screen to end users. Over the years, there has been a visible upward trend, so let's look at that data for 2024.

{{ figure_markup(
  image="number-of-kb-by-percentile.png",
  caption="Number of kilobytes by percentile",
  description="A column chart showing that on the 90th percentile web pages weight nearly 8 MB on desktop and right above 7 MB on mobile. On the 75th percentile the web pages get over 4 MB on desktop and around 3.5 MB on mobile, on the 50th percentile we found web pages weight a bit more than 2.5 MB on desktop and a bit less than 2 MB on mobile, on the 25th percentile it's over 1 MB on desktop and a bit less than 1 MB on mobile. Finally, on the 10th percentile we see pages weight a bit more than 0.5 MB on desktop and a bit less than 0.5 MB on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=188541594&format=interactive",
  sheets_gid="997244814",
  sql_file=""
) }}

Page weight represents the amount of data transferred to access the web page (based only on HTTP requests). It is recommended that this metric be kept as low as possible to ensure a fast load and good user experience for all users. On the 90th percentile, the average mobile site weighs around 7.2 MB, while desktop ones are around 8 MB. The good news is that these numbers are slightly lower than the ones in <a hreflang="en" href="../2022/sustainability#page-weight">the 2022 Almanac</a>. The bad news is that these numbers are still way too high. When we talk about sustainability, we usually touch upon inclusion, and to make sure the majority of Internet users can access the page and have a decent user experience, <a hreflang="en" href="https://infrequently.org/2021/03/the-performance-inequality-gap/">page weight should be kept below 1MB, ideally around 500KB</a>.

It is also important to emphasize that these numbers are coming for a so-called lab test, meaning that pages were accessed via script and not real users. With many websites these days implementing lazy loading strategies (request and load assets once they are needed, through native lazy-loading for images and iframes or progressive hydration for dynamic components), as well as loading and processing extra scripts once the user has given consent for it (and the script does not include any user interaction emulation), average page weight is sure to be an even bigger number.

For further information, refer to:
- The WSGs 1.0 - SC 2.6 and 5.27.

#### Weight by content type

With data showing that an average page weighs around 8MB, the next logical question is where all those kilobytes are coming from. Modern pages are composed of many different pieces, including basic building blocks such as HTML, CSS, and JS, as well as fonts and images to enhance visual presentation.

{{ figure_markup(
  image="kilobytes-per-type.png",
  caption="Kilobytes per type",
  description="A column chart showing for the 90th percentile that HTML weighs 146.45 kB on desktop, 145.40 on mobile. CSS weighs 268.78 kB on desktop, 260.40 on mobile. Fonts weigh 458.36 kB on desktop, 399.33 on mobile. JS weighs 1,834.30 kB on desktop, 1,732.17 on mobile. Images weigh 4,910.37 kB on desktop, 4,436.10 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=296763237&format=interactive",
  sheets_gid="123069751",
  sql_file=""
) }}

{{ figure_markup(
  image="kilobytes-by-percentile-by-type-mobile.png",
  caption="Kilobytes by percentile by type (mobile)",
  description="A column chart showing the Kilobytes per byte by percentile for mobile. The division per type remains roughly the same for each percentile but the weight of each increases with the percentiles. For the 10th percentile on mobile, HTML weighs 5.87 kB, JS 88.81 kB, CSS 7.55 kB, Images 42.71 kB and fonts 0 kB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=426612772&format=interactive",
  sheets_gid="123069751",
  sql_file=""
) }}


From the 90th percentile of collected data, it is clear that the largest portion, more than half of the page's total weight, belongs to images. This is quite an expected result and one of the parts where small optimizations can have the biggest impact. Slightly surprising and worrying is that there is still a very small gap between desktop and mobile numbers, not only in images but across all types. This shows us that even though mobile-first became a concept over 15 years ago, most teams still don't optimize their mobile sites to account for the limitations of mobile networks, phone plans, and smaller screens (for which smaller images are usually enough). In the end, it may look mobile-friendly, but the experience isn't.

It is also not surprising that the second largest portion is JavaScript code. Modern frameworks, dependencies, packages, as well as legacy code easily accumulate a larger amount of JavaScript code. The biggest problem is that script processing is part of the page loading that needs the most power from the CPU and consumes the most energy. Also, security should be a concern, check the <a hreflang="en" href="./security">Security chapter</a> for more on this.

Compared to images and JavaScript, the weight of CSS doesn't look too large. However, the important question covered later in the chapter is how much of this code, both CSS and JS, is actually being used. In addition to these considerations, the processing cost of such code should be considered (CPU/Memory usage).

The size of font files may look reasonable if we consider that <a hreflang="en" href="https://sustainablewebdesign.org/has-the-design-used-the-minimum-number-of-custom-fonts/">a typical custom font file can be over 200 KB</a>. This size, though, can be brought down significantly by subsetting font files to only characters that are needed for the site content. The median font file with an English-only subset of characters should be around <a hreflang="en" href="https://www.phpied.com/bytes-normal-web-font-study-google-fonts/">12 KB</a>, which is 6% of the original 200 KB and could bring us closer to having a great-looking page that is below 1 MB.

More about this topic can be found in the <a hreflang="en" href="./fonts">Fonts</a> and <a hreflang="en" href="./page-weight">Page Weight</a> Chapter.

For further information, refer to:
- The WSGs 1.0 - SC 2.6 and 5.27.

### Carbon emissions

As stated above, back in 2022, we used the Sustainable Web Design (SWD) model to estimate carbon emissions based on page weight. As we explained many times, this is inaccurate but constantly improving. As such a new version of the model was recently published. This has a considerable impact on the results so we decided to recalculate emissions from the 2022 data before proceeding with the 2024 data.
In both cases, we exclude data from the 100 percentile, which is some kind of "worst-case scenario" and way above other percentiles thus making the diagrams less readable.

#### Emissions for 2022

Based on the V4 of the SWD model, we get these global results for emissions:

{{ figure_markup(
  image="carbon-emissions-by-percentile-2022.png",
  caption="Carbon emissions (g) by percentile for 2022",
  description="A column chart showing that on the 90th percentile, desktop web pages emit 1.29g of carbon and mobile pages emit 1.14g of carbon, on the 75th percentile desktop pages emit 0.66g of carbon and mobile pages emit 0.57g of carbon. On the 50th percentile it goes 0.33g of carbon on desktop and 0.29 on mobile. On the 25th percentile it's 0.16g of carbon for desktop pages and 0.14g of carbon on mobile pages. Lastly, on the 10th percentile desktop pages emit 0.08g of carbon and mobile pages emit 0.06g of carbon.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=188699126&format=interactive",
  sheets_gid="1113829605",
  sql_file=""
) }}

If you take a look at the results from the <a hreflang="en" href="../2022/sustainability#carbon-emissions">2022 Sustainability chapter</a>, you'll notice that these new estimations are slightly lower. This is why we recalculated them. Otherwise, we could have been led to think that emissions from web pages diminished significantly between 2022 and 2024 (spoiler: this is not the case). With this in mind, we can now look at the data for 2024.

#### Emissions for 2024

Based on the SWD V4 model, carbon emissions for web pages in 2024 are as follows:

{{ figure_markup(
  image="carbon-emissions-by-percentile-2024.png",
  caption="Carbon emissions (g) by percentile for 2024",
  description="A column chart showing that on the 90th percentile, desktop web pages emit 1.47g of carbon and mobile pages emit 1.36g of carbon, on the 75th percentile desktop pages emit 0.74g of carbon and mobile pages emit 0.66g of carbon. On the 50th percentile it goes 0.37g of carbon on desktop and 0.33 on mobile. On the 25th percentile it's 0.19g of carbon for desktop pages and 0.0.16g of carbon on mobile pages. Lastly, on the 10th percentile desktop pages emit 0.08g of carbon and mobile pages emit 0.07g of carbon.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=70239542&format=interactive",
  sheets_gid="1113829605",
  sql_file=""
) }}

Even if the results are quite similar to those from 2022, we notice a slight increase in carbon emissions, which is even more significant for the 75 and 90 percentile. This is bad news as we should focus on reducing all our carbon emissions. This is not surprising since page weight has been globally on the rise for many years. More on this in the <a hreflang="en" href="./page-weight">Page Weight chapter</a>. The goal of the Sustainability chapter is precisely to raise awareness on this but also to provide recommendations to improve things.

We can also take a look at the share of emissions for different resources (HTML/JS/CSS/images/fonts), distinguishing mobile and desktop:

{{ figure_markup(
  image="emissions-by-percentile-by-type-desktop.png",
  caption="Emissions by percentile by type for 2024 (desktop)",
  description="A bar chart showing the percent of different content types on desktop in the total page carbon emissions by percentile. On the 90th percentile HTML content accounts for around 1.6% of the total carbon emissions, JavaScript is responsible for 20.2% of total carbon emissions, CSS is around 2.9%, images accounts for around 70.2% and fonts represent 5% of the total carbon emissions. On the 75th percentile, HTML represents 1.6%, JavaScript 26.5%, CSS around 3.4%, images around 62.7% and fonts around 5.8% of the total carbon emissions. On the 50th percentile, HTML represents 1.7%, JavaScript 32.1%, CSS around 4.1%, images almost 55.2% and fonts around 6.9% of the total carbon emissions. On the 25th percentile, HTML represents 1.9%, JavaScript 37.4%, CSS around 4.9%, images 48.9% and fonts around 6.9% of the total carbon emissions. On the 10th percentile, HTML represents 2.8%, JavaScript 49%, CSS around 4.1%, images 44.1% and fonts 0% of the total carbon emissions.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=1793089209&format=interactive",
  sheets_gid="1113829605",
  sql_file=""
) }}

{{ figure_markup(
  image="emissions-by-percentile-by-type-mobile.png",
  caption="Emissions by percentile by type for 2024 (mobile)",
  description="A bar chart showing the percent of different content types on mobile in the total page carbon emissions by percentile. On the 90th percentile HTML content accounts for around 1.7% of the total carbon emissions, JavaScript is responsible for 20.8% of total carbon emissions, CSS is around 3.1%, images accounts for around 69.6% and fonts represent 4.8% of the total carbon emissions. On the 75th percentile, HTML represents 1.8%, JavaScript 27.4%, CSS around 3.6%, images around 61.7% and fonts around 5.6% of the total carbon emissions. On the 50th percentile, HTML represents 1.9%, JavaScript 33.3%, CSS around 4.4%, images almost 53.8% and fonts around 6.6% of the total carbon emissions. On the 25th percentile, HTML represents 2.2%, JavaScript 40.5%, CSS around 5.2%, images 45.5% and fonts around 6.6% of the total carbon emissions. On the 10th percentile, HTML represents 3.6%, JavaScript 52.2%, CSS around 3.5%, images 40.7% and fonts 0% of the total carbon emissions.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=89199497&format=interactive",
  sheets_gid="1113829605",
  sql_file=""
) }}

This looks quite similar to what we found in 2022, leading to the same conclusions. We should however insist on the fact that images are usually easier to process than JS and CSS. Here, JS is a major offender regarding transferred data but is usually quite impactful on memory, CPU, and GPU, which then leads to additional environmental impacts that are not yet considered in the SWD model. For instance, soliciting more CPU/GPU/memory could have an impact on the battery discharge of your smartphone, thus forcing you to change the battery or device sooner than expected and possibly making the website less performant on older devices.

#### Some "meta" considerations

Somewhere along writing this chapter, someone in the team wondered what would be the total carbon emissions related to the HTTP Archive monthly crawl. Each month, data is collected from millions of web pages to monitor the state of the web. For instance, the Web Almanac is based on this data.
Find more about <a hreflang="en" href="./methodology">the methodology</a>.

Read <a hreflang="en" href="https://httparchive.org/reports">other reports from the HTTP Archive</a>.

We ran a query on the data collected for the 2024 Web Almanac and found that the total amount of transferred data would be around 201,66 TB. Using the SWD model, this would amount to 27,7 T CO2. Based on <a hreflang="fr" href="https://impactco2.fr/outils/comparateur">a CO2 converter</a>, this is approximately as many carbon emissions as a thermal car driving for 127 298 km (going around the Earth for more than 3 times) or manufacturing 323 smartphones.
Things only add up when considering this crawl is done monthly.

But you should also keep in mind that:
- This is a necessity to have updated data.
- Some of these pages gather millions of visits each month.
- That does not prevent us from thinking about ways to reduce these impacts (and I hope that will be considered soon).

#### Going further

It should be noted that while many assume sustainability to be a task primarily (or purely) focused on reducing carbon (GHG) emissions, the considerations of digital sustainability are not as simple as they would initially appear. There are not only several ways in which sustainability can be measured and a variety of different resource types that must be accounted for, but a range of variables that can impact the resulting calculation.

Carbon emissions can ultimately be measured through the amount of energy (electricity) consumed through the act of processing actions (such as how many objects are rendered to the screen and the energy intensity of CPU, GPU, and RAM required for this activity), and as such, it can be more easily calculated, and any reductions made where beneficial. However, other natural resources are consumed by Internet infrastructure or devices connected to the web such as water (for cooling equipment), materials and chemicals (e.g. printing), and e-waste (old devices being thrown away). The sustainability impact of these issues must also be accounted for in the lifecycle chain of a product or service.

For further information, refer to:
- The WSGs 1.0 - SC 4.1 and 5.5.

### Number of requests

Requests are generated whenever a file is needed to load a page, providing insight into the page's impact on the network and servers. They are even used to calculate environmental impact. Analyzing these requests helps us uncover opportunities for optimization, which will be valuable as we explore different types of assets and external requests.

It's essential to minimize the number of requests. Setting an initial cap of 25 is a positive step, but it's often challenging to meet this target due to the presence of trackers and similar elements.

{{ figure_markup(
  image="number-of-requests-by-percentile.png",
  caption="Number of requests by percentile",
  description="A column chat showing that on the 90th percentile there are 182 requests per page on desktop and 177 requests on mobile. On the 75th percentile there are 120 requests on desktop and 114 on mobile. On the 50th percentile it drops at 74 requests on desktop and 70 on mobile. On the 25th percentile there are 43 requests on desktop and 40 on mobile. Finally on the 10th percentile we see a total of 23 requests on desktop and 21 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=1890346358&format=interactive",
  sheets_gid="495251827",
  sql_file=""
) }}

From the extracted data, we can see that the number of requests is quite similar for mobile and desktop pages, which is not ideal. To respect mobile networks as well as plan limitations, it would be great to see fewer resources being loaded on mobile, which would result in fewer requests.
The amount of requests, in general, is quite high, so let's see what resources these requests are calling for.

{{ figure_markup(
  image="number-of-requests-by-percentile-and-type-mobile.png",
  caption="Number of requests per percentile and resource type (mobile)",
  description="A column chart showing that on mobile devices, on the 90th percentile we find 12 requests targeting HTML content, 68.5 requests for javascript resources, almost 26 requests for CSS, around 55 requests fetching images and 8.5 requests for fonts. On the 75th percentile, there are 5 HTML requests, 41 JavaScript requests, 15 CSS requests, 29.5 images requests and 5.5 Fonts requests. On the 50th percentile, we can see 2 HTML requests, 22 javascript requests, 7.5 CSS requests, 15.5 images and 3 fonts requests. On the 25th percentile, there are 1 HTML, 10.5 javascript, 3.5 CSS, 7.5 images and 1 font requests. On the 10h percentile, we find 1 Html, 4.5 javascript, 1.5 CSS, 4 images and 0 font requests.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=1059345541&format=interactive",
  sheets_gid="495251827",
  sql_file=""
) }}

The not-so-nice surprise here is that most of the requests, around 70 in the 90th percentile, are retrieving JS files, followed by over 50 for images. We can see that the pattern repeats itself across all the percentiles. This is very interesting since, in the report from 2022, the number of requests retrieving images was bigger than the ones retrieving JS. The follow-up question is whether the change in the number of requests also impacts the size of the retrieved assets. So, let's check that.

{{ figure_markup(
  image="kilobytes-by-percentile-by-type-mobile-.png",
  caption="Kilobytes by percentile by type (mobile)",
  description="A column chart showing that on mobile devices, on the 90th percentile we find 145.4 KB of HTML, around 1,732.17 KB of JavaScript, 260.4 KB of CSS, 4,436.1 KB of images and 399.33 KB of fonts. On the 75th percentile it goes down at 70.03 KB of HTML, 1,102.63 KB of JavaScript, 145.59 KB of CSS, 1,807.67 KB of images and 221.51 KB of fonts. On the 50th percentile we found 31.64 KB of HTML, 569.66 KB of JavaScript, 74.99 KB of CSS, 623.8 KB of images and 109.06 KB of fonts. On the 25th percentile there is 13.12 KB of HTML, 244.33 KB of JavaScript, 32.26 KB of CSS, 179.76 KB of images and 39.46 KB of fonts. On the 10th percentile there is 5.87 KB of HTML, 88.81 KB of JavaScript, 7.55 KB of CSS, 42.71 KB of images and 0 KB of fonts.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=426612772&format=interactive",
  sheets_gid="123069751",
  sql_file=""
) }}

The size of retrieved Images is almost double the size of retrieved JavaScript in the 90th percentile, so the "old" pattern is still there. This leads us to the conclusion that sites are loading fewer images but slightly heavier and, in general, more JavaScript, which is not a good trend since that leads to the need for more processing power and can exclude users with aging devices from accessing sites.

For further information, refer to:
- The WSGs 1.0 - SC 3.1 and 4.9.

### More sustainable hosting

One of the simplest ways to reduce your carbon footprint is by <a hreflang="en" href="https://dodonut.com/blog/how-to-choose-the-best-green-web-hosting-provider/">choosing a sustainable hosting provider</a>. Navigating this world can be quite tricky as no provider will truly be 100% carbon neutral as emissions always exist in some form, however, how they power their equipment, maintain their hardware, and deal with waste and redundancy can significantly impact the amount of emissions created. Therefore <a hreflang="en" href="https://www.thegreenwebfoundation.org/tools/directory/">picking the right supplier</a> can have a considerable impact on your ability to mitigate the emissions you produce.

One of the most critical features of a sustainable host is how they get their energy requirements. Hosts may get their electricity supply from normal power companies which in turn (depending on where they are located) generate a significant proportion of their energy from carbon-emitting coal or gas. Having a hosting provider that generates its energy requirements from solar, wind, tidal, and other natural sources will be more beneficial to the planet.

Other factors to consider are how the hosting provider cools its equipment. Many hosts require water cooling (and this can be an issue where freshwater can be a valuable limited resource), suppliers that use natural cooling in colder climates (for example) may be preferable.

Hosts that allow you to monitor your energy requirements (<a hreflang="en" href="https://submer.com/blog/pue-cue-and-wue-what-do-these-three-metrics-represent-and-which-is-one-is-the-most-important/">PUE, WUE, CUE</a>) and even the amount of energy you are utilizing (CPU, GPU, RAM) on an active and logged basis can help you scale your hosting to reduce waste. If the host also <a hreflang="en" href="https://www.scientificamerican.com/article/reduce-reuse-recycle-why-all-3-rs-are-critical-to-a-circular-economy/">recovers, recycles, and upcycles</a> equipment rather than has a throwaway culture, this can reduce e-waste (the same goes for keeping equipment as long as possible).

Compensating for emissions at the server-side can be a complex task and transparency with hosting providers can also be a bit of a minefield, but providers are gradually becoming more sustainably minded and with specialist providers out there who can help you reduce your carbon footprint, taking steps to house your product or service in a greener space can be relatively straight forward.

Note: You may be able to use APIs and infrastructure to model your website or application based on the environmental situation at that time. <a hreflang="en" href="https://hackernoon.com/carbon-aware-computing-next-green-breakthrough-or-new-greenwashing">Carbon-aware computing</a> is a relatively new concept but it has some interesting viewpoints.

For further information, refer to:
- The WSGs 1.0 - Section 4.

#### How many of the sites listed in the HTTP Archive run on green hosting?

To help organizations and individuals choose "greener" hosting, <a hreflang="en" href="https://www.thegreenwebfoundation.org/">the Green Web Foundation</a> maintains a dataset of providers matching the <a hreflang="en" href="https://www.thegreenwebfoundation.org/what-we-accept-as-evidence-of-green-power/">"green" criteria</a>. With the list expanding and updating regularly it is not easy to track this metric, however, let's see what is its current state.

{{ figure_markup(
  image="percent_green_hosting.png",
  caption="% Green hosting",
  description="A column chart showing that on the top 1,000 sites, on desktop, 56% of them relied on green web hosting and it drops at 55% on mobile. On the top 10,000 sites it’s 58% on desktop and 55% on mobile, on the top 100,000 it’s 49% on desktop and 44% on mobile, on the top million it’s 32% for desktops and 30% on mobile. On all measured websites globally, only 16% rely on green web hosting for desktop and 14% for mobile",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=377132080&format=interactive",
  sheets_gid="1680950752",
  sql_file=""
) }}

We can see that only 14% of mobile sites, and slightly more desktop ones from the HTTP Archive are hosted using "green hosting" providers. That is a slight increase from 2022, when this number was 10%, however, it shows us that progress in this area is extremely slow and that there is still a long way to go in both aspects: encouraging website owners to switch to "greener" hosting provides, as well as more providers offering "greener" hosting.

There is a significant difference in top-ranked sites, showing that 55% of sites ranked in the top 10000 are considered to be hosted green. This number also has a slightly better jump from 2022, when it was 48% for the top 10000 ranked sites. As good as this may sound it can easily be attributed to the fact that many bigger hosting providers such as Amazon and Google are considered to be "green".

## Reducing the environmental impact of websites

Understanding the environmental impact of websites is only the first step; action is crucial. With our updated insights into website footprints, particularly regarding unused code and font usage, we can now explore more targeted and effective strategies for mitigation. Let's examine how to translate this knowledge into tangible, sustainable web practices.

For further information, refer to:
- The WSGs 1.0 - Sections 2, 3, 4, and 5.

### Avoiding waste

Avoiding waste remains one of the most effective ways to reduce the environmental impact of websites.
- Minimize unnecessary content and code: Many websites still carry superfluous features and content. Be critical in assessing the necessity of each page element. Our analysis shows that unused CSS and JavaScript continue to be major contributors to page bloat. Ruthlessly eliminate unused code and unnecessary scripts.
- Optimize processing efficiency: JavaScript remains a significant source of energy consumption on user devices. Our data reveals a concerning trend of increased JavaScript usage. Whenever possible, opt for lighter alternatives or consider if the functionality is truly needed. Static HTML and CSS are often sufficient and far less resource-intensive.
- Prioritize lightweight assets: While text remains the most eco-friendly content type, our font analysis shows that even typography can contribute to waste. Choose the default system fonts where possible, and when using custom fonts, optimize their delivery. For images and videos, ensure they're compressed and only loaded when necessary.
- Design for longevity and accessibility: Create websites that function well on older devices and slower connections. This approach not only reduces environmental impact but also improves accessibility. By supporting older technology, we encourage longer device lifespans, which is one of the most impactful ways to reduce digital environmental footprint.
- Implement smart loading strategies: Use techniques like lazy loading, code splitting, and conditional loading to ensure that assets are only delivered when they're needed. This approach can significantly reduce unnecessary data transfer and processing.

#### Loading unused assets

You should only load assets that are essential for displaying the current view of the page. This can be achieved through techniques like lazy-loading, critical CSS extraction, and patterns such as <a hreflang="en" href="https://www.patterns.dev/vanilla/import-on-interaction">Import on Interaction</a> and <a hreflang="en" href="https://www.patterns.dev/vanilla/import-on-visibility">Import on Visibility</a>. It's also crucial to load assets, particularly images and fonts, at the appropriate size for each client device. In this section, we'll focus primarily on minimizing unused code and optimizing font loading, as our data shows these remain significant contributors to unnecessary page weight.

For further information, refer to:
The WSGs 1.0 - SC 2.7, 2.15-9, 2.23, 3.7, 3.18, and 3.19.

##### Fonts

For optimal sustainability, <a hreflang="en" href="https://www.smashingmagazine.com/2015/11/using-system-ui-fonts-practical-guide/">system fonts</a> remain the best choice, requiring no additional downloads. When custom fonts are necessary, consider these strategies to minimize environmental impact:
- Use the WOFF2 format for superior compression and broad support.
- Implement <a hreflang="en" href="https://the-sustainable.dev/reduce-the-weight-of-your-typography-with-variable-fonts/">variable fonts</a> to replace multiple font files with a single, versatile one.
- It would be nice to also use <a hreflang="en" href="https://everythingfonts.com/subsetter">subsets</a> or use a tool such as <a hreflang="en" href="https://github.com/Munter/subfont">subfont</a>.
- For custom fonts, use analysis tools to remove unnecessary glyphs or features.
- If using third-party font services, leverage their optimization options, but consider self-hosting for better control.

Remember, each additional font weight or style increases payload. Balance aesthetic needs with sustainability goals. For icons, consider Scalar Vector Graphics (SVG) instead of icon fonts for better efficiency and accessibility.

By thoughtfully approaching typography, we can create visually appealing websites while reducing data transfer and energy consumption.

For more detailed information, refer to our dedicated <a hreflang="en" href="./fonts">Fonts chapter</a> and stay updated with the latest web font optimization practices.

For further information, refer to:
- The WSGs 1.0 - SC 2.18 and 2.19.

##### Unused CSS

The environmental impact of excess code extends beyond mere inefficiency. It directly translates to increased energy consumption and a larger carbon footprint for both servers and user devices. While CSS frameworks boost development efficiency, they often introduce substantial amounts of unused styles. This bloat not only affects page load times but also unnecessarily increases data transfer and processing requirements. In an era of ever-growing global internet usage, the cumulative effect of this excess code on energy consumption is significant. Modern development tools have made identifying and eliminating unused CSS more accessible. Features like <a hreflang="en" href="https://developer.chrome.com/docs/devtools/coverage/">Chrome DevTools' Coverage analysis</a> offer powerful analysis to trim stylesheets. However, the practice of loading all CSS upfront for caching purposes presents a nuanced challenge. While it can reduce server requests and improve performance for returning visitors, it potentially increases the initial carbon cost of page loads. As web applications grow in complexity, striking a balance between comprehensive styling and sustainable practices becomes increasingly crucial. Unused CSS not only impacts user experience through slower initial loads but also contributes to increased energy usage in rendering and processing. Addressing unused CSS stands out as a tangible step developers can take to reduce the digital ecosystem's environmental impact.

{{ figure_markup(
  image="unused_css.png",
  caption="Unused CSS",
  description="A column chart showing that on the 90th percentile there is 225 KB of unused CSS on desktop and 212 KB on mobile, on the 75th percentile it’s 120 KB on desktop and 113 KB on mobile, on the 50th percentile 56 KB on desktop and 52 KB on mobile. On the 25th percentile we found 20 KB of unused CSS on desktop and 18 KB on mobile. Lastly, we saw 0 KB of unused CSS on the 10th percentile on either desktop and mobile",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=1281422688&format=interactive",
  sheets_gid="558117867",
  sql_file=""
) }}

Comparing the data from 2022 and 2024, we see some subtle changes. The 10th percentile remains unchanged, with no unnecessary CSS loaded, which is a positive sign but there's a slight increase in unused CSS across the remaining other percentiles.

These changes, while small, suggest a general trend towards slightly larger CSS footprints. This could be attributed to the growing complexity of web applications, the adoption of more feature-rich CSS frameworks, or an increase in the use of CSS for advanced styling and animations. The data reveals that by the 90th percentile, websites are still loading over 200KB of unused CSS. This represents a significant amount of unnecessary data transfer and processing, which can impact both performance and sustainability.

Despite these small increases, the overall picture hasn't changed dramatically since 2022. This suggests that while there have been some efforts to optimize CSS usage, there's still considerable room for improvement, especially for websites with higher percentiles.

For further information, refer to:
- The WSGs 1.0 - SC 3.4.

##### Unused JavaScript

Unused JavaScript significantly impacts energy consumption and carbon footprints of both servers and user devices. While JavaScript frameworks enhance development efficiency, they often introduce substantial unused code, affecting page load times and increasing data transfer unnecessarily.

Modern techniques like tree shaking and code splitting are crucial for optimizing JavaScript. The following steps will most probably help you to decrease your unused Javascript:
- Tree shaking eliminates dead code from the final bundle, particularly effective with ES6 modules.
- Code splitting breaks code into smaller chunks, loading only what's necessary for the current functionality.
- Carefully evaluating the JavaScript libraries and frameworks.
- Regularly doing code audits and refactoring to get bundle sizes smaller.

{{ figure_markup(
  image="unused_js.png",
  caption="Unused JS",
  description="A column chart showing that on the 90th percentile there is 907 KB of unused JavaScript on desktop and 812 KB on mobile, on the 75th percentile it’s 508 KB on desktop and 456 KB on mobile, on the 50th percentile 239 KB on desktop and 215 KB on mobile. On the 25th percentile we found 90 KB of unused JavaScript on desktop and 78 KB on mobile. Lastly, we saw 22 KB of unused JavaScript on desktop and 20 KB on mobile on the 10th percentile",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=904835139&format=interactive",
  sheets_gid="1021078155",
  sql_file=""
) }}

Comparing 2022 and 2024 data reveals significant increases across all percentiles.

By the 90th percentile, websites now load over 900KB of unused JavaScript for desktop and over 800KB for mobile, significantly impacting performance and sustainability. The disappearance of 0KB values at the 10th percentile indicates even the most optimized sites now include some unused JavaScript.

The substantial increase in unused JavaScript between 2022 and 2024 underscores the urgent need for the web development community to adopt these optimization techniques for improved performance and sustainability.

For further information, refer to:
- The WSGs 1.0 - SC 3.3 and 3.4.

#### Other technical optimizations

Different resource types have different energy intensity levels and this <a hreflang="en" href="https://greenspector.com/en/reduce-the-weight-of-a-web-page-which-elements-have-the-greatest-impact/">should be taken into account</a> when choosing what to include with your product or service. Syntax languages such as <a hreflang="en" href="https://websitesustainability.com/cache/files/research23.pdf">HTML and CSS [PDF]</a> are fairly simple but must render each component to the screen (creating emissions).

CSS has the added complexity of simple state-based interactions that can develop additional emissions (due to repainting) such as animations and transitions. JavaScript being a more technical language also has rendering requirements that can accumulate as the build complexity increases. It can also be used both on the client and server-side and can develop impacts while interacting with the page (due to its ability to manage state).

All server-side languages (such as PHP) will also have an impact on resource utilization and <a hreflang="en" href="https://greenlab.di.uminho.pt/wp-content/uploads/2017/10/sleFinal.pdf">energy efficiency [PDF]</&> (based on <a hreflang="en" href="https://attractivechaos.github.io/plb/">performance</a>). <a hreflang="en" href="https://michaelandersen93.substack.com/p/greening-the-web-a-study-on-low-carbon">Images</a> and media also have to be processed on the screen and due to their size and quality can be fairly impactful.

### Optimizing your content

Now that we've examined the environmental impact of websites, particularly focusing on unused CSS, JavaScript, and font usage, let's turn our attention to optimization. While removing unnecessary content and functionalities remains crucial, this year we're emphasizing the importance of efficiency in what remains.

In this section, we'll explore how to make your essential content as sustainable as possible. We'll delve into optimizing images, videos, animations, and fonts - elements that significantly contribute to a website's environmental footprint. By fine-tuning these components, we can substantially reduce resource consumption without compromising user experience.

For further information, refer to:
- The WSGs 1.0 - SC 2.8, 2.14, and 2.21.

#### Mobile First

Adopting a Mobile First approach not only enhances user experience but also offers significant sustainability benefits. By prioritizing essential content and functionality for mobile devices, we naturally create leaner, more efficient websites that consume less energy and bandwidth across all platforms.

This approach encourages developers to critically evaluate each element's necessity, leading to reduced data transfer and processing requirements. However, it's crucial to ensure that this doesn't result in multiple, device-specific versions of your site, which could potentially increase overall resource consumption.

When implemented thoughtfully, Mobile First design can lead to faster load times, lower energy consumption, and a smaller carbon footprint for your digital presence. It aligns well with other sustainability practices like minimizing unused code and optimizing assets.

For more detailed insights on how Mobile First impacts website performance, refer to our <a hreflang="en" href="./performance">Performance chapter</a>.

For further information, refer to:
- The WSGs 1.0 - SC 3.14.

#### Image optimization

Images remain a significant contributor to web page weight and energy consumption.

Optimizing images offers substantial sustainability benefits:
Reduced data transfer, lowering energy use in data centers and network infrastructure.
Decreased processing requirements on user devices possibly result in lower energy consumption.
Faster load times, potentially reducing user wait time and associated energy consumption.

When implementing image optimization, balance file size reduction with maintaining necessary quality. Utilize modern formats, responsive loading techniques, and appropriate compression levels. For detailed performance implications and technical implementations of image optimization strategies, refer to our <a hreflang="en" href="./performance">Performance chapter</a>.

For further information, refer to:
- The WSGs 1.0 - SC 2.15.

##### Format (WebP/AVIF)

The adoption of modern image formats continues to be a crucial factor in web sustainability. WebP, with its impressive compression and wide browser support, remains a go-to format for optimizing images. Meanwhile, AVIF is gaining traction, offering even better compression in many cases.
Let's look at how the usage of these formats has changed from 2022 to 2024:

{{ figure_markup(
  image="image-format-adoption-2-year-change.png",
  caption="Image format adoption, 2-year change",
  description="A bar chart showing the comparison of image formats adoption between 2022 and 2024. It shows that the jpg adoption is 20% less in 2024, while png increased 1%, gif is up by 6%, webp is 34% more, svg also increased with 36% more, ico is 17% less and avif is 386% more.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=2128858223&format=interactive",
  sheets_gid="1939630368",
  sql_file=""
) }}

This data shows the evolving landscape of image format adoption. WebP has grown significantly, with a 34% increase in usage. Although AVIF shows an impressive 386% increase, it can be misleading since for desktop clients the usage of AVIF format is only at 1.40%, and for mobile clients 1.05%. Traditional formats like JPEG are seeing a decline, while PNG and GIF usage remains relatively stable. Current statistics for 2024 provide a clearer picture of where we stand:

{{ figure_markup(
  image="image-format-adoption.png",
  caption="Image format adoption",
  description="A pie chart showing that overall, jpg represents the image format of 32.3% of all images. png is used in 28.4% of the images. Gif is used on 16.8% of the images. WebP is used on 12% of the images, Svg accounts for 6.4% of the images format. Ico represents the format used on 1.3% of all images and lastly, avif is the format of 1% of the images.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=1820261877&format=interactive",
  sheets_gid="1939630368",
  sql_file=""
) }}

Despite the clear benefits, many websites have yet to fully embrace these modern formats. The potential for reducing page weight and improving loading times remains significant. For optimal sustainability:
1. Use WebP as your primary format, falling back to JPEG or PNG for older browsers.
2. Consider implementing AVIF for browsers that support it (with a fallback), as it often provides superior compression.
3. For icons and simple graphics, optimized SVG remains the best choice. Consider inlining frequently used SVGs directly in your HTML to reduce HTTP requests.
4. For JPEG/WebP you can aim for 80-85% quality; adjust based on visual inspection.
5. Use srcset and sizes attributes to serve appropriate image sizes.
6. Lazy load non-critical images. Use loading="lazy" (native HTML attribute) for images below the fold.
7. Strip metadata. Remove unnecessary EXIF data to reduce file size (thus also avoiding potential privacy issues).
8. Implement a content negotiation strategy to serve the most efficient format based on browser capabilities.
9. Periodically review and re-optimize images as new techniques emerge.

Remember, while adopting these formats can significantly reduce data transfer and processing requirements, it's crucial to balance compression with maintaining necessary image quality. Over-compression can lead to degraded user experience and potential re-uploads, negating some of the sustainability benefits.

For more detailed information on implementing these formats and their performance implications, refer to our <a hreflang="en" href="./performance">Performance chapter</a>.

##### Responsiveness, size, and quality

As the diversity of devices accessing the web continues to grow, delivering appropriately sized images remains crucial for both performance and sustainability. Responsive image techniques allow us to serve optimized images for each scenario, reducing unnecessary data transfer and processing.
It's worth remembering that image quality doesn't always need to be at maximum.

TODO
{{ figure_markup(
  image="image-format-adoption.png",
  caption="Responsive image types",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=1820261877&format=interactive",
  sheets_gid="1939630368",
  sql_file=""
) }}

The data shows encouraging progress in the adoption of responsive image techniques:
1. Overall usage of the `srcset` attribute has increased significantly, from about 33-34% in 2022 to 42% in 2024 across both desktop and mobile.
2. The use of `srcset` with the `sizes` attribute, which provides more precise control over image selection, has also grown from around 25-26% to 32%.
3. There's a slight increase in the use of `srcset` without `sizes`, which, while not ideal, still offers some responsiveness benefits.
4. Usage of the `<picture>` element has seen a modest increase from 8% to around 9.3% across both desktop and mobile.

This trend indicates a growing awareness among developers about the importance of responsive images. However, there's still considerable room for improvement, as less than half of websites are currently utilizing these techniques.

To optimize your images for sustainability:
1. Implement `srcset` and `sizes` attributes to serve appropriately sized images for different viewport sizes.
2. Use the `<picture>` element for art direction and to serve modern formats like WebP and AVIF with appropriate fallbacks.
3. Optimize image quality, aiming for the sweet spot of size reduction without noticeable quality loss.
4. Consider implementing automated tools in your build process to generate and optimize responsive images.

While the trend is positive, there's still a long way to go before responsive images become ubiquitous. As web professionals, we should continue to advocate for and implement these techniques to create more sustainable and performant websites. For more detailed implementation strategies and performance impacts, refer to our <a hreflang="en" href="./performance">Performance chapter</a> and <a hreflang="en" href="./media">Media chapter</a>.

##### Lazy-loading

Lazy-loading remains a crucial technique for enhancing both performance and sustainability in web development. By loading images progressively we can significantly reduce initial page load times and unnecessary data transfer. This approach is particularly beneficial for sustainability, as it prevents the loading of images that users may never see, saving energy and resources.

{{ figure_markup(
  image="lazy-loading-adoption.png",
  caption="Adoption of loading=lazy on `<img>`",
  description="A timeseries chart showing the increase in the adoption of loading=\"lazy\" attribute on image tags. In June 2022 it was used by 24% of the websites on mobile and 23% on desktop. On January 2023, 26% of the websites on mobile were using native lazy-loading and 25% of them were using it on desktop. On June the 1st, 2023, 27% of websites used native lazy-loading on wither desktop and mobile. On June 2024, 34% of websites used native lazy-loading on mobile and 33% on desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQCSP87WE9bhFjIICxcrpIEGQlz3xBq33-ODZ8e91XSLUbLvAZjk25GhOdDtFIZCzPcS-VrSygr7pmz/pubchart?oid=1848380246&format=interactive",
  sheets_gid="228292115",
  sql_file=""
) }}

The past two year's data reflects a growing awareness of the importance of optimized image loading. However, there's still considerable room for improvement, as a significant portion of websites have yet to implement any form of lazy-loading. Regarding iframes, the advice remains largely unchanged:
1. Native lazy-loading can be applied to iframes, offering similar benefits as with images.
2. However, for optimal sustainability, consider avoiding iframes altogether when possible. Usage of iframes can lead to unnecessary resource consumption if overused or if embedded content isn't controlled or optimized (e.g., third-party trackers or ads).
3. The <a hreflang="en" href="https://developer.chrome.com/docs/lighthouse/performance/third-party-facades">facade pattern</a> remains a preferred approach for integrating external content like embedded videos or interactive maps.

For deeper insights & analysis, refer to our <a hreflang="en" href="./performance">Performance chapter</a> and <a hreflang="en" href="./media">Media chapter</a>.

##### Efficiently encoding images

Image encoding plays a crucial role in web sustainability, directly impacting the amount of data transferred across networks and the energy consumed in the process. Efficient encoding reduces the size of images, which often constitute a large portion of a web page's total size. This reduction in data transfer translates to lower energy consumption in data centers, network infrastructure, and user devices. Moreover, smaller, well-encoded images require less processing power to decode and render.

The cumulative effect of efficient image encoding across billions of web pages can lead to substantial global energy savings.

#### Video

Videos remain among the most resource-intensive elements on websites, significantly impacting sustainability. For more detailed information, refer to our <a hreflang="en" href="./media">Media chapter</a>. When incorporating third-party videos, utilizing facades is still the recommended approach.

Additionally, configure your videos thoughtfully:
1. Avoid preloading and autoplay to reduce unnecessary data transfer.
2. Implement lazy loading for videos below the fold.
3. Use appropriate compression techniques to reduce file sizes without compromising quality.
4. Consider using adaptive bitrate streaming for varying network conditions.

Remember, every optimization in video delivery can lead to substantial energy savings given the large file sizes involved. Balancing video quality with sustainability goals is key to creating engaging yet environmentally responsible web experiences.

For further information, refer to:
- The WSGs 1.0 - SC 2.16.

##### Preload

Automatically preloading videos is a concern for web sustainability. This practice involves retrieving data that might not be useful for all users, potentially leading to unnecessary data transfer and energy consumption, especially on pages with high traffic volumes. From a sustainability perspective, preloading should ideally be avoided or only initiated upon user interaction.

{{ figure_markup(
  image="video-preload-usage.png",
  caption="Video preload usage",
  description="A column chart showing the preload attribute is not used on 54.9% of desktop videos and 56.3% of mobile videos. The preload attribute can be found with the none value on 18.2% of desktop videos and 15.9% of mobile videos. The auto value is used on 15.1% of desktop videos 14.5% of mobile videos. The metadata value is used on 9.5% of desktop videos and 11.2% of mobile videos. The preload attribute is empty on 1.4% of both desktop and mobile videos. The preload attribute has a value TRUE on 0.3% of both desktop and mobile videos. The preload attribute has a value of FALSE, preload or yes on 0.1% of both desktop and mobile videos. Lastly, it has the value of undefined on 0.05% of the videos on both desktop and mobile",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=1517696872&format=interactive",
  sheets_gid="1377676306",
  sql_file=""
) }}

Comparing the usage of the preload attribute between <a hreflang="en" href="../2022/sustainability">2022</a> and 2024, we observe some changes. The percentage of websites not using preload has slightly decreased, from 57.6% to 54.94% on desktop and from 59.5% to 56.27% on mobile. This shift suggests a small increase in the use of preload attributes, which could have implications for sustainability.

It's important to remember that the preload attribute only has three valid values: none, auto, and metadata (default). Using the preload attribute with no value or an incorrect value may be interpreted as 'metadata', which can still involve loading up to 3% of the video to retrieve metadata. From a sustainability standpoint, 'none' remains the most environmentally friendly option.

The slight increase in the use of 'metadata' and the decrease in non-use of preload suggest that more attention needs to be paid to video preloading practices to enhance web sustainability.

For more detailed information on this topic, refer to <a hreflang="en" href="https://www.stevesouders.com/blog/2013/04/12/html5-video-preload/">Steve Souders' 2013 article</a> and <a hreflang="en" href="https://web.dev/articles/fast-playback-with-preload">the web.dev 2017 article</a> on video preloading strategies.

##### Autoplay

The considerations surrounding autoplay continue to be critical from a sustainability perspective. Autoplaying videos consume data and energy for content that users might not be interested in viewing, potentially leading to unnecessary resource usage.

It's important to note that the autoplay attribute can override preload settings, as autoplaying naturally requires loading the video content. This forced loading further impacts data consumption and energy use.

{{ figure_markup(
  image="video-autoplay-usage.png",
  caption="Video autoplay usage",
  description="A column chart showing that the autoplay attribute has empty value on 47.2% of videos on desktop and 45.7% on mobile. The autoplay attribute is not used on respectively 44.5% and 44.9% of desktop and mobile videos. It is used with an ’autoplay’ value on 5.8% of desktop videos and 5.7% of mobile videos. It is used with an value ’TRUE’ on 2% of desktop videos and 3.2% of mobile videos. It is used with an value ’1’ on 0.3% of both desktop and mobile videos. It is used with an value ’FALSE’ on 0.2% of desktop and mobile videos. It is used with an value ’yes’ on 0.01% of desktop and mobile videos.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=1761138794&format=interactive",
  sheets_gid="215678116",
  sql_file=""
) }}

Comparing the usage of autoplay between <a hreflang="en" href="../2022/sustainability">2022</a> and 2024, we see some notable changes. The percentage of websites explicitly not using autoplay has decreased, from 53.1% to 44.54% on desktop and from 52.6% to 44.88% on mobile. This could be a concern for sustainability efforts. Also, we notice a slight increase for websites using an empty value for this attribute, which also triggers autoplay (and is bad for sustainability).

It's crucial to remember that autoplay is a Boolean attribute, meaning its presence, even with an empty value, triggers autoplay behavior. The combined percentage of explicit autoplay usage (including 'autoplay', 'TRUE', '1', and 'yes' values) has remained relatively stable, around 8% for both desktop and mobile.

Given the sustainability implications, the trend towards more potential autoplay usage (through empty values) is worrying. Developers should be cautious about including the autoplay attribute, even if unintentionally, as it can lead to unnecessary data consumption and energy use. From a sustainability perspective, avoiding autoplay remains a recommended practice in most cases to reduce unnecessary data transfer and processing.

#### Animations

Animations continue to be a double-edged sword in web design. While they can enhance user experience, they pose challenges for both accessibility (more on this in the <a hreflang="en" href="./accessibility">Accessibility chapter</a>) and sustainability.

From a sustainability perspective, animations can be resource-intensive:
- They increase battery consumption and CPU/GPU usage, potentially reducing device longevity, especially on mobile devices.
- Animations often require additional code, which can delay rendering and increase page weight.
- Poorly optimized animations can lead to unnecessary repaints and reflows, further taxing device resources.

Recent data on <a hreflang="en" href="https://web.dev/articles/stick-to-compositor-only-properties-and-manage-layer-count">non-composited animations</a> provides insight into their usage across websites:

TODO
{{ figure_markup(
  image="video-autoplay-usage.png",
  caption="Non-composited animations per page",
  description="A column chart showing that on the 90th percentile there are 12 non-composited animation on desktop and 11 on mobile. On the 75th percentile it goes down to 3 on desktop and 2 on mobile. On the 50th, the 25th and the 10th percentile there are 0 non-composited animations on both desktop and mobile",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=1761138794&format=interactive",
  sheets_gid="215678116",
  sql_file=""
) }}

This data reveals:
- At least 50% of websites don't use non-composited animations, which is positive from a sustainability perspective.
- There's a significant jump in usage at the higher percentiles, with the 90th percentile showing 12 animations on desktop and 11 on mobile. This jump could severely impact the accessibility, performance, and sustainability of the webpage.

The case of carousels remains contentious: users, developers, and designers tend to despise them while organizations stick to them.

For arguments against using carousels, visit:
- <a hreflang="en" href="https://shouldiuseacarousel.com/">Should I Use A Carousel</a>
- <a hreflang="en" href="https://www.smashingmagazine.com/2023/08/designing-better-carousel-ux/">Usability Guidelines For Better Carousels UX</a>

If animations are necessary for your design:
- Use CSS animations where possible, as they're generally more performant than JavaScript-based animations.
- Consider using the `prefers-reduced-motion` media query to respect user preferences for reduced motion.
- Lazy-load animations that are not immediately visible on page load.

For further information, refer to:
- The WSGs 1.0 - SC 2.17.

#### Favicon and error pages

Favicons and error pages continue to play a subtle but important role in website performance and sustainability.

Key considerations remain:
- Always include a favicon to prevent unnecessary 404 requests.
- Ensure your favicon is properly cached to reduce repeated requests.
- Optimize your 404 page HTML to be as lightweight as possible.
- Set up redirects properly, so that users find the content they are looking for.
- While browsing to a missing page should lead to a 404 page, loading a missing resource should <a hreflang="en" href="https://httpd.apache.org/docs/2.4/en/custom-error.html">return a text message</a> rather than the whole 404 HTML page (as is the case with some servers). You should also <a hreflang="en" href="https://www.deadlinkchecker.com/">look for dead links</a>.

For <a hreflang="en" href="https://evilmartians.com/chronicles/how-to-favicon-in-2021-six-files-that-fit-most-needs">optimal favicon</a> sustainability:
1. SVG: The ideal choice. SVGs are lightweight, scalable, and eliminate the need for multiple sizes, significantly reducing data transfer and storage needs.
2. Optimized PNG: A well-optimized PNG (180x180 pixels for iOS in the base directory named apple-touch-icon.png) can be a good compromise between file size and broad compatibility. Note the filename and location requirements as browsers will seek this (based on the meta tag if used) if no SVG is provided.
3. A favicon.ico with sizes 32x32 and 16x16 for compatibility purposes (older browsers will seek this within your base directory so having the file will reduce errors).
These formats, when properly implemented, minimize data transfer, reduce storage requirements, and lower energy consumption across the web ecosystem. Always ensure your chosen format is properly optimized for the best sustainability impact.

{{ figure_markup(
  image="favicon-usage.png",
  caption="Favicon usage",
  description="A bar chart showing that png is the format used for favicons on 41.9% of pages on both desktop and mobile. ico format is used by 28.3% on desktop and 27.2% on mobile. Favicon is missing in 17.2% on desktop and 17.9% on mobile. jpg is the format used by 6.2% on desktop and 6.5% on mobile. Svg is used by 1.4% on both desktop and mobile. NO_EXTENSION, webp, NO_DATA, gif, jpeg and NO_HREF repersent less than 1% each, on desktop and mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=1102352877&format=interactive",
  sheets_gid="1918305009",
  sql_file=""
) }}

When we compare the 2024 data to <a hreflang="en" href="../2021/markup#favicons">2021 data</a> (since there was no favicon data since the <a hreflang="en" href="../2021/markup#favicons">2021 Markup chapter</a>), we can say that the changes from 2021 to 2024 indicate a positive trend towards more sustainable favicon practices. The shift from ICO to more efficient formats like PNG, SVG, and WebP suggests improved awareness of file size and performance impacts. Also, the reduction in missing icons demonstrates better attention to detail, reducing unnecessary server requests. Finally, the growth in SVG and WebP usage, while still small, represents a move towards more sustainable, scalable formats.

While there's still room for improvement, particularly in further adopting highly efficient formats like SVG and WebP, the overall trend suggests that developers are increasingly considering the sustainability implications of even small elements like favicons.

For further information, refer to:
- The WSGs 1.0 - SC 3.18 and 4.4.

### Optimizing external content

{# TODO - add intro paragraph #}

#### Third parties

Since third-party requests make up a large portion of requests on the web, it's interesting to make sure they come from "green" hosts. Back in 2022, we estimated that 91% of third-party requests came from "green" hosts. As of 2024, it has risen to a whopping 97%!

{{ figure_markup(
  image="green-third-party-requests.png",
  caption="% green third-party requests",
  description="A column chart showing that on the top 1,000 websites 72% of third party requests relied on green hosting on desktop and 70% on mobile devices. On the top 10,000 websites it’s 78% on both desktop and mobile. For the top 100,000 sites it’s 88% on both desktop and mobile. On the top million, it’s 94% on desktop and 93% on mobile. Overall, we see that 97% of third party requests rely on green hosting on both desktop and mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=1139458989&format=interactive",
  sheets_gid="176951784",
  sql_file=""
) }}

This sure looks like really great news but you should keep in mind this is somewhat biased. Most third-parties originate from Google whose servers are considered "green". More generally, many cloud providers are considered "green" but the truth might be slightly more complicated, as explained in our Green Hosting section.

You should look at this year's <a hreflang="en" href="./third-parties">Third-parties chapter</a> for more on all this.

Third-party resources, while often essential for modern web functionality, can significantly impact a website's sustainability and performance. These external assets, ranging from scripts to stylesheets, can increase page weight and create performance bottlenecks. All of these factors contribute to higher data transfer and energy consumption.

To create more sustainable websites, it's crucial to regularly audit and optimize third-party usage. This process might involve removing unnecessary services.

Tools like Google's Lighthouse offer valuable insights into the impact of third-party code on site performance. The Third-Party Usage audit in Lighthouse can help identify how external resources affect page load time and overall performance.

By thoughtfully managing third-party resources, we can strike a balance between necessary functionality and website efficiency. This approach not only improves user experience but also contributes to a more sustainable web ecosystem.

##### Making third-party requests more sustainable

Making third-party requests more sustainable requires a strategic approach from the earliest stages of development. While outsourcing certain services can potentially reduce development time and redundancy, it's crucial to rigorously assess each third-party component for its ecological impact.

Prioritize self-hosted content over embedded third-party services whenever possible. This approach gives you greater control over performance and emissions. For unavoidable third-party content, implement a 'click-to-load' delay screen using the "import on interaction" pattern. This technique significantly reduces initial page load and unnecessary data transfer.

When evaluating libraries and frameworks, opt for performant alternatives that achieve the same goals with less overhead, keeping in mind that not using such tools could also be a possibility (thus sticking to vanilla JS for instance). Consider creating your own clickable icons and widgets rather than relying on third-party hosted solutions.

By carefully managing third-party integrations and prioritizing user preferences, we can significantly reduce the ecological footprint of our digital products while maintaining functionality and user experience. This is also usually beneficial to performance, security, privacy, and accessibility.

For further information, refer to:
- The WSGs 1.0 - SC 3.7.

For more detailed information on analyzing and optimizing third-party usage, refer to the <a hreflang="en" href="https://developer.chrome.com/docs/lighthouse/performance/third-party-summary">Chrome Developers documentation</a>.

### Implementing technical optimizations

Historically, web performance introduced a lot of recommendations that contribute to efficiency, thus improving sustainability. It also sometimes encourages frugality. But there are still some performance recommendations that could be detrimental to environmental impacts (or at least need some discussion and careful consideration). For instance, CDN should be treated with care (see dedicated section below) and preloading or predictive loading should be avoided because they might result in loading resources that will never be used.

#### JavaScript

JavaScript has been an important language in the web's growth, enabling dynamic and interactive experiences. However, when not optimized, it can also impact performance and energy consumption. Let's focus on some quick wins: optimizations that are easy to implement and great for sustainability. These tweaks can significantly improve your site's efficiency without sacrificing functionality. For a deeper dive into JavaScript's pros and cons, check out our comprehensive <a hreflang="en" href="./javascript">JavaScript chapter</a>.

##### Minification, Tree Shaking & Code Splitting

Optimizing JavaScript through minification, tree shaking, and code splitting remains crucial for improving website performance and sustainability. By focusing on these optimization techniques, we can significantly reduce data transfer, improve load times, and ultimately decrease the energy consumption associated with web browsing. Remember, even small savings per site can lead to substantial cumulative benefits across billions of page views.

{{ figure_markup(
  image="unminified-js-savings.png",
  caption="Unminified Javascript savings",
  description="A column chart showing that on the 90th percentile 41 KB of JavaScript could be saved on desktop and 37 KB on mobile if using JS minifying. On the 75th percentile 10 KB of JavaScript could be saved on desktop and 8 KB on mobile. On the 50th, 25th and 10th percentile we see no KB savings, this is explained by the usage of JavaScript minifying already in place on those websites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=260477538&format=interactive",
  sheets_gid="619269903",
  sql_file=""
) }}

Compared to 2022, these figures show a slight increase in potential savings at the higher percentiles, indicating that some websites have accumulated more unminified code.

While many sites are effectively minifying JavaScript, there's still significant potential for savings, especially for larger sites.

As developers, we can make our apps & websites more sustainable by:
- Implement tree shaking to eliminate dead code, which can provide additional savings beyond minification.
- Use code-splitting to load JavaScript on demand, reducing initial payload sizes.


For a deeper dive into JavaScript's pros and cons, check out our comprehensive <a hreflang="en" href="./javascript">JavaScript chapter</a>.

For further information, refer to:
- The WSGs 1.0 - SC 3.2.

#### CSS

Cascading Stylesheets (CSS) have also been a critical feature in the growth of the Internet's popularity. The ability to add stylistic flourishes to pages and apps brings a unique visual appeal to content and features. The visual complexity of the Web however brings with it challenges in offering a sustainable product or service.

Web performance plays a critical role as too many page repaints or heavy burdens on the CPU can consume energy on the client-side. CSS also has to consider factors such as how it makes the best use of the form it is being consumed on to avoid triggering asset loading unnecessarily or wasting critical material resources if turned into a physical object (printing).

Let's focus on some quick wins, some of which will be familiar to you from the JavaScript section to help improve your code efficiency without sacrificing functionality.

##### Minification

While minification for JavaScript is a common practice (as mentioned earlier in this chapter), it's also important to recognize the value of minifying other <a hreflang="en" href="https://web.dev/articles/optimizing-content-efficiency-optimize-encoding-and-transfer?hl=en">static text assets</a> such as CSS files due to the data savings that can be obtained. Tools within IDEs can help automate and streamline this process to increase efficiency.

{{ figure_markup(
  image="unminified-css-savings.png",
  caption="Unminified CSS savings",
  description="A column chart showing that on the 90th percentile 14 KB of CSS could be saved on desktop and 13 KB on mobile if using CSS minifying. On the 75th percentile 4 KB of CSS could be saved on both desktop and mobile. On the 50th, 25th and 10th percentile we see no KB savings, this is explained by the usage of CSS minifying already in place on those websites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=1448481615&format=interactive",
  sheets_gid="1866069863",
  sql_file=""
) }}

Compared to 2022, these figures show a slight decrease in potential savings, suggesting a modest improvement in CSS minification practices or potentially a shift towards more efficient CSS authoring. The decrease in potential CSS savings since 2022 indicates progress, but further optimization is possible.

As developers, we can make our apps & websites more sustainable by:
- Consider using CSS Modules approaches, which can help eliminate unused styles.
- Implement critical CSS techniques to inline essential styles and defer the loading of non-critical CSS.

For further information, refer to:
- The WSGs 1.0 - SC 3.2-4.

##### Print stylesheet

Reducing the impact of physical documents is critically important because any single-use item not only uses material resources (such as paper and ink), but there is a risk involved that the item may not be recycled properly, or that its production may not come from a sustainable source. Therefore we must treat the creation of such items as a precious commodity and avoid producing more than is required to reduce excess waste.

Having a <a hreflang="en" href="https://www.smashingmagazine.com/2018/05/print-stylesheets-in-2018/">print-friendly stylesheet</a> (using the @media print and @page at-rule) will allow you to define styles that stylistically affect how the end product will appear on the <a hreflang="en" href="https://alistapart.com/article/goingtoprint/">printed page</a>. This allows you to organize content to fit onto the page better, remove content that doesn't transcend well from digital to print (such as navigation), and include extra information where appropriate (for URLs alongside links as an example).

When creating a print-friendly stylesheet, be considerate of the user preference towards color or monochrome output, the color of paper used in the printer tray, the size of paper provided for printing, and the orientation of paper (responsive design of a sort that exists in print).

For further information, refer to:
- The WSGs 1.0 - SC 2.23 and 3.13.

##### User Preferences (Dark mode)

Visitors have their preferred way of browsing websites, and one of the most common preferences is "lights on or off" otherwise known as the use of dark mode. While this may outwardly appear to be a visual or stylistic choice, there are some sustainability and accessibility considerations to take into account with this choice.

Before we get into the sustainability benefits, it is worth quickly discussing that while the use of dark mode for some people can increase readability, it can affect others negatively by acting as a trigger for people with <a hreflang="en" href="https://www.boia.org/blog/dark-mode-can-improve-text-readability-but-not-for-everyone">astigmatism</a>, It is therefore important that the ability to turn on and off features like dark mode be available to visitors and user preferences (on OS or browser) taken into account.

Dark mode itself can be a real benefit for sustainability on OLED screens due to the use of <a hreflang="en" href="https://www.youtube.com/watch?v=N_6sPd0Jd3g">dimmed pixels</a> (blacks and <a hreflang="en" href="https://greentheweb.com/energy-efficient-color-palette-ideas/">low colors</a>). Studies have shown that on such devices the <a hreflang="en" href="https://engineering.purdue.edu/ECE/News/2021/dark-mode-may-not-save-your-phones-battery-life-as-much-as-you-think-but-there-are-a-few-silver-linings">reduction of energy use</a> can vary but it does make a <a hreflang="en" href="https://www.businessinsider.com/guides/tech/does-dark-mode-save-battery?r=US&IR=T">real difference</a> (and as the screen is the primary energy emitter for handheld devices, this is important).

There are several other user-preference <a hreflang="en" href="https://polypane.app/blog/the-complete-guide-to-css-media-queries/">media queries</a> available to CSS that may (depending on usage) have sustainability benefits for your visitors such as monochrome (to default printing to a single cartridge type), prefers-reduced-motion (to reduce processor-intensive animated effects), and the upcoming <a hreflang="en" href="https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-reduced-data">prefers-reduced-data</a> (that allows designing around low bandwidth devices).

For further information, refer to:
- The WSGs 1.0 - SC 3.13.

For a deeper dive into CSS's pros and cons, check out our comprehensive <a hreflang="en" href="./css">CSS chapter</a>.

#### Including as little code as possible directly in HTML

The practice of inlining JavaScript and CSS directly in HTML can bloat HTML files and potentially harm overall performance and sustainability, as well as security. This issue is particularly prevalent in websites built with Content Management Systems (CMS) and those implementing the <a hreflang="en" href="https://web.dev/articles/extract-critical-css">Critical CSS method</a>.

The importance of the <a hreflang="en" href="https://meiert.com/en/blog/what-happened-to-separation-of-concerns/">separation of concerns</a> (HTML, CSS, and JavaScript) cannot be understated as also touched upon earlier in this chapter. While CSS can't defer or asynchronously load assets like JavaScript that would be render-blocking (without reliance on JavaScript itself), it still retains the same key benefit of being able to cache such assets. In doing so, a large library of CSS styles can be re-used among many pages without having to be re-downloaded.

For further information, refer to:
- The WSGs 1.0 - SC 3.17.

{{ figure_markup(
  image="style-usage.png",
  caption="Style usage",
  description="A bar chart showing that on desktop, 30.8% of CSS is inline and the other 69.2% comes from external stylesheets. On mobile the inline CSS goes up to 32.35% while 67.65% comes from external stylesheets",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=812833828&format=interactive",
  sheets_gid="109015092",
  sql_file=""
) }}

When we compare this year's data to <a hreflang="en" href="../2022/sustainability">2022 data</a> we can see the following:
1. Increase in inline stylesheet usage:
    - Desktop: from 25% in 2022 to 30.77% in 2024.
    - Mobile: from 25% in 2022 to 32.35% in 2024.
2. A corresponding decrease in external stylesheet usage:
    - Desktop: from 75% in 2022 to 69.23% in 2024.
    - Mobile: from 75% in 2022 to 67.65% in 2024.

This trend shows a clear shift towards more inlining of CSS, particularly on mobile devices. While this approach can improve initial render times by reducing HTTP requests, it also presents challenges:
- Increased HTML file sizes, potentially slowing down initial page loads.
- Reduced caching efficiency, as inline styles, can't be cached separately from HTML.
- Potential for redundant code across multiple pages.
In the end, even though inlining critical CSS could help reduce the initial render time we must be careful to not inline more than that because it could have the exact opposite effect and delay the initial render.

#### Obsolete code

In the rapidly evolving landscape of web development, obsolete code is an often overlooked source of inefficiency that can significantly impact a website's sustainability footprint.

Obsolete code refers to unnecessary, outdated, or redundant code that remains in a codebase. This can include:
- Deprecated JavaScript and CSS features.
- Polyfills for outdated browsers.
- Unused functions or styles from previous iterations of a site.
- Legacy code supporting discontinued features.

From a sustainability perspective, obsolete code is problematic for several reasons:
1. Increased File Size: Obsolete code bloats JavaScript and CSS files, leading to larger file sizes. This results in increased data transfer, consuming more energy both in transmission and processing.
2. Unnecessary Processing: Browsers still need to parse and execute obsolete code, even if it's not used. This consumes additional CPU cycles and, consequently, more energy on user devices.
3. Maintenance Overhead: Obsolete code makes codebases harder to maintain, potentially leading to inefficient workarounds and further code bloat over time.
4. Security: Obsolete code is much more likely to have known security issues that could put users at risk.

For further information, refer to:
- The WSGs 1.0 - SC 2.29 and 3.20.

#### CDN

Content Delivery Networks (CDNs) play a crucial role in optimizing web performance and, by extension, improving the sustainability of web applications. By distributing content across multiple, geographically dispersed servers, CDNs reduce the distance data needs to travel, leading to faster load times and reduced energy consumption.

{{ figure_markup(
  image="cdn-usage.png",
  caption="CDN usage on the web",
  description="A column chart showing that 66.9% of the pages analyzed do not use any CDN on desktop and 67.2% on mobile, 18.3% of them use Cloudflare on desktop and 18.2% on mobile, 7.4% of them use Google on desktop and 7.9% on mobile, 2.3% use Amazon Cloudfront on desktop and 2% on mobile, 2.2% use Fastly on desktop and 1.9% on mobile, 0.6% use Automattic on desktop and 0.7% on mobile, 0.6% use Akamai on desktop and 0.5% on mobile, 0.8% use Vercel on desktop and 0% on mobile, 0% use Sucuri Firewall on desktop and 0.7% on mobile. Netlify and Incapsula are both used on 0.3% of the page tested on desktop and 0.2% on mobile. Microsoft Azure is used on 0.2% of the pages on desktop and 0.1% on mobile.Lastly, we see Azion used on 0% of the pages on desktop and 0.2% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=1471666916&format=interactive",
  sheets_gid="232665838",
  sql_file=""
) }}

Comparing this data to  <a hreflang="en" href="https://developer.chrome.com/docs/devtools/coverage">2022 data</a>, we observe several notable trends:
- Increased CDN Adoption: The percentage of websites not using a CDN has decreased from 69.7% to 66.88% for desktop and from 71.2% to 67.20% for mobile. This indicates a growing recognition of CDN benefits.
- Cloudflare's Growth: Cloudflare has solidified its position as the leading CDN provider, increasing its market share from 16.9% to 18.28% on desktop and from 15.1% to 18.16% on mobile.
- Google's Expansion: Google's CDN usage has seen significant growth, rising from 5.2% to 7.40% on desktop and from 6.5% to 7.95% on mobile.
- Shifts in the Market: While Fastly has seen a slight decrease in usage, Amazon CloudFront has maintained its position. Newer players like Vercel have entered the top 10, indicating a dynamic and evolving CDN market.

From a sustainability perspective, the increased adoption of CDNs is a positive trend:
- Reduced Data Travel: By serving content from geographically closer locations, CDNs minimize the distance data needs to travel, reducing overall network energy consumption.
- Improved Caching: CDNs often provide advanced caching mechanisms, reducing the need for repeated data transfers and server processing.
- Load Balancing: By distributing traffic across multiple servers, CDNs can help prevent server overload, potentially reducing energy consumption during traffic spikes.
- Edge Computing: Many modern CDNs offer edge computing capabilities, allowing for data processing closer to the end-user, which can further reduce energy consumption.

For a deeper dive into CDNs, check out our comprehensive  <a hreflang="en" href="https://developer.chrome.com/docs/devtools/coverage">CDN chapter</a>.

For further information, refer to:
- The WSGs 1.0 - SC 4.10.

#### Text compression

Text compression is a crucial technique for reducing the size of transmitted data, playing a significant role in improving both website performance and sustainability. By compressing text-based resources such as HTML, CSS, and JavaScript before sending them over the network, we can substantially reduce data transfer and, consequently, energy consumption.

Common text compression methods include:
- <a hreflang="en" href="https://www.gnu.org/software/gzip/">Gzip</a>: Widely supported and effective for most text-based content, typically achieving 60-80% compression ratios.
- <a hreflang="en" href="https://github.com/google/brotli">Brotli</a>: A newer algorithm that often outperforms Gzip, especially for smaller files, with potential compression improvements of 15-25% over Gzip.
- <a hreflang="en" href="https://github.com/google/zopfli">Zopfli</a>: A Gzip-compatible algorithm that can achieve better compression ratios but at the cost of longer compression times, making it suitable for static content.
- <a hreflang="en" href="https://facebook.github.io/zstd/">Zstandard (zstd)</a> is also a serious contender that shows great performance for both compression and decoding.

More on this in this article from <a hreflang="en" href="https://paulcalvano.com/2024-03-19-choosing-between-gzip-brotli-and-zstandard-compression/">Paul Calvano</a>.

{{ figure_markup(
  image="text-compression.png",
  caption="Compression used on text resources",
  description="A bar chart showing that on desktop 21.6% of text resources are compressed using Brotli format, 24% of them where compressed in Gzip and 53.5% are not compressed, while 0.9% are using other compression format. On mobile, 23% of text resources are compressed using Brotli format, 24.6% of them where compressed in Gzip and 51.4% are not compressed at all, while 0.9% were compressed with other formats.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=962026195&format=interactive",
  sheets_gid="1229329467",
  sql_file=""
) }}

The data shows that over half of websites are not using any form of text compression, with 53.47% of desktop sites and 51.38% of mobile sites sending uncompressed content. This represents a significant missed opportunity for reducing data transfer and, consequently, energy consumption.

Among sites using compression, Gzip is slightly more prevalent than Brotli, being used by 24.05% of desktop sites and 24.65% of mobile sites. Brotli, despite its superior compression capabilities, is used by 21.59% of desktop sites and 23.03% of mobile sites.

Given that text compression can significantly reduce data transfer volumes, the widespread lack of adoption represents a substantial opportunity for enhancing the web's energy efficiency. Encouraging the use of compression, particularly more efficient algorithms like Brotli, could lead to meaningful reductions in data center energy usage, network traffic, and client-side processing requirements.

As we move towards a more sustainable web, text compression remains a key tool in our optimization toolkit, offering a relatively simple yet highly effective way to reduce our digital carbon footprint.

For further information, refer to:
- The WSGs 1.0 - SC 4.3.

#### Caching

Caching is a crucial technique in web optimization that significantly contributes to sustainability efforts. By reducing the need for repeated data transfers and server processing, caching plays a vital role in minimizing the energy consumption associated with web operations.

From a sustainability perspective, effective caching offers several key benefits:
- Reduced Data Transfer: By storing resources closer to the user, caching dramatically decreases the amount of data transmitted over networks. This directly translates to lower energy consumption across the web infrastructure.
- Decreased Server Load: With fewer requests reaching origin servers, the overall energy usage in data centers can be significantly reduced.
- Cumulative Environmental Impact: For frequently accessed resources, the energy savings compound with each cache hit, potentially leading to substantial reductions in overall carbon footprint over time.

{{ figure_markup(
  image="cache-control-header-usage.png",
  caption="Cache control header usage",
  description="A bar chart showing that on desktop 26.6% of websites use Cache Control Only, 0.4% of them use Expiries only and 48.1% of them use both. 24.9% of the websites do not use any caching on desktop. On mobile 25.9% of websites use Cache Control Only, 0.4% of them use Expiries only and 48.6% of them use both. 25.1% of the websites do not use any caching on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=834455986&format=interactive",
  sheets_gid="1192354424",
  sql_file=""
) }}

An analysis of cache header usage between 2022 and 2024 reveals subtle shifts in caching practices:
- The use of both Cache-Control and Expires headers has slightly decreased, from 51% to 48.08% on desktop and 48.57% on mobile. Conversely, the use of Cache-Control only has increased from 23% to 26.65% on desktop and from 22% to 25.92% on mobile.
- The percentage of sites using neither caching header has remained relatively stable, with a marginal decrease from 25% to 24.89% on desktop and a slight decrease from 26% to 25.13% on mobile.

While these changes are modest, they indicate a trend toward more focused use of Cache-Control headers. From a sustainability perspective, the persistent quarter of websites using no caching headers represents a significant opportunity for improving resource efficiency and reducing unnecessary data transfers.

The shift towards Cache-Control only usage suggests a growing awareness of modern caching best practices, as Cache-Control offers more granular control over caching behavior. However, the overall slight decrease in caching header usage underscores the ongoing need to emphasize the importance of effective caching strategies in creating a more sustainable web ecosystem.

For more detailed information on caching techniques, implementation strategies, and performance implications, please refer to our comprehensive <a hreflang="en" href="./performance">Performance Chapter</a>.

For further information, refer to:
- The WSGs 1.0 - SC 4.2.

## SEO and sustainability

The advent of Search Generative Experiences in 2024 brings new sustainability concerns to light regarding Search Engine Optimization (SEO). The <a hreflang="en" href="https://mashable.com/article/ai-environment-energy">energy and water requirements</a> to power these AI-enabled searches are significant. By some estimates, a single AI-powered search can use <a hreflang="en" href="https://www.scientificamerican.com/article/what-do-googles-ai-answers-cost-the-environment/">as much as 30 times more energy</a> than a traditional search.

As with most web sustainability concerns, challenges are directly proportional to volume. We conduct billions of searches every day. Plus, Search Generative Experiences have been known to produce misleading, inaccurate, or false results. This increases misinformation risk as well as environmental impact when billions of searchers must rethink and re-run their queries to produce more accurate results.

What's more, there's currently no way to opt out of using these features. Web teams and digital marketers are forced to incorporate AI search features into their day-to-day practices.

To make SEO efforts more sustainable, marketers will also need to tackle important questions such as:

- Can AI and other emerging technologies help us execute search campaigns more efficiently or are the social and environmental impacts simply not worth the effort?
- How should we balance the need to consistently produce good content with limitations imposed by organizational resources and our stated climate goals?
- Are our content marketing efforts reaching the right audience and helping them to make better decisions and more sustainable choices?
What should we do with old or otherwise outdated content to maintain relevance?
- Do we need to hold onto search and analytics data from seven years ago? Or even three?

With this in mind, here are seven ways to bring more <a hreflang="en" href="https://www.mightybytes.com/blog/sustainable-seo/">sustainable SEO strategies</a> into your search marketing efforts:

1. Provide measurable benefits to the people and communities you target, helping them find the information they need quickly and without barriers.
2. Utilize <a hreflang="en" href="https://developers.google.com/search/blog/2022/12/google-raters-guidelines-e-e-a-t">E-E-A-T—Experience</a>, Expertise, Authoritativeness, and Trustworthiness—to focus on quality over quantity in search marketing efforts.
3. Create search marketing processes that can be realistically measured and maintained over time through continuous improvement. Include sustainability metrics in these efforts, doing more of what works and less of what doesn't.
4. <a hreflang="en" href="https://bthechange.com/7-ways-to-align-climate-strategy-with-digital-marketing-strategy-9668a3a3bda">Reduce negative effects</a> where possible to minimize search marketing's impact on the planet.
5. As with any web sustainability initiative, reduce the amount of data you transfer, collect, and store.
6. Well-structured metadata can convey critical information about your website that can be used to educate potential visitors. For many sites, their purpose can be satisfied without a user ever actually visiting their domain.
7. Finally, align your search marketing efforts with the W3C Web Sustainability Guidelines (WSGs) 1.0, particularly SC 2.6, 2.14, 2.15, 2.16, 2.19, 3.5, 3.12 and 4.4.

It is possible to <a hreflang="en" href="https://www.mightybytes.com/blog/sustainable-digital-marketing/">redefine success</a> by including stakeholder perspectives and needs in our marketing, making it an engine of well-being versus the more traditional engine of (often exploitative) growth. As part of these efforts, we also need search platforms to take ownership and action on their own roles in exacerbating the climate crisis.

## Sustainable data and content management

Tech platform business models often depend on customers increasing data use over time. As part of their marketing strategies, platforms encourage customers to upgrade and purchase bigger data plans through conversion rate optimization, drip and marketing automation campaigns, notifications, and other means. To increase attractiveness, they regularly offer large amounts of data at relatively low costs.

Regrettably, this incentivizes sloppy data practices and proliferates the myth that data is immaterial or otherwise inconsequential when compared to the benefits of our data-fueled future. Reality, however, tells another story.

For example, the data center industry—<a hreflang="en" href="https://www.precedenceresearch.com/data-center-market">currently valued at about $125.35 billion</a>—is <a hreflang="en" href="https://www.psmarketresearch.com/market-analysis/data-center-market">expected to grow 10%</a> year over year between now and 2030. Unfortunately, data centers drive a <a hreflang="en" href="https://computing.mit.edu/news/the-staggering-ecological-impacts-of-computation-and-the-cloud/">variety of ecological problems</a>, including noise and air pollution, e-waste, increased emissions and energy use, water use, and other impacts. The rapid <a hreflang="en" href="https://humanrights.berkeley.edu/projects/climate-impact-of-ai-data-centers/">rise of artificial intelligence</a> is especially problematic in this regard.

What's more, up to <a hreflang="en" href="https://www.greenergydatacenters.com/eng/blog/90-of-data-sits-unused-how-to-get-rid-and-avoid-digital-waste">90% of collected data goes unused</a> after about three months. Most of this data is never <a hreflang="en" href="https://www.mightybytes.com/blog/what-is-your-data-disposal-strategy/">properly disposed of</a>. Plus, poor data governance <a hreflang="en" href="https://atmos.earth/inside-the-fight-for-indigenous-data-sovereignty/">drives inequality</a>, privacy, and security risks as well.

With all of this in mind, it's easy to see why our collective thirst for low-cost, high-volume data solutions drives significant sustainability concerns. This is unfortunate considering that data and analytics literacy are also often strategic differentiators for many organizations.

To make more <a hreflang="en" href="https://www.mightybytes.com/blog/design-a-sustainable-data-strategy/">sustainable data practices</a> the norm among those who create and manage digital products and services, organizations should redefine their relationships with data. For marketers and product teams, this can be accomplished by improving data governance and more effectively managing content across the products and services they create, subscribe to, or otherwise maintain. The annual <a hreflang="en" href="https://cyberworldcleanupday.fr/welcome.html">Digital Cleanup Day</a> can be a good way to raise awareness on this topic.

### Data Governance and Sustainability

Data sustainability requires effective long-term governance strategies. Good <a hreflang="en" href="https://www.mightybytes.com/blog/sustainable-data-governance-for-marketers/">data governance</a> is key for long-term <a hreflang="en" href="https://www.mightybytes.com/blog/building-capacity-with-digital-governance/">digital governance</a> to work across an organization's teams and departments. In tandem with sustainability practices, these two disciplines can help organizations better manage web-based products and services over time while simultaneously improving how data is collected, managed, secured, and disposed of.

Specific tactics to improve data governance include:
1. Devise long-term organizational data and digital governance strategies that are grounded in sustainability principles and continuous improvement. Define and track clear KPIs to measure progress over time.
2. Train internal team members on data science to drive good governance. Appoint dedicated leaders to own digital and data governance within the organization.
3. Identify <a hreflang="en" href="https://www.mightybytes.com/blog/sustainable-marketing-stack/">strategic partners</a> in your <a hreflang="en" href="https://www.mightybytes.com/blog/how-to-improve-your-digital-supply-chain/">digital supply chain</a> that are aligned with the organization's sustainability goals.
4. Regularly audit data and digital products and services to reduce risk and waste.
5. Think twice before you collect information and, when you do, document how long this information should be kept.
6. Finally, align data governance efforts with the W3C Web Sustainability Guidelines (WSG) 1.0, particularly SC: 2.1, 2.25, 4.12, 5.6, 5.12, and 5.20.

### More Sustainable Content Management

Similarly, content marketing often drives data collection for many organizations. Web forms, landing pages, blog posts, video tutorials, social media posts, and other forms of content all play important roles in an organization's marketing, product management, content governance, and <a hreflang="en" href="https://www.mightybytes.com/blog/digital-sustainability/">digital sustainability</a> efforts.

This offers opportunities for teams to support more sustainable content management within their organizations. Examples include:

1. Align <a hreflang="en" href="https://www.mightybytes.com/blog/create-a-content-strategy/">content strategy</a> efforts with specific sustainability goals and your team's capacity.
2. Publish accessible content that uses <a hreflang="en" href="https://www.apa.org/about/apa/equity-diversity-inclusion/language-guidelines">inclusive language</a>, is easy for a fifth grader to understand, is as long as it needs to be, and is formatted to skim with short paragraphs, bulleted lists, clear headings, and so on.
3. Regularly conduct <a hreflang="en" href="https://www.mightybytes.com/blog/how-to-run-a-content-audit/">content audits</a> to ensure your content continues to provide value for stakeholders over time. Use this process to edit, delete, add, clarify, or otherwise revise content as needed.
4. Manage content assets with sustainability in mind: compress, tag, and reuse assets as needed. Use heavy media assets like audio, video, or animation only when necessary. Also, use a digital asset management or design system to keep source files and other assets organized.
5. Audit tools regularly to ensure your team has access to the features they need proportional to your resources. Train or upskill team members on new features or processes.
6. Finally, align content management efforts with the W3C Web Sustainability Guidelines (WSG) 1.0, particularly SC: 2.6, 2.8, 2.14, 2.15, 2.16, 2.21, 2.23, 2.25, 3.5, 5.3, 5.4, and 5.12.

## Popular frameworks, platforms, and CMSs

Online platforms and CMS tools significantly reduce the barriers for individuals and businesses to publish content or conduct commerce online. Additionally, development frameworks and site generators expedite project initiation for web developers, providing pre-set configurations and solutions that address common development issues. Performance is often a consideration in these tools, but for someone implementing a site, it is almost always cheaper to just get a bigger server.

With digital sustainability, scaling is what matters most. A byte here or there has an insignificant sustainability impact if it is just a single page. When that byte is loaded on over a million sites, with trillions of downloads a day, it has a much bigger impact.

The accompanying charts present the median page weight across the top five most popular eCommerce platforms, CMS tools, and site generator tools. These comparisons are to highlight the collective impact of the tools we use.

{{ figure_markup(
  image="median-kilobytes-by-cms.png",
  caption="Median kB by CMS",
  description="A bar chart showing that the median weight for Wordpress pages is 2,967 KB on desktop and 2,684 KB on mobile. For Wix it’s 3,161 KB on desktop and 2,471 KB on mobile. For Squarespace it’s 4,012 KB on desktop and 3,562 KB on mobile. For Joomla it’s 2,990 KB on desktop and 2,776 KB on mobile. For Drupal it’s 2,514 KB on desktop and 2,329 KB on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=1792712710&format=interactive",
  sheets_gid="790675238",
  sql_file=""
) }}

Notably, all report a median mobile page weight above the overall median of 2 MB. Comparing these values to their 2022 median size demonstrates that most websites built with each CMS are heavier than they were 2 years ago, which confirms a tendency that we noticed on global emissions for all pages. The more significant growth is for Squarespace websites on desktop and Drupal still seems to fare better than others (even if there is room for improvement).

Another point of interest across the segments is a noticeable difference in page size between desktop and mobile versions, which often stems from enhanced image optimization on mobile platforms. For instance, within the CMS segment, Wix and Squarespace display a substantial discrepancy in page size between desktop and mobile versions compared to other leading platforms.

As noted above, the model we use for calculating carbon emissions changed between 2022 and 2024. Based on SWD model V4, we recalculated emissions based on 2022 data for more relevant comparison with 2024 data. Here are both :

{{ figure_markup(
  image="median-emissions-by-cms-2024.png",
  caption="Median emissions by CMS - 2024",
  description="A bar chart showing that the median emissions for Wordpress pages is 0.42 grams of carbon on desktop and 0.38 on mobile. For Wix it’s 0.45 on desktop and 0.35 on mobile. For Squarespace it’s 0.57 on desktop and 0.5 on mobile. For Joomla it’s 0.42 on desktop and 0.39 on mobile. For Drupal it’s 0.36 on desktop and 0.33 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=654101809&format=interactive",
  sheets_gid="790675238",
  sql_file=""
) }}

For comparison reasons, here are the emissions data from 2022, calculated with the SWD V4 model :

{{ figure_markup(
  image="median-emissions-by-cms-2022.png",
  caption="Median emissions by CMS - 2022",
  description="A bar chart showing that the median emissions for Wordpress pages is 0.37 grams of carbon on desktop and 0.34 on mobile. For Joomla it’s 0.38 on desktop and 0.35 on mobile. For Wix it’s 0.44 on desktop and 0.31 on mobile. For Drupal it’s 0.33 on desktop and 0.30 on mobile. For Squarespace it’s 0.48 on desktop and 0.5 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=1732727443&format=interactive",
  sheets_gid="1972006215",
  sql_file=""
) }}

The 2024 scan included around 5 million instances of WordPress, 500,000 instances of Wix, 250,000 instances of Squarespace, 250,000 instances of Joomla, and 200,000 instances of Drupal. That's over 6 million unique instances of these five CMS. So, even just generating this report does have a measurable climate impact.

The average of the median emissions in the chart above is about 0.3 grams of carbon. To run these queries on seven million URLs would produce about 2125 kg of CO2. That's just from sampling the top five CMS. We know that this is just a small sampling of the CO2 produced through the use of these websites.

{{ figure_markup(
  image="median-kilobytes-by-cms-and-resource-type.png",
  caption="Median kB by CMS and resource type",
  description="A bar chart showing the median Kilobytes of different content types on desktop by CMS. For WordPress, HTML content has a median of 42 KB, JavaScript has 572 KB, CSS is 122 KB, images have a median of 1,358 KB and fonts 191 Kb. For Wix, HTML has 147 KB, JavaScript 1,526 KB, CSS 16 KB, images 466 KB and fonts 170 KB. For Squarespace, HTML has 28 KB, JavaScript 1,321 KB, CSS 133 KB, images 1,689 KB and fonts 184 KB out of total page weight. For Joomla, HTML has 21 KB, JavaScript 431 KB, CSS 92 KB, images 1,711 KB and fonts 123 KB. For Drupal, HTML has 22 KB, JavaScript 497 KB, CSS around 73 KB, images 1,225 KB and fonts 126 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=1162097291&format=interactive",
  sheets_gid="790675238",
  sql_file=""
) }}

Note : in diagrams displaying resource types, we only take into account HTML+Javascript+CSS+Images+Fonts, omitting other requests such as video, audio and some "unidentified" 3rd-party services.

Of the five CMS, it is good to see that image sizes went down across the board. Squarespace is still the biggest with an average of 1.3 Mb of images on mobile devices. It is unfortunate to see JavaScript generally increase. Wix now has the largest JavaScript footprint in 2024 at 1.3 Mb. With most of the CMS, HTML is the smallest resource type. The charts above show that Wix seems to implement significantly more aggressive image optimizations on their platform.

{{ figure_markup(
  image="median-emissions-by-cms-and-resource-type.png",
  caption="Median emissions by CMS and resource type",
  description="A bar chart showing the median emissions of different content types on desktop by CMS. For WordPress, HTML content has a median of 0.01 grams of carbon, JavaScript has 0.08, CSS is 0.02, images have a median of 0.19 and fonts 0.03. For Wix, HTML has 0.02, JavaScript 0.22, CSS 0, images 0.07 and fonts 0.02. For Squarespace, HTML has 0, JavaScript 0.19, CSS 0.02, images 0.24 KB and fonts 0.03 out of total page emissions. For Joomla, HTML has 0, JavaScript 0.06, CSS 0.01, images 0.24 and fonts 0.02. For Drupal, HTML has 0, JavaScript 0.07, CSS around 0.01, images 0.17 and fonts 0.02.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=1895711546&format=interactive",
  sheets_gid="790675238",
  sql_file=""
) }}

It is useful to break down this information between resource types because it also indicates where there is waste. From a CO2 perspective, it is hard to beat a simple and static HTML/CSS website. We are expecting richer, more interactive, and visual content on the web, but it wasn't always this way.  <a hreflang="en" href="https://thehistoryoftheweb.com/web-fonts/">Web fonts</a> became a part of the web only in 2009. In 2024 they are pretty much expected, seeing just how much custom fonts have become part of CMS implementations. The sites may look a bit more unique, but it comes at the cost of web performance and of course sustainability.

CMS also has a strong role to play in shifting the definition of quality work. <a hreflang="en" href="https://wagtail.org/blog/wagtail-greener-and-leaner/">Wagtail CMS is a leader</a> in this as they have provided a release that focuses on reducing their carbon footprint. <a hreflang="en" href="https://make.wordpress.org/sustainability/">WordPress</a>, <a hreflang="en" href="https://www.drupal.org/about/sustainability">Drupal</a>, and <a hreflang="en" href="https://magazine.joomla.org/all-issues/april-2024/green-websites-help-to-keep-your-feet-dry">Joomla</a> have all made some sustainability initiatives. These communities can have a large impact on what is considered a good product. Through organizations like the <a hreflang="en" href="https://www.drupal.org/association/blog/drupal-association-co-founds-the-open-website-alliance">Open Web Alliance</a>, there may be even greater collaboration to help implement best practices.

{{ figure_markup(
  image="median-kilobytes-by-ecommerce.png",
  caption="Median kB by ecommerce",
  description="A bar chart showing that the median weight for WooCommerce pages is 3,275 KB on desktop and 3,036 KB on mobile. For Shopify it’s 2,876 KB on desktop and 2,657 KB on mobile. For Squerspace Commerce it’s 4,012 KB on desktop and 2,756 KB on mobile. For Wix eCommerce it is 3,530 KB on desktop and 3,562 KB on mobile. For PrestaShop it’s 3,078 KB on desktop and 2,730 KB on mobile. For 1C-Bitrix it is 3,305 KB on desktop and 3,788 KB on mobile. For Magento it’s 3,505 KB on desktop and 4,209 KB on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=510790990&format=interactive",
  sheets_gid="2021180834",
  sql_file=""
) }}

{{ figure_markup(
  image="median-emissions-by-ecommerce-2024.png",
  caption="Median emissions by ecommerce - 2024",
  description="A bar chart showing that the median emission for WooCommerce pages is 0.46 grams of carbon on desktop and 0.43 on mobile. For Shopify it’s 0.41 on desktop and 0.38 on mobile. For Squerspace Commerce it’s 0.57 on desktop and 0.39 on mobile. For Wix eCommerce it is 0.5 on both desktop and mobile. For PrestaShop it’s 0.44 on desktop and 0.39 KB on mobile. For 1C-Bitrix it is 0.47 on desktop and 0.54 on mobile. For Magento it’s 0.5 on desktop and 0.59 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=1542686246&format=interactive",
  sheets_gid="2021180834",
  sql_file=""
) }}

For comparison reasons, here are the emissions data from 2022, calculated with the SWD V4 model :

{{ figure_markup(
  image="median-emissions-by-ecommerce-2022.png",
  caption="Median emissions by ecommerce - 2022",
  description="A bar chart showing that the median emission for WooCommerce pages in 2022 was 0.28 grams of carbon on desktop and 0.26 on mobile. For Shopify it’s 0.20 on desktop and 0.18 on mobile. For Squerspace Commerce it’s 0.31 on desktop and 0.32 on mobile. For PrestaShop it’s 0.26 on desktop and 0.23 KB on mobile. For Wix eCommerce it is 0.32 on desktop and 0.22 on mobile. For Magento it’s 0.3 on desktop and 0.28 on mobile. For 1C-Bitrix it is 0.34 on desktop and 0.3 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=1732727443&format=interactive",
  sheets_gid="1972006215",
  sql_file=""
) }}

It is clear comparing the ecommerce platforms with other CMS platforms, that they are substantially heavier in their page-load size and their environmental impact. Since these figures mostly relate to homepages, we can only guess that this could be due to more products or less optimized content. However, this shows that there is still room for improvement.

<a hreflang="en" href="https://theecommmanager.com/sustainable-ecommerce-handbook/">The Sustainable eCommerce Handbook</a> could be a great starting point. In any case, you should keep in mind that most of the environmental impacts for eCommerce occur outside of websites (manufacturing, shipping, usage, and end-of-life of sold products, for instance).

{{ figure_markup(
  image="median-kilobytes-by-ssg.png",
  caption="Median kB by static site generator",
  description="A bar chart showing that the median weight for Next.js pages is 2,396 KB on desktop and 2,214 KB on mobile. For Nuxt.js it’s 3,107 KB on desktop and 2,677 KB on mobile. For Gatsby it’s 2,229 KB on desktop and 1,833 KB on mobile. For Hugo it’s 1,112 KB on desktop and 1,216 KB on mobile. For Astro it’s 1,125 KB on desktop and 1,149 KB on mobile. For Jekyll it’s 792 KB on desktop and 854 KB on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=2054864060&format=interactive",
  sheets_gid="1941515647",
  sql_file=""
) }}

{{ figure_markup(
  image="median-emissions-by-ssg-2024.png",
  caption="Median emissions by static site generator - 2024",
  description="A bar chart showing that the median emission for Next.js pages is 0.34 grams of carbon on desktop and 0.31 on mobile. For Nuxt.js it’s 0.44 on desktop and 0.38 on mobile. For Gatsby it’s 0.32 on desktop and 0.26 on mobile. For Hugo it’s 0.16 on desktop and 0.17 on mobile. For Astro it’s 0.16 on both desktop and mobile. For Jekyll it’s 0.11 on desktop and 0.12 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=437135521&format=interactive",
  sheets_gid="1941515647",
  sql_file=""
) }}

For comparison reasons, here are the emissions data from 2022, calculated with the SWD V4 model :

{{ figure_markup(
  image="median-emissions-by-ssg-2022.png",
  caption="Median emissions by static site generator - 2022",
  description="A bar chart showing that the median emission for Next.js pages is 0.22 grams of carbon on desktop and 0.20 on mobile. For Nuxt.js it’s 0.26 on desktop and 0.21 on mobile. For Gatsby it’s 0.19 on desktop and 0.16 on mobile. For Hugo it’s 0.09 on desktop and 0.1 on mobile. For Jekyll it’s 0.06 on both desktop and mobile. For Docusaurus it’s 0.07 on desktop and 0.08 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRQLDsXdZj62xe68w716gen0rQvuuGhXPAOSwdWwYjSBZf9BgJgEb-dp1Z_jB_Lp5YMsfH0FiNKwzDb/pubchart?oid=1021559874&format=interactive",
  sheets_gid="1333464158",
  sql_file=""
) }}

It appears evident that site generators have prioritized optimization as part of their builds. Astro, Hugo, and Jekyll all have emissions substantially lower than all the CMS that have been categorized.

These insights underscore the significant role that platforms and frameworks play in promoting sustainable web development. By setting effective defaults, platform creators and framework developers enable the construction of environmentally friendly websites right from the start.​

These exceptions belong to the static site generator category, particularly Hugo and Jekyll, which typically support sites focused on blogs and text-heavy content with minimal JavaScript usage. Static site generators are also often chosen for their performance benefits, suggesting a greater likelihood of optimization beyond the norms of standard CMS-driven sites.

For further information, refer to:
- The WSGs 1.0 - SC 3.7, 3.21, and 5.28.

## Conclusion

Sustainability is a rapidly evolving and firmly established field that will increasingly have a seat at the table for those creating products and services for the Web. As with accessibility, legislation is helping to drive the need for conformance and the benefits it can bring to both people and the planet. By considering how you create websites and applications, the ethical decisions behind design and development, taking into account industry best practices, and tackling the digital variables that can have real-world impacts, each one of us can become sustainability advocates.

Starting from the 2022 chapter, we realized that things are moving really fast for web sustainability and we are faced with many challenges:
- There is more and more information out there and it might get difficult to follow: new resources and tools, existing stuff being updated, etc.
- It appears essential to keep an eye on emerging technologies (metaverse faded away as fast as it appeared, AI is everywhere), since all of them have environmental impacts (and possibly benefits too). Solutionism is a growing risk:
  - Offering digital solutions to fight climate change without considering their own impacts.
  - Silver bullet offerings to reduce the environmental impacts of digital.
- Greenwashing is everywhere, even with the best intention in mind.

In the end, we see a generally wider adoption of technical best practices but still an increase of emissions. Efficiency is mandatory but sobriety and frugality are the way to go.

### Actions you can take

{# TODO - add intro paragraph #}

#### Quick Checks

One of the simplest steps you can take in rapidly evaluating your sustainability situation is using an automated measurement tool. As with accessibility tooling, these only tell part of the story and cannot account for aspects that can only be human-tested (rather than automated), and there are still many issues we do not have accurate data to measure against; but it's still a good place to dip your toes in the water.

For further information, refer to:
- <a hreflang="en" href="https://github.com/Munter/subfont">Ecograder</a>
- <a hreflang="en" href="https://github.com/Munter/subfont">Website Carbon</a>
- <a hreflang="en" href="https://github.com/Munter/subfont">Are My Third Parties Green?</a>

#### Planning / Reporting

Another step forward you can take beyond a rapid evaluation is to put forward some concrete plans or even better, start reporting on your sustainability journey. Measure what you can, document your efforts, and be as open with your findings and progress as you can be. Sustainability is a journey and progress is always beneficial over perfection. Having a sustainability statement will be a great place to provide such plans and successes you have achieved.

For further information, refer to:
- <a hreflang="en" href="https://ecograder.com/">Best Sustainability Statements</a>
- <a hreflang="en" href="https://www.websitecarbon.com/">Co2.js</a>
- <a hreflang="en" href="https://aremythirdpartiesgreen.com/">How to Write An Effective Sustainability Statement</a>

#### WSGs

The W3C Sustainable Web community group's Web Sustainability Guidelines are a hugely beneficial resource for anyone seeking to implement sustainability in their website or application. The specification they have produced is broken down into sections based on expertise (UX, Web Development, DevOps, and Business) and additional resources are available (linked to at the top of the specification) which can assist in your understanding of and implementation of sustainability within your product or service.

For further information, refer to:
- <a hreflang="en" href="https://w3c.github.io/sustyweb/">Web Sustainability Guidelines</a>
- <a hreflang="en" href="https://w3c.github.io/sustyweb/star.html">Sustainable Tooling And Reporting (STAR)</a>
- <a hreflang="en" href="https://w3c.github.io/sustyweb/glance.html">At-A-Glance Overview</a>
- <a hreflang="en" href="https://w3c.github.io/sustyweb/intro.html">Introduction to Web Sustainability</a>
- <a hreflang="en" href="https://w3c.github.io/sustyweb/policies.html">Web Sustainability Laws & Policies</a>
- <a hreflang="en" href="https://w3c.github.io/sustyweb/quickref.html">WSGs Quick Reference (Includes PDF)</a>

#### Up-To-Date (Knowledge)

As creators, keeping our knowledge current in an overwhelming industry is a challenge, and in sustainability which is a rapidly evolving field, this is no exception. Reading books, watching relevant videos, taking courses, looking at studies or papers, and keeping up-to-date with the latest standards and best practices are essential. You have taken the first step with this chapter of the Almanac, if you enjoyed it, see what else interests you to expand your experience further.

