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
#alextait1_bio: TODO
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


##Introduction

In 2020, more than ever before, it’s become increasingly urgent for digital spaces to be inclusive and accessible to all. With the ongoing pandemic making it even more difficult for folks to access services in-person and entire industries moving online, disabled people are disproportionately impacted. Additionally, the number of disabled people is rising due to the effects of the pandemic.

Web accessibility is about achieving feature and information parity and giving complete access to all aspects of an interface to disabled people. A digital product or website is simply not complete if it is not usable by everyone. If it excludes certain disabled populations, this is discrimination and potentially grounds for fines and/or lawsuits.

The Web Content Accessibility Guidelines, or WCAG, is an internationally recognized set of standards that needs to be met in all websites and applications that utilize the Internet. They are not laws, but many laws point to WCAG as their basis. 

These guidelines have had multiple releases over the years and the current standard is WCAG 2.1, with WCAG 2.2 currently being vetted as a working draft. Some regional laws point to WCAG 2.0 as the requirement, but as Adrian Roselli covers in his article WCAG 2.1 is the Current Standard, Not WCAG 2.0 - and WCAG 2.2 is Coming we need to be meeting WCAG 2.1 standards and considering the new criteria coming in WCAG 2.2 as well.
A dangerous trend that has seen more exposure than ever in 2020 is the use of “accessibility overlays”. These widgets promise one step accessibility compliance and more often than not introduce new barriers and make the experience for a disabled user quite challenging. It is important that digital practitioners take ownership over designing and implementing usable interfaces and not try to subvert this process with a quick fix. For more information see Lainey Feingold’s article, Honor the ADA: Avoid Web Accessibility Quick Fix Overlays.
Sadly, year over year, we and other teams conducting analysis such as the WebAIM Million are finding little and in some cases no  improvement in these metrics. The median overall site score for all lighthouse audit data rose from 73% in 2019 to 80% in 2020. We hope that this 7% increase represents a shift in the right direction. However, these are automated checks and could mean that developers are doing a better job of subverting the rule engine, so we are cautiously optimistic.
Our analysis is based on automated metrics only. It is important to remember that automated testing captures only a fraction of the accessibility barriers that can be present in an interface. Qualitative analysis, including manual testing and usability testing with disabled people are needed in order to achieve an accessible site or application. 
We've split up our most interesting insights into five categories: 
1. Ease of reading, 
2. Media on the web, 
3. Ease of page navigation, 
4. Assistive technologies on the web, 
5. Accessibility of form controls.
