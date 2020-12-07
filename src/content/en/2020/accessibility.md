---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: II
chapter_number: 8
title: Accessibility
description: Accessibility chapter of the 2020 Web Almanac covering ease of reading, media, ease of navigation, and compatibility with assistive technologies.
authors: [oluoluoxenfree, alextait1]
reviewers: [aardrian, ericwbailey, obto]
analysts: [obto]
translators: []
oluoluoxenfree_bio: Olu Niyi-Awosusi is a software engineer at the FT who loves lists, learning new things, Bee and Puppycat, <a href="https://alistapart.com/article/building-the-woke-web/" target="_blank">social justice, accessibility</a> and trying harder every day.
alextait1_bio: Alex Tait is a developer, consultant and educator whose passion lies in the intersection of accessibility and modern JavaScript within interface architecture and design systems. As a developer, she believes that inclusion driven development practices with accessibility at the forefront lead to better products for everyone. As a consultant and strategist, she believes that less is more and that new feature scope creep cannot be prioritized over core feature parity for disabled users. As an educator, she believes in removing barriers to information so that tech can become a more diverse, equitable and inclusive industry.
discuss: 2044
results: https://docs.google.com/spreadsheets/d/1UjEBhq0TfYxUpdpq5IuxjeHB4yqhJq4NOKEd6Dwwrdk/
queries: 08_Accessibility
#featured_quote: TODO
#featured_stat_1: TODO
#featured_stat_label_1: TODO
#featured_stat_2: TODO
#featured_stat_label_2: TODO
#featured_stat_3: TODO
#featured_stat_label_3: TODO
---


## Introduction

In 2020, more than ever before, it’s become increasingly urgent for digital spaces to be inclusive and accessible to all. With the ongoing pandemic making it even more difficult for folks to access services in-person and entire industries moving online, disabled people are disproportionately impacted. Additionally, the number of disabled people is rising due to the effects of the pandemic.

Web accessibility is about achieving feature and information parity and giving complete access to all aspects of an interface to disabled people. A digital product or website is simply not complete if it is not usable by everyone. If it excludes certain disabled populations, this is discrimination and potentially grounds for fines and/or lawsuits.

