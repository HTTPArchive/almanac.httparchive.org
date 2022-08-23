---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Accessibility
#TODO - Review and update chapter description
description: Accessibility chapter of the 2022 Web Almanac covering ease of reading, media, ease of navigation, and compatibility with assistive technologies.
authors: [scottdavis99, SaptakS]
reviewers: [shantsis, alextait1, ericwbailey]
analysts: [scottdavis99, thibaudcolas]
editors: [dereknahman]
translators: []
results: https://docs.google.com/spreadsheets/d/1ladaKh6RbtMKQwkccwxDJGQf85KyhfLrtlM_9e9sLH8/
featured_quote: TODO
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
unedited: true
---

## Introduction

Half of all web searches are performed by voice. 85% of Facebook videos are watched with closed captions on and sound off. When you ask voice assistants like Siri, Alexa, and Cortana a question, they typically read their answer from a webpage using Screen Reader technology that has been around for as long as personal computers have existed.

When does a software feature cease being an “accessibility feature” and simply become a “feature” that we all use? Ask yourself that the next time you put your smartphone in silent/vibrate mode – especially if you’re not a member of the Deaf/Hard of Hearing community.

Good accessibility benefits everyone, not just those with disabilities. This is one of the core principles of Universal Design. Tim Berners-Lee said, “The power of the Web is in its universality. Access by everyone regardless of disability is an essential aspect.” After the COVID-19 pandemic started, more and more people have been reliant on the internet and accessibility needs to improve with this as well, else we risk alienating a lot of people.

The median overall site score for all Lighthouse Accessibility audit data rose from 80% in 2020 to 82% in 2021, then 83% in 2022. We hope that this increase represents a shift in the right direction.

In the hope of improvement towards accessibility in the web, we have tried to write the chapter with some actionable links and solutions that people can follow. Also, we chose to use the person-first term “people with disabilities” throughout this chapter. We acknowledge that the identity-first term “disabled people” is preferred for many. Our choice in terminology is in no way prescriptive of which term is appropriate.

## Ease of reading

Readability of information and content on the web is super important. There are certain aspects of web accessibility that ensure that everyone, including people with disabilities can consume the content in a website. These aspects ensure that everyone on the internet can not only consume content, but also are not harmed by any aspect of the content.

### Color contrast

Color contrast refers to the contrast between the color of the foreground (which can include text, diagrams, logo or other pieces of information) and the background that helps people with low vision impairment or color deficiencies to be able to read the information.

The minimum contrast requirement by WCAG for normal sized text in AA conformance is 4.5:1 and for AAA conformance is 7:1. However, if you are using a larger font size, then the contrast requirement is lower because larger text have more legibility even with lower contrast.

{{ figure_markup(
  image="color-contrast-2019-2020-2021-2022.png",
  caption="Mobile sites with sufficient color contrast.",
  description="A bar chart showing 22.0% of sites had sufficient color contrast in 2019, dipping slightly to 21.1% in 2020 and increasing slightly to 22.2% for 2020, increasing more to 22.9% in 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?format=interactive&oid=2111814473",
  sheets_gid="1468870242",
  sql_file="color_contrast.sql",
) }}

We found that 22.9% mobile sites have sufficient text color contrast. Also, the increase from last year is less than 1% which is not substantial. The color contrast issue (at least for the text based color contrasts that we tested) is pretty straightforward to validate even before you start making the website. There are multiple tools that can help developers and designers to check color contrast of foreground against the background color like:

- Tanaguru Contrast Finder
- Contrast Ratio by Lea Verou
- Colour Contrast Analyzer by TPGi
- Color Contrast Checker by WebAIM
- Figma tool

It's often a good idea to decide a color scheme that passes color contrast at beginning of a project. In case you already have a project failing the test, all you need to do is get a better contrasting color and then apply that. You can also provide other color modes such as dark mode, light mode, high contrast modes to let the user chose.

### Zooming and scaling

Zooming is another feature that users with low vision often use to view the text in a website better. There are system settings in browser and also some magnifying tools that allow a user to zoom and scale a website. Adrian Roselli talks in detail about the [different reasons you should not disable zoom](https://adrianroselli.com/2015/10/dont-disable-zoom.html).

{{ figure_markup(
  image="pages-zooming-scaling-disabled.png",
  caption="Pages with zooming and scaling disabled.",
  description="A bar chart showing that 15.7% of desktop sites and 18.3% of mobile sites disable scaling, 20.2% and 24.4% respectively set a max scale of 1 and 23.4% and 27.8% use either.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?format=interactive&oid=550476172",
  sheets_gid="602773443",
  sql_file="viewport_zoom_scale.sql",
) }}

WCAG requires the text in a website to be allowed to be resize up to at least 200%. We see 23.4% of homepages in desktop and 27.8% of homepages in mobile try to disable zoom.

The method by which a developer disabled zoom is by adding a `<meta name="viewport" >` tag with value like `maximum-scale, minimum-scale, user-scalable=no, or user-scalable=0` in the `content` attribute. So if you have a website that has one of these values, please delete those particular values from the `content` attribute to enable zoom.

{{ figure_markup(
  image="pages-zooming-scaling-disabled-by-rank.png",
  caption="Pages with zooming and scaling disabled by rank.",
  description="A bar chart showing that for the top 1,000 sites zooming and scaling is disabled by 21.0% of desktop sites and 40.2% of mobile sites, for the top 10,000 it's 25.2% and 36.0% respectively, for the top 100,000 it's 25.0% and 31.9%, for the top million it's 24.4% and 28.9% and finally for all sites it's 23.4% and 27.8%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?format=interactive&oid=1987306037",
  sheets_gid="1896788548",
  sql_file="viewport_zoom_scale_by_domain_rank.sql",
) }}

Of the top 1,000 most trafficked sites, 21.0% of desktop sites and 40.2% of mobile sites have code that attempts to disable users from zooming or scaling. We also see that in top 1,000 trafficked sites, the percentage of sites with zooming disabled is almost double in mobile compared to that in desktop. It's really important to not disable zooming in either of the devices. Browsers have started putting settings to override the disabling of zooming ability. Manuel Matuzovic wrote an [article](https://www.matuzo.at/blog/2022/please-stop-disabling-zoom/) talking about the concerns with disabling zoom and user settings in browsers to override this.

{{ figure_markup(
  image="font-unit-usage.png",
  caption="Font unit usage.",
  description="A bar chart showing `px` is used for font sizes on 70.5% of desktop and mobiles pages, `em` on 14.9% and 15.2% respectively, `rem` on 5.7% and 5.6%, `%` on 4.5% and 4.8%, `<number>` on 2.1% and 1.9%, and finally `pt` on 1.7% and 1.5%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?format=interactive&oid=850268795",
  sheets_gid="955782036",
  sql_file="units_properties.sql",
) }}

Another thing to keep in mind often is the unit you chose for font-size. As we see about 70.5% of pages in desktop use px, and only 14.9% and 5.7% use em and rem respectively. So the percentage of px usage has increased compared to last year, while em and rem usage has decreased. It's mostly considered wise to use relative units such as `em` or `rem` when it comes to `font-size`. This is because if you use `px` for your font size, then [it will not scale](https://adrianroselli.com/2019/12/responsive-type-and-zoom.html#Update02) if the user explicitly choses a bigger or smaller default font size in the browser settings.

### Language identification

Language identification using the `lang` attribute is important for various different reasons. Language identification is a good example of a feature that helps everyone, including people with disabilities. It helps in better screen reader support, but also helps in proper browser translation. Without the `lang` attribute, the automatic browser translation in chrome can often translate the text to completely wrong meanings. Manuel Matuzovic gives one such [example of auto-translate mishap](https://www.matuzo.at/blog/lang-attribute/) due to lack of `lang` attribute.

82.7%

{{ figure_markup(
  content="82.7%",
  caption="Mobile sites have a valid `lang` attribute.",
  classes="big-number",
  sheets_gid="420415839",
  sql_file="valid_html_lang.sql",
) }}

It's good to see that 82.6% of websites in mobile do have a lang attribute, and of them 82.7% have a valid value. There's still room for improvement given this is a Level A conformance issue under WCAG 2.1. To meet this success criteria, one can put the `lang` attribute in the `<html>` tag with a [known primary language tag](https://www.w3.org/WAI/standards-guidelines/act/rules/bf051a/#known-primary-language-tag). The [`lang` attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/lang) is a global attribute and can be set on other tags as well in case the webpage has content in more than one language. Also, it’s important to put the correct language, since often copying a template for a website will have `lang=”en”` which might not match the content language of the website.

### User preference

There are certain User Preference Media Queries from the [CSS Media Queries Level 5 specification](https://www.w3.org/TR/mediaqueries-5) that can be used for various accessibility features ranging from choosing a color scheme that works better for the user to reducing animations in the page that helps people with vestibular disorders.

{{ figure_markup(
  image="userpreference-media-queries.png",
  caption="User preference media queries.",
  description="A bar chart showing that 33.6% of desktop sites and 34.2% of mobile sites use the `prefers-reduced-motion` media query, 8.2% of desktop sites and 7.7% of mobile sites use `prefers-color-scheme`, and `prefers-contrast` is used by 1.1% of desktop sites and 1.2% of mobile sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?format=interactive&oid=727284960",
  sheets_gid="48059230",
  sql_file="media_query_features.sql",
) }}

We found that 34.2% of websites in mobile use prefers-reduced-motion. If the website uses complicated animations that can cause issues for people with vestibular disorder, it is important to put those animations under `prefers-reduced-motion` media query. There are really great resources related to designing accessible animation.

7.7% of websites in mobile used `prefers-color-scheme` media query, and 1.2% used `prefers-contrast`. Both of these media queries are really helpful in improving readability of content by adjusting the display mode based on user preference. `prefers-color-scheme` allows the browser to detect the user's system color mode of the user, and based on that the web developer can provide a light and dark mode. `prefer-contrast` is useful for users with low vision or photosensitivity who prefer high contrast modes.

## Navigation

When talking about navigation of websites, one thing that we need to remember and be cautious of is that not everyone uses the same method and the same input devices to navigate through a website or different websites. Some people use mouse scroll to scroll through a page, some use navigation using their keyboard or a switch control device, and some may use a screen reader to browse through the different heading levels. So when making a website, it's important to keep in mind that the website works for everyone, irrespective of the device or assistive technology they are using, and not just a particular group of people.

### Focus indication

Focus indication is super important for people who primarily rely on keyboard navigation, or different kinds of switch control devices. These methods are often used by people with limited motor capacity. There are many different switch control devices, from a [single switch](https://www.24a11y.com/2018/i-used-a-switch-control-for-a-day/) to a [sip-and-puff device](https://accessibleweb.com/assistive-technologies/assistive-technology-focus-sip-and-puff-devices/). Visible focus styles and proper focus orders are super important for such users.

#### Focus styles

The WCAG requires a visible focus indicator for all interactive content to help people know which element has the keyboard focus. In fact in WCAG 2.2 (which is expected to be published in December 2022), it has been promoted to Level A .

{{ figure_markup(
  image="pages-overriding-focus-styles.png",
  caption="Pages overriding focus styles.",
  description="A bar chart showing 89.7% of desktop sites and 88.9% of mobile sites use a `:focus` pseudo class, and 90.0% of desktop sites and 91.0% of mobile sites use the `:focus` pseudo class to set the outline to 0 or none. 9.0% of desktop sites and 9.8% of mobile sites use the `:focus-visible` pseudo class.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?format=interactive&oid=500239469",
  sheets_gid="1548098920",
  sql_file="focus_outline_0.sql",
) }}

In the above graph, 86.0% of the websites in the desktop add `:focus {outline: 0}`. This means that they are removing the default outline that browsers put for the focused interactive element. In some cases, they are overridden using some other style, but in most cases, no new focus style is added, making it impossible for users to determine which element has focus and hinders navigation. Sara Souedian has a great article on how to design WCAG-compliant focus indicators. However, it’s exciting to see that 9.0% of websites in mobiles have `:focus-visible` compared to only 0.6% last year. This is definitely a step in the right direction.

#### TabIndex

`tabindex` is an attribute that can be added to elements to control whether it can be focused. Depending on its value, the element can also be in the keyboard focus, or “tab” order.

We found 59.6% of websites in mobile and 61.8% of websites in desktop uses `tabindex`. `tabindex` attribute can be used for a few different purposes, which may or may not cause accessibility issues. Adding `tabindex="0"` adds an element in the sequential keyboard focus order. Custom elements and widgets that are intended to be interactive and in the keyboard focus order need an explicitly assigned `tabindex="0"`. `tabindex="-1"` means that the element is not in the keyboard focus order, but can be programmatically focused using JavaScript. It's important to remember that placing non-interactive elements in the keyboard focus order can be confusing for low-vision users and should hence be avoided.

{{ figure_markup(
  image="tabindex-usage-and-values.png",
  caption="`tabindex` usage",
  description="Bar chart showing that of pages that use `tabindex`, a negative or zero `tabindex` is used on 97.3% of those pages for desktop and 97.9% of those pages for mobile, a `tabindex` of 0 is used on 76.7% and 76.4% respectively, a negative `tabindex` is used on 69.1% and 69.4%, and finally a positive `tabindex` is used on 8.5% and 7.4%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?format=interactive&oid=723679746",
  sheets_gid="1436895233",
  sql_file="tabindex_usage_and_values.sql",
) }}

Out of all websites in mobile with `tabindex` attribute, 7.4% have `tabindex` with a positive value. A positive value for `tabindex` is used to override the keyboard focus order and most of the time leads to a WCAG 2.4.3 - Focus Order failure. Using positive values for `tabindex` is generally bad since it disrupts the normal navigation and Karl Groves has a great article on why that's the case.

### Landmarks

Landmarks help to divide a web page into thematic regions that makes it easier for users of assistive technologies to better understand the page structure and better navigate through the website. For example a rotor menu can be used to navigate to different landmarks of the page, and or a skip link can be used to target the `<main>` landmark. Landmarks can be created using various HTML5 elements or explicitly adding [ARIA landmark roles](https://www.w3.org/TR/WCAG20-TECHS/ARIA11.html). However, following the first rule of ARIA, one should give preference to native HTML5 elements.

<figure>
<table>
 <thead>
   <tr>
     <th>HTML5 <br />element</th>
     <th>ARIA role <br />equivalent</th>
     <th>Pages with <br />element</th>
     <th>Pages with <br />role</th>
     <th>Pages with <br />element or role</th>
   </tr>
 </thead>
 <tbody>
   <tr>
     <td>`<main>`</td>
     <td>`role="main"`</td>
     <td class="numeric">31.0%</td>
     <td class="numeric">16.8%</td>
     <td class="numeric">38.1%</td>
   </tr>
   <tr>
     <td>`<header>`</td>
     <td>`role="banner"`</td>
     <td class="numeric">63.4%</td>
     <td class="numeric">13.2%</td>
     <td class="numeric">64.8%</td>
   </tr>
   <tr>
     <td>`<nav>`</td>
     <td>`role="navigation"`</td>
     <td class="numeric">63.4%</td>
     <td class="numeric">22.1%</td>
     <td class="numeric">67.0%</td>
   </tr>
   <tr>
     <td>`<footer>`</td>
     <td>`role="contentinfo"`</td>
     <td class="numeric">64.6%</td>
     <td class="numeric">11.4%</td>
     <td class="numeric">65.7%</td>
   </tr>
 </tbody>
</table>
<figcaption>
{{ figure_link(
  caption="Landmark element and role usage (desktop).",
  sheets_gid="2141972716",
  sql_file="landmark_elements_and_roles.sql",
) }}
</figcaption>
</figure>

The most commonly expected landmarks that the majority of web pages should have, are `<main>`, `<header>`, `<nav>` and `<footer>`. We found that only 31% of desktop pages have a native HTML `<main>` element, 16.8% of desktop pages have an element with a `role="main"`, and 38.1% of pages have either. It’s good to see the use of native elements increase and use of `role=”main”` decrease, even though the change is very minimal. Scott O' Hara's article on landmarks covers all the details that one should keep in mind to ensure better accessibility.

### Heading hierarchy

Headings is yet another way that helps users of assistive technologies to better navigate through the website, skipping to the exact sections that they are interested in. As mentioned in Marcy Sutton's article , headings can be thought of as a table of contents that one can navigate through to go to a particular content area.

57.7%

{{ figure_markup(
  content="57.7%",
  caption="Mobile sites passing the Lighthouse audit for properly ordered headings.",
  classes="big-number",
  sheets_gid="1270834582",
  sql_file="lighthouse_a11y_audits.sql",
) }}

57.7% of the sites checked pass the test for properly ordered headings that do not skip levels which is the same as last year. Hopefully this number will increase next year since the document outline example in WHATWG standards have been updated. A very important thing to remember is heading levels don't represent the actual style (or importance) of a particular element. Headings are to be used only for hierarchy purposes and CSS can be used for the styling of the element. A very good article to read on how to structure headings in your page is by Steve Faulkner titled, ["How to mark up subheadings, subtitles, alternative titles and taglines"](https://stevefaulkner.github.io/Articles/How%20to%20mark%20up%20subheadings,%20subtitles,%20alternative%20titles%20and%20taglines.html).

### Secondary navigation

WCAG requires your website to have multiple ways to navigate between the different pages apart from the primary navigation menu in the header. For example, people with cognitive limitations prefer to use search features to search for a page if there are a substantial number of pages in a website.

There are 22.7% of websites on mobile that have a search input. Another recommended way for a secondary navigation is providing a sitemap for your website. Although we do not have any data about the presence of site maps, this technique guide from the W3C explains what they are in detail and how to implement one effectively.

### Skip links

Skip links allow keyboard or switch control device users to skip through different sections of pages for better navigation. One of the most common sections to skip is the primary navigation to go to the `<main>` section, especially if it's a website, which has a really large number of links in their primary navigation.

It's not possible for us to find out all the skip links, since it can be used to even skip parts of the pages, if the page is content heavy. We found 21.0% of links in desktop and mobile pages, which are likely skip links, skipping to the `<main>` section. We checked this by looking for the presence of an href="#main" attribute on one of the first three links on the page

### Document titles

Descriptive page titles are helpful for context when moving between pages, tabs, and windows with assistive technology because the change in context will be announced.

{{ figure_markup(
  image="page_title-information.png",
  caption="Title element statistics",
  description="A bar chart showing 97.6% of desktop sites and 97.7% of mobile sites use the `<title>` element, 68.6% and 70.0% of those titles have four or more words, and 3.7% and 4.0% are changed on render.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?format=interactive&oid=154664062",
  sheets_gid="634812711",
  sql_file="page_title.sql",
) }}

Though there are 97.7% of websites on mobile which have a document title, only 70% have a title which is longer than four words. This possibly means that the title only has the name of the website, but not a description about the particular page of the website. A title should ideally have both the title of the website as well as a title giving context about the page in the website for better navigation.

### Tabs

We found that 8.7% of desktop pages have at least one element with a role="tablist", 7.7% of pages have elements with a role="tab" and 7.2% of pages have elements with a role="tabpanel"

### Tables

Tables help in representing data and the relationships between the data using the two axes. Tables should have a well-formatted structure with the appropriate elements and markups that helps assistive technology users to easily comprehend the data represented in the table as well as navigate through the table. Table caption, appropriate headers and appropriate header cells for every row are such important elements that help users of assistive technology to make sense of the data.

<figure>
 <table>
   <thead>
     <tr>
       <td></td>
       <th scope="colgroup" colspan="2">Table sites</th>
       <th scope="colgroup" colspan="2">All sites</th>
     </tr>
     <tr>
       <td></td>
       <th scope="col">Desktop</th>
       <th scope="col">Mobile</th>
       <th scope="col">Desktop</th>
       <th scope="col">Mobile</th>
     </tr>
   </thead>
   <tbody>
     <tr>
       <td>Captioned tables</td>
       <td class="numeric">5.4%</td>
       <td class="numeric">4.7%</td>
       <td class="numeric">1.3%</td>
       <td class="numeric">1.2%</td>
     </tr>
     <tr>
       <td>Presentational table</td>
       <td class="numeric">1.2%</td>
       <td class="numeric">0.9%</td>
       <td class="numeric">0.6%</td>
       <td class="numeric">0.5%</td>
     </tr>
   </tbody>
 </table>
 <figcaption>
{{ figure_link(
  caption="Accessible table usage.",
  sheets_gid="599630882",
  sql_file="table_stats.sql",
) }}
</figcaption>
</figure>

When providing a caption for the table, the `<caption>` element is the correct semantic choice to provide the most context to a screen reader user. Table captions act as a heading summarizing the information of the table. 1.3% of desktop sites with table elements present used a <caption>.

Tables are also sometimes used for layouting, though with the arrival of Flexbox and Grid, one should definitely avoid tables for any kind of layouting. However, if tables are still used just for layouting, then it should have `role="presentation"`. We see 1%say X% of tables have `role="presentation"` though that could also mean people are not using the role, which makes the layout very inaccessible.

### Captchas

Websites often want to verify that the visitor of a website is a human and not a bot. There are often bots, which crawl the websites for various different purposes. For example, The Web Almanac is created each year by sending out a similar kind of web crawler to gather information from websites. These types of “human-only” tests are called a CAPTCHA— “Completely Automated Public Turing Test, to Tell Computers and Humans Apart”.

18.5%

{{ figure_markup(
  content="18.5%",
  caption="Mobile sites using a CAPTCHA",
  classes="big-number",
  sheets_gid="1615174635",
  sql_file="captcha_usage.sql",
) }}

18.5% of websites on mobile have captchas. This type of test can be difficult to solve for everyone but would likely be more difficult for people with low vision and other vision or reading related disabilities. Also, such tests might fail under WCAG 3.3.7 Accessible Authentication once WCAG 2.2 is released. W3C actually has a paper on alternatives to visual turing tests that is definitely recommended

## Forms

Forms are one of the most important ways that the users interact with the website and submit information. Whether it be logging into a site, making a comment or a post in social media, or making a purchase at an ecommerce site, all of those require a form. Without proper accessibility of forms, people with disabilities can't interact with websites properly and that restricts them from using the benefits of the website.

There are definitely certain very specific things that one should keep in mind when it comes to accessibility in forms.

### `<label>` element

`<label>` element is the most effective way of providing accessible names to input fields (or [form controls](https://developer.mozilla.org/en-US/docs/Learn/Forms/Basic_native_form_controls)) in a form. One can link a `<label>` to a form control programmatically using the `for` attribute The `for` attribute should contain the value of the `id` attribute of the form control element that you want to link it with. For example:

```html
<label for="email">Email</label> <input type="email" id="email" />
```

The `for` attribute is very important, because without that, the `<label>`, even though visually present, won't be linked to any form control. Without a `<label>` element linked to a form control, it affects the usability of the form because there's a good chance that the forms are missing an accessible name.

{{ figure_markup(
  image="form-input-name-sources.png",
  caption="Where inputs get their accessible names from.",
  description="A bar chart showing 38.3% of desktop input elements and 38.0% of mobile input elements have no accessible name. `placeholder` is the source for 23.7% of desktop pages and 26.0% of mobile pages. For `relatedElement: label` it's 19.8% and 18.8% respectively, for `attribute: aria-label` it's 7.2% and 8.2%, for `attribute: value` it's 5.3% and 5.1%, for `attribute: title` it's 3.5% and 2.3%, for `attribute: alt` it's 1.2% and 1.0%, for `attribute: type` it's 0.6% and 0.5%, for `relatedElement: aria-labelledby` it's 0.3% and 0.2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=231535249&format=interactive",
  sheets_gid="1245935907",
  sql_file="form_input_name_sources.sql",
  width="600",
  height="537",
) }}

18.8% of the inputs use `<label>` and 38.0% of the inputs have no accessible names. Without a proper accessible name, a screen reader user or a voice to text user won't be able to identify an input or give proper input data to the form. Often there are designs in websites today, which don't have any visible labels which causes the problem of input fields not having any accessible name. Ideally, all designs for input fields should have labels, since that helps sighted users to better understand the purpose of the field as well, as unlike something like `placeholder` they are always visible. In case for aesthetic reasons, one needs to not show labels visually, one should still add a screenreader-only `<label>` to provide the accessible name.

### `placeholder` attribute

The purpose of a `placeholder` attribute in a form control is to provide example data that the form control accepts. This helps provide formatting information sometimes. For example, `<input type="text" id="credit-card" placeholder="1234-5678-9999-0000">` lets the user know an example of the format in which the card number should be inserted.

However, unlike `<label>` elements, the `placeholder` attribute disappears the moment someone starts typing or entering data. This can cause users with cognitive disabilities to get disoriented about the data they were trying to input. Also, not all screen readers support `placeholder` attribute for accessible names which can also be problematic. Hence, using the `placeholder` attribute for accessible names has many accessibility issues .

{{ figure_markup(
  image="placeholder-but-no-label.png",
  caption="Use of placeholders on inputs.",
  description="A bar chart showing 58.6% of desktop sites and 55.5% of mobile sites use placeholders. 66.7% of desktop sites and 67.2% of mobile sites have inputs with no label. 61.1% of desktop sites and 62.7% of mobile sites have placeholders and also inputs with no labels.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=1142115744&format=interactive",
  sheets_gid="1464041597",
  sql_file="placeholder_but_no_label.sql",
) }}

62.7% of the websites have inputs with only `placeholder` attribute and no `<label>` element linked to it. It has become very prevalent in website designs these days to provide a `placeholder` attribute for labeling the input instead of `<label>`. As mentioned in the previous section, even though that's aesthetically needed for the visual design, it's important to provide a `<label>` for screen reader users at least.

The HTML5 specification clearly states, “The placeholder attribute should not be used as an alternative to a label.”

```
<figure>
  <blockquote>Use of the placeholder attribute as a replacement for a label can reduce the accessibility and usability of the control for a range of users including older users and users with cognitive, mobility, fine motor skill or vision impairments.</blockquote>
  <figcaption>
	— <cite><a hreflang="en" href="https://www.w3.org/WAI/GL/low-vision-a11y-tf/wiki/Placeholder_Research">The W3C’s Placeholder Research</a></cite>
  </figcaption>
</figure>
```

### Requiring information

When web developers gather input from their end users, they need a clear way to indicate what information is optional, and what information is required to proceed. For example, in a form, email input might be a required field, but middle name can be an optional field. Before HTML5 introduced the required attribute for `<input>` fields in 2014, a common convention is to put an asterisk (\*) in the label for required input fields. However putting an asterisk is just a visual information, and provides no validation or information to assistive technologies that a field is required.

{{ figure_markup(
  image="form-required-controls.png",
  caption="How required inputs are specified",
  description="A bar chart showing the `required` attribute is used on 65.6% of desktop sites and 67.2% of mobile sites, `aria-required` is used by 32.4% and 31.8%, asterisk is used by 21.9% and 21.7%, `required` and `aria-required` is used by 7.9% and 8.5%, asterisk and `required` is used by 7.7% and 8.6%, asterisk and `aria-required` is used by 7.1% and 5.9%, and all three are used by 0.9% and 0.8%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=782719766&format=interactive",
  sheets_gid="1918657462",
  sql_file="form_required_controls.sql",
  width="600",
  height="505",
) }}

The `required` and `aria-required` attributes are two ways of telling an assistive technology that an input field is not optional. The `required` attribute actually prevents form submission without an input, but `aria-required` only conveys the information to assistive technology and doesn't validate the input. We found that 67.2% of the sites use `required` attribute and 31.8% use `aria-required`. However, there are still 21.7% websites which only use an asterisk (\*) to indicate a field is required. That should definitely be avoided unless accompanied with `required` and `aria-required`.

## Media on the web

### Overview of text alternatives

#### Images

{{ figure_markup(
  image="pages-containing-alt-with-file-extension.png",
  caption="Pages containing an `alt` attribute with a file extension.",
  description="A bar chart showing in 2020 6.8% of desktop sites and 6.4% of mobile sites used and extension in the `alt` attribute. This increased to 7.3% of desktop sites and 7.1% of mobile sites in 2021, and in 2022 to 7.2% of desktop sites and 7.5% of mobile sites",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=1961543902&format=interactive",
  sheets_gid="304752448",
  sql_file="alt_ending_in_image_extension.sql",
) }}

image="common-file-extensions-in-alt-text.png",
caption="Most common file extensions in `alt` text.",
description="A bar chart showing of all extensions used in alt `jpg` is used 52.9% of the time on desktop sites and 52.8% for mobile, `png` is 34.1% and 34.4% and respectively, `ico` is 4.9% and 4.8%, `jpeg` is 3.2% and 3.8%, `svg` is 2.0% and 1.6%, `gif` is 1.8% and 1.6%, `webp` is 0.5% and 0.5%, and finally `tif` is 0.4% and 0.3%.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=288529525&format=interactive",
sheets_gid="304752448",
sql_file="alt_ending_in_image_extension.sql",
width="600",
height="764",
) }}

{{ figure_markup(
  image="alt-attribute-lengths.png",
  caption="`alt` attribute lengths.",
  description="A bar chart showing no `alt` is set on 17.9% of desktop images and 18.0% of mobile images, it is set to empty on 27.0% and 27.9% respectively, it is 10 characters or less on 16.0% and 15.3%, 20 characters or less on 14.3% and 14.1%, 30 characters or less on 8.4% and 8.4%, 100 characters or less on 15.1% and 15.0%, and it is greater than 100 characters on 1.2% and 1.2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=1428144088&format=interactive",
  sheets_gid="877399863",
  sql_file="common_alt_text_length.sql",
) }}

58.7% of sites pass the test for images with alt text, a small increase from 57.8% in 20202 and 54% in 2019

#### Audio

0.03%
{{ figure_markup(
  content="0.03%",
  caption="Desktop websites with an `<audio>` element have at least one accompanying `<track>` element",
  classes="big-number",
  sheets_gid="201877037",
  sql_file="audio_track_usage.sql",
) }}

#### Video

0.7%
{{ figure_markup(
  content="0.7%",
  caption="Desktop websites with a `<video>` element have at least one accompanying `<track>` element",
  classes="big-number",
  sheets_gid="345150659",
  sql_file="video_track_usage.sql",
) }}

## Supporting assistive technology with ARIA

### ARIA roles

{{ figure_markup(
  image="sites-using-role.png",
  caption="Number of ARIA roles used by percentile.",
  description="Bar chart showing the number of ARIA roles used by percentile. At the 10th and 25th percentile 0 roles are used for both desktop and mobile, at the 50th percentile 4 roles are used for both, at the 75th percentile 16 roles are used on desktop and 15 on mobile, and at the 90th percentile 43 roles are used on desktop and 38 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=2082926503&format=interactive",
  sheets_gid="752623932",
  sql_file="sites_using_role.sql",
) }}

{{ figure_markup(
  image="top-10-aria-roles.png",
  caption="Top 10 most common ARIA roles.",
  description="Bar chart showing `button` is used by 32.5% of desktop sites and 32.5% of mobile sites, `presentation` by 24.9% and 23.7% respectively, `dialog` by 22.8% and 21.9%, `navigation` by 22.1% and 21.9%, `search` by 19.6% and 18.9%, `main` by 16.8% and 16.7%, `banner` by 13.2% and 13.2%, `img` by 12.6% and 12.1%, `contentinfo` by 11.4% and 11.4%, and finally `none` by 11.0% and 11.3%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=1302320094&format=interactive",
  sheets_gid="283521996",
  sql_file="common_aria_role.sql",
  width="600",
  height="540",
) }}

### Just use a button!

20.6%
{{ figure_markup(
  content="20.6%",
  caption="Desktop websites have at least one link with a button role",
  classes="big-number",
  sheets_gid="751886683",
  sql_file="anchors_with_role_button.sql",
) }}

We found that 33% (up from 29% in 2021, 25% in 2020) of desktop and mobile sites had homepages with at least one element with an explicitly assigned role="button".

### Using presentation role

We found that 25% of desktop pages (up from 22% in 2021) and 24% of mobile pages (up from 24% in 2021) have at least one element with role="presentation".

### Labelling and describing elements with ARIA

{{ figure_markup(
  image="top10-aria-attributes.png",
  caption="Top 10 ARIA attributes.",
  description="A bar chart showing `aria-label` is used by 58.4% of desktop sites and 57.0% of mobile sites, `aria-hidden` by 57.8% and 57.0% respectively, `aria-expanded` by 28.5% and 27.8%, `aria-labelledby` by 24.3% and 22.6%, `aria-controls` by 23.9% and 22.8%, `aria-live` by 23.3% and 22.3%,  `aria-haspopup` by 20.5% and 19.3%, `aria-current` by 17.8% and 19.4%, `aria-describedby` by 15.6% and 14.3%, and finally `aria-atomic` by 10.8% and 10.1%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=1585975336&format=interactive",
  sheets_gid="711360879",
  sql_file="common_element_attributes.sql",
) }}

#### Where do buttons get their accessible names from?

{{ figure_markup(
  image="button-name-sources.png",
  caption="Button accessible name source.",
  description="A bar chart showing the contents are used for 60.9% of desktop buttons and 57.9% of mobile buttons, `aria-label` attribute is used for 19.6% and 23.1% respectively, there is no accessible name for 9.1% and 11.8%, the `value` attribute is used for 9.6% and 6.6%, `title` attribute is used for 0.7% and 0.5%, an `aria-labelledby` related element is used for 0.1% and 0.1%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=561787469&format=interactive",
  sheets_gid="597786485",
  sql_file="button_name_sources.sql",
  width="600",
  height="457",
) }}

### Hiding content

57.8%
{{ figure_markup(
  content="57.8%",
  caption="Desktop websites have at least one instance of the `aria-hidden` attribute",
  classes="big-number",
  sheets_gid="711360879",
  sql_file="common_element_attributes.sql",
) }}

We found that 24% of desktop pages and 23% of mobile pages had at least one element with the aria-expanded attribute.

### Screen reader-only text

15.4%
{{ figure_markup(
  content="15.4%",
  caption="Desktop websites with a `sr-only` or `visually-hidden` class",
  classes="big-number",
  sheets_gid="642136962",
  sql_file="sr_only_classes.sql",
) }}

### Dynamically-rendered content

We found that 23% of desktop pages (up from 21% in 2021, 17% in 2020) and 22% of mobile pages (up from 20% in 2021, 16% in 2020) have live regions.

## Accessibility overlays

{{ figure_markup(
  image="pages-using-a11y-apps.png",
  caption="Pages using accessibility apps.",
  description="A bar chart showing 1.6% of desktop sites and 1.2% of mobile sites use an accessibility app.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=1586321777&format=interactive",
  sheets_gid="667492149",
  sql_file="a11y_technology_usage.sql",
) }}

{{ figure_markup(
  image="a11y-app-usage-by-rank.png",
  caption="Accessibility app usage by rank.",
  description="A bar chart showing usage of the most popular accessibility apps by domain rank on desktop sites. AccessiBe is used by 0.13% of the top 1,000 sites and by 0.15% of the top 10,000 sites, by 0.48% of the top 100,000 sites, by 0.48% of the top million sites and by 0.37% of all sites. AudioEye is used by 0.13% (one), 0.27%, 0.16%, 0.21%, and 0.35% respectively. EqualWeb is not used on the top 1,000 sites, but is used by 0.02% of the top 10,000 site, 0.07% of the top 100,000, 0.05% of the top million, and 0.03% of all sites. Texthelp similarly is not used on the top 1,000 or top 10,000 sites but is used by 0.02% of the top 100,000, 0.04% of the top million, and 0.03% of all sites. Finally, UserWay is not used on the top 1,000 sites but is used by 0.07% of the top 10,000 sites, by 0.12% of the top 100,000 sites, by 0.31% of the top million and by 0.49% of all sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=741701117&format=interactive",
  sheets_gid="1961985994",
  sql_file="a11y_technology_usage_by_domain_rank.sql",
) }}

{{ figure_markup(
  image="pages-using-a11y-apps-by-rank.png",
  caption="Pages using accessibility apps by rank.",
  description="A bar chart showing that for the top 1,000 sites, 0.4% on desktop and 0.3% on mobile use and accessibility app, for the top 10,000 it's 0.9% and 0.8% respectively, for the top 100,000 it's 1.2% and 1.1%, for the top million it's 1.4% and 1.3%, and finally for all sites 1.6% it's 1.2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSi-gjiB_GnE2U4P7oxN2zqs0DbA2YDPqtsfIm3IBmtph_VE7FTrQvw7L6FsOsJlcZFI6HEULXuKEeb/pubchart?oid=2069674657&format=interactive",
  sheets_gid="134319036",
  sql_file="a11y_overall_tech_usage_by_domain_rank.sql",
) }}

### The consequences of overlays

### Privacy concerns

### Overlays and lawsuits

### Why do some companies use overlays?

### Additional resources about overlays

## Conclusion