The [Web Content Accessibility Guidelines](https://www.w3.org/WAI/standards-guidelines/wcag/), or WCAG, is an internationally recognized set of standards that needs to be met in all websites and applications that utilize the Internet. They are not laws, but [many laws point to WCAG as their basis](https://www.w3.org/WAI/policies/). 

These guidelines have had multiple releases over the years and the current standard is WCAG 2.1, with WCAG 2.2 currently being vetted as a [working draft](https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/). Some regional laws point to WCAG 2.0 as the requirement, but as Adrian Roselli covers in his article [WCAG 2.1 is the Current Standard, Not WCAG 2.0 - and WCAG 2.2 is Coming](https://adrianroselli.com/2020/09/wcag-2-1-is-the-current-standard-not-wcag-2-0-and-wcag-2-2-is-coming.html) we need to be meeting WCAG 2.1 standards and considering the new criteria coming in WCAG 2.2 as well.

A dangerous trend that has seen more exposure than ever in 2020 is the use of “accessibility overlays”. These widgets promise one step accessibility compliance and more often than not introduce new barriers and make the experience for a disabled user quite challenging. It is important that digital practitioners take ownership over designing and implementing usable interfaces and not try to subvert this process with a quick fix. For more information see Lainey Feingold’s article, [Honor the ADA: Avoid Web Accessibility Quick Fix Overlays](https://www.lflegal.com/2020/08/quick-fix/).

Sadly, year over year, we and other teams conducting analysis such as the [WebAIM Million](https://webaim.org/projects/million/https://webaim.org/projects/million/) are finding little and in some cases no  improvement in these metrics. The median overall site score for all lighthouse audit data rose from 73% in 2019 to 80% in 2020. We hope that this 7% increase represents a shift in the right direction. However, these are automated checks and could mean that developers are doing a better job of subverting the rule engine, so we are cautiously optimistic.

Our analysis is based on automated metrics only. It is important to remember that automated testing captures only a fraction of the accessibility barriers that can be present in an interface. Qualitative analysis, including manual testing and usability testing with disabled people are needed in order to achieve an accessible site or application. 

We've split up our most interesting insights into five categories: 

1. Ease of reading, 
2. Media on the web, 
3. Ease of page navigation, 
4. Assistive technologies on the web, 
5. Accessibility of form controls.

## Ease of reading

Making content as simple and clear to read as possible is an important aspect of web accessibility. Being unable to read the content of a page prevents a user from being able to complete tasks on websites. There are many aspects of a web page that make it easier or harder to read, including:

### Color Contrast

The higher the page contrast, the easier it is for people to view text-based content. People who may have difficulties viewing low context content include those with color vision deficiency, people with mild to moderate vision loss, and those with contextual difficulties viewing the content, such as glare on screens in bright light. Unfortunately, only 21.06% of sites were found to have sufficient color contrast. Which is a decrease from last year's already abysmal 22%.

### Zooming and Scaling of Pages 

The ability to set scale and zoom of desktop pages helps those with vision loss to more easily navigate sites, as well as allowing users of less precise navigation tools easier control of sites. 

These were disabled on 24.39% of desktop sites checked, and 30.66% of mobile sites. Some operating systems no longer comply with disabled zoom and scale set in HTML, though for systems that do respect it, this can render the page effectively unusable for some. For more information about why to avoid disabling browser zoom see Adrian Roselli’s article, [Don’t Disable Zoom](https://adrianroselli.com/2015/10/dont-disable-zoom.html).

### Language Identification

Setting an HTML `lang` attribute allows easy translation of a page and better screen reader support. The percentage of sites with a valid HTML lang attribute on desktop this year was 77.67%, with only 77.7% having a `lang` attribute at all. 

## Media on the web 

### Images and their text alternatives 

Images are an essential part of the web experience. They can add an enriched context to the surrounding textual information, and not just for sighted users. In 1995, [HTML 2.0](https://www.w3.org/MarkUp/html-spec/html-spec_5.html#SEC5.10) introduced the alt attribute, enabling web authors to provide a text alternative for the visual information communicated in an image. A screen reader can convey its visual meaning aurally by announcing the image’s alternative text. Additionally if images are unable to load, the alternative text for a description will be displayed.  

The 2020 Lighthouse audit data shows that only 54% of sites pass the [test for images with alt text](https://dequeuniversity.com/rules/axe/3.5/image-alt). This test looks for the presence of at least one of the alt, aria-label and aria-labelledby attributes on img elements. In most cases using the alt attribute is the best choice. Even though alt attributes have been around for 25 years, we also found that 21.24% of desktop images and 21.38% of mobile images are lacking alternative text.  This is one of the easiest automated checks to test for using your accessibility tool of choice, and should be low hanging fruit and a relatively straightforward problem to solve.

Screen reader users listen to the [“aural UI” as described by Steve Faulker](https://developer.paciellogroup.com/blog/2015/10/thus-spoke-html/), an aural or sonic experience of the interface wherein the  structure, semantics and relationships of the content are announced. This means that screen reader users consume a lot of textual information. For this reason it is important to assess whether or not an image might not need to be described. This is a helpful [decision tree from the W3C](https://www.w3.org/WAI/tutorials/images/decision-tree/) for deciding how and whether to describe an image. If an image is truly decorative and adds nothing meaningful to the surrounding context, you can assign the alt attribute a null value, alt="". It is important to do this explicitly rather than omitting the alt attribute altogether, as omitting it could lead to assistive technology announcing the image path, which is a very confusing user experience. We found that 26.20% of desktop pages and 26.23% of mobile pages contain alt attributes with a null/empty value. We hope this indicates that over a quarter of websites are being developed with consideration for which images are truly meaningful and not as a means of side stepping automated checks.

When describing an image it is imperative to consider what information the user needs, and omit additional information to reduce verbosity. For example, a red arrow icon button that has the action of moving to a new step in the interface could be described as “continue to step 3 of 5” rather than “red arrow png”. The first description tells the user what to expect if they activate the control, whereas the second just describes its appearance and has an unnecessary file extension, both of which are irrelevant to the meaning of the image. 
Automated checks for the presence of alternative text do not assess the quality of this text. As described in the previous section, the meaning of an image needs to be considered when writing this text. One common unhelpful pattern is describing the image with the file extension name. For the previous “red arrow png” example, a screen reader user likely does not get helpful information from the image format. We found that 6.8% of desktop sites (with at least one instance of the alt attribute) had a file extension in it’s value. The top 5 file extensions explicitly included in the alt text value (for sites with images that have non-empty alt values) are jpg, png, ico, gif and jpeg. This likely comes from a CMS or another auto-generated alternative text mechanism. It is imperative that these alt attribute values be meaningful, regardless of how they are implemented.


| File extension type | Desktop (sites with non-empty alt) | Mobile (sites with non-empty alt) |
|---------------------|------------------------------------|-----------------------------------|
| jpg | 3.73% | 3.50% |
| png | 2.98% | 2.81% |
| ico | 1.34% | 1.6% |
| gif | 0.034% | 0.030% |
| jpeg | 0.034% | 0.032% |

#### Images with title attributes

The title attribute which generates a tooltip that displays text is often mistaken as another reliable way to describe images to assistive technology. However according the HTML Standard, 

> “Relying on the `title` attribute is currently discouraged as many user agents do not expose the attribute in an accessible manner as required by this specification”

Tooltips also introduce a host of other accessibility barriers such as information only being revealed on hover/mouseover, information not being properly communicated to assistive technology, lack of keyboard support, and general poor usability.  The history of tooltips and their barriers  are well described by Sarah Higley in her blog post, “[Tooltips in the time of WCAG 2.1](https://sarahmhigley.com/writing/tooltips-in-wcag-21/)”. We found that 16.95% of all alt attributes also contain a title attribute and of these instances 73.56% of the titles are the exact same as the alt attribute. Of these instances 73.56% of desktop sites and 72.80% of mobile sites had matching values for both the alt and title attributes.

#### Other facts about alt text

- The median length for both desktop and mobile alt text is 18 characters. With the average English word length being 4.7 characters, this means the median alt attribute value is 3-4 words long. Depending on the image, being terse can be beneficial. However it is hard to imagine 4 words being sufficient for an accurate description of an image with any complexity.
- The longest alt text length found for desktop sites was 15357625 characters. That’s enough to fill 5 and a half "War and Peace" sized books (assuming war and peace has an average word length of 4.7 characters).

### Video on the Web

Video and other multi-media content can enrich a Web experience, but often is not robustly supported for all users and can pose major accessibility barriers if it is not implemented with support. For more information see the [W3C’s Making Audio and Video Accessible](https://www.w3.org/WAI/media/av/).
