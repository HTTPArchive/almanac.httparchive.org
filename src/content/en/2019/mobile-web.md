---
part_number: II
chapter_number: 12
title: Mobile Web
description: Mobile Web chapter of the 2019 Web Almanac covering page loading, textual content, zooming and scaling, buttons and links, and ease of filling out forms
authors: [obto]
reviewers: [aymenloukil, hyperpress]
published: 2019-11-04T12:00:00+00:00:00
last_updated: 2019-11-04T12:00:00+00:00:00 
---

# Chapter 12: The mobile web

## Introduction

Let’s step back a moment… to the year 2007. The "mobile web" is currently just a blip on the radar, and for good reason too. Why? Mobile browsers have little to no CSS support, meaning sites look nothing like they do on desktop (some browsers can only display text). Screens are incredibly small and can only display a few lines of text at a time. And the replacement for a mouse are these tiny little arrow keys you use to “tab around”. Needless to say, browsing the web on a phone is truly a labor of love. However, all of this is just about to change.

In the middle of his presentation, Steve Jobs takes the newly unveiled iPhone, sits down, and begins to surf the web in a way we had only previously dreamed of. A large screen and fully featured browser displaying websites in their full glory. And most importantly, surfing the web using the most intuitive pointer device known to man: our fingers. No more alt tabbing with tiny little arrow keys.

Since 2007, the mobile web has grown at an exploding rate. And now 13 years later, mobile accounts for [59% of all searches](https://www.merkleinc.com/thought-leadership/digital-marketing-report) and 58.7% of all web traffic. It’s no longer an afterthought, but the primary way people experience the web. So given how significant mobile is, what kind of experience are we giving our visitors? Where are we falling short? Let’s find out.

**_Note:_** Mobile web traffic % gathered from Akamai mPulse data in July 2019

## The page loading experience

The first part of the mobile web experience we analyzed is the one we’re all most intimately familiar with: *the page loading experience*. But before we start diving into our findings, let's make sure we're all on the same page regarding what the average mobile user *really* looks like. Because this will not only help you reproduce these results, but understand these users better.

Let’s start with what phone the average mobile user has. The average android phone [is ~$250](https://web.archive.org/web/20190921115844/https://www.idc.com/getdoc.jsp?containerId=prUS45115119), and one of the [most popular phones](https://web.archive.org/web/20190812221233/https://deviceatlas.com/blog/most-popular-android-smartphones) in that range is a Samsung Galaxy S6… so this is likely the kind of phone they use (4x slower than that iPhone 8 you may have). This user doesn’t have access to a much faster 4G connection, but rather a 2G ([29%](https://www.gsma.com/r/mobileeconomy/) of the time) or 3G connection ([28%](https://www.gsma.com/r/mobileeconomy/) of the time). And this is what it all adds up to:

<table>
  <tr>
    <th>Connection type</th>
    <td>[2G or 3G](https://www.gsma.com/r/mobileeconomy/)</td>
  </tr>
  <tr>
    <th>Latency</th>
    <td>300 - 400ms</td>
  </tr>
  <tr>
    <th>Bandwidth</th>
    <td>0.4 - 1.6Mbps</td>
  </tr>
  <tr>
    <th>Phone</th>
    <td>[Galaxy S6](https://www.gsmarena.com/samsung_galaxy_s6-6849.php) — [4x slower](https://www.notebookcheck.net/A11-Bionic-vs-7420-Octa_9250_6662.247596.0.html) than iPhone 8 (Octane V2 score)</td>
  </tr>
</table>

*The average mobile user*

I imagine some of you are surprised by these results. They may be far worse conditions than you’ve ever tested your site with. But now that we’re all on the same page with what a mobile user truly looks like… let’s get started.

### Pages bloated with javascript

The state of javascript on the mobile web is terrifying. According to HTTP Archive's [compiled report on javascript](https://httparchive.org/reports/state-of-javascript), the median mobile site requires phones to **download 375KB** of javascript. Meaning phones have to **parse, compile, and execute ~1.25MB** of javascript on average (assuming a typical 70% compression ratio).

Why is this a problem? Because sites loading this much JS take upwards of [10 seconds](https://httparchive.org/reports/loading-speed#ttci) to become interactive. Or in other words: your page may appear fully loaded, but when a user clicks any of your buttons, menus, etc… nothing happens because the JS hasn't finished executing. Users are forced to keep clicking the button for upwards of 10 seconds, just waiting for that magical moment where something actually happens. Think about how confusing and frustrating that gets.

<iframe width="560" height="315" src="https://www.youtube.com/embed/Lx1cYJAVnzA?rel=0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

*Example displaying how painful of an experience waiting for JS to load can be*

Let’s delve deeper and look at another metric more focused on *how well* each page utilizes its javascript (does it really need as much as it’s loading). We call this metric the *Javascript Bloat Score* (based on [web bloat score](https://www.webbloatscore.com/)). The idea behind it is this:

1. Javascript is often used to both generate and change the page as it loads.

2. It’s also delivered as text to the browser. So it compresses well, and should be delivered faster than just a screenshot of the page.

3. So… if the total amount of JS a page downloads **ALONE** (not including images, css, etc…) is larger than a PNG screenshot of the viewport, we are using far too much javascript. Since at this point, it'd be faster to just send that screenshot.

> The *Javascript Bloat Score* is defined as: (total Javascript size) / (size of PNG screenshot of viewport). Any number greater than 1.0 means it’d faster to send a screenshot.

The results of this? Of the 5 million+ websites analyzed, **75.52% were bloated with javascript**. We have a long way to go.

**_Notes:_**

1. We were not able to capture and measure the screenshots of all 5 million+ sites we analyzed. Instead, we took a random sampling of 1000 sites to find what the median viewport screenshot size is (140KB), and then compared each site’s JS download size to this number.

2. For a more in-depth breakdown on the true cost of javascript, check out this great post by [Addy Osmani](https://medium.com/@addyosmani/the-cost-of-javascript-in-2018-7d8950fbb5d4).

### Service worker usage

Browsers typically load all pages the same. They prioritize the download of some resources above others, follow the same caching rules, etc. Thanks to service workers though, we now have a way to directly control how our resources our requested, cached, etc. Often times resulting in quite significant improvements to our page load times.

Despite being available for several years (since 2016) and implemented on every major browser (including iOS safari)... only **0.64% of sites** utilize them!

### Shifting content while loading

One of the most beautiful parts of the web is how webpages load progressively by nature. Browsers download and display content as soon as they are able, so users can engage with your content ASAP. However, this can have a detrimental effect if you don’t design your site with this in mind. The detrimental effect being: your content moving *up, down, and all around* as the page loads.

You’ve probably encountered at least one of these scenarios: you’re reading an article when all of a sudden, an image loads and pushes the text you’re reading way down the screen. You now have to hunt for where you were or just give up on reading the article (similar to the video below). Or perhaps even worse… you begin to click a link right before an ad loads in the same spot, resulting in you accidentally clicking the ad instead.

![A video showing a website progressively load. The text is displayed quickly, but as images continue to load the text gets shifted further and further down the page each time—making it very frustrating to read. The calculated CLS of this example is 42.59%. Image courtesy of LookZook](/static/images/2019/12_Mobile_Web/example-of-a-site-shifting-content-while-it-loads-lookzook.gif)

*Example of shifting content distracting a reader. CLS total of **42.59**%. Image courtesy of LookZook*

So how do we measure how much our sites shift? In the past it was quite difficult (if not impossible), but thanks to the new [Layout Instability API](https://web.dev/layout-instability-api) we can do this in two steps:

1. Via the Layout Instability API, track each shift’s impact on the page. This is reported to you as a percentage of how much content in the viewport has shifted.

2. Take all the shifts you’ve tracked and add them together. The result is what we call the [Cumulative Layout Shift (CLS)](https://web.dev/layout-instability-api#a-cumulative-layout-shift-score).

Because every visitor can have a different CLS, in order to analyze this metric across the web with the [Chrome User Experience Report](https://developers.google.com/web/tools/chrome-user-experience-report) (CrUX), we combine every experience into three different buckets:

1. Small CLS: Experiences where CLS is *under 5%*. That is, the page is mostly stable and does not shift very much at all. For perspective, the video above is an experience which has a CLS of 42.59%.

2. Large CLS: Experiences where CLS is *100% or greater*. There are either *a lot* of small individual shifts, or a few *very large* and noticeable ones going on—something worth investigating.

3. Medium CLS: Anything in between small and large.

So what do we see when we look at CLS across the web?

1. **Nearly two out of every three sites (65.32%)** have *medium or large* CLS for 50% or more of all user experiences.

2. **20.52% of sites** have *large CLS* for at least half of all user experiences—that’s just a bit over *one fifth* of all websites. Remember, the video above only has a CLS of 42.59% total; these are experiences worse than that (large cls is 100% total, or more).

We suspect much of this is from websites not providing an explicit width and height ads and images loading after text has been painted to the screen and here’s why:

Before browsers can display a resource on the screen they need to know how much room the resource will take up. So unless an explicit size is provided, via CSS or HTML attributes, browsers have no choice but to display the resource with a width and height of 0px until its downloaded. Because until then, there is no way to know how large it is.

So what happens when it loads? Browsers finally have information on how big the resource is, and shift the page’s contents to make room for it, creating an experience like the video above.

### Permission requests

Over the last few years, the line between websites and "app store" apps has continued to blur. You now even have the ability to request access to a user’s microphone, video camera, geo-location, ability to display notifications, and more.

While this has opened up even more options for developers, needlessly requesting for these permissions leave users feeling wary of your webpage, and can build mistrust. This is why we recommend to always tie a permission request to a user gesture—like tapping a "Find theaters near me" button.

Right now **1.52% of sites** request permissions without a user-interaction. Seeing such a low number is encouraging. However, it's important to note that we were only able to analyze home pages. So for example, sites requesting permissions only on their content pages (e.g., their blog posts) were not accounted for.

## Textual content

The primary goal of a webpage is to deliver content users want to engage with. This content might be a youtube video or an assortment of images… but often times, it’s simply the text on the page. Which means it goes without saying that ensuring our textual content is legible to our visitors is extremely important. Because if visitors can’t read it, there’s nothing left to engage with, and they’ll leave. There are two key things to check when ensuring your text is legible to readers: color contrast, and font sizes.

### Color contrast

When designing our sites we tend to be in more optimal conditions, and have far better eyes than many of our visitors. Visitors may be colorblind and unable to distinguish between the font and background color ([1 in every 12 men and 1 in 200 women](https://web.archive.org/web/20180304115406/http://www.allpsych.uni-giessen.de/karl/colbook/sharpe.pdf) of European descent), or perhaps they’re reading while the sun is creating tons of glare on their screen—resulting in much the same effect as someone with color blindness. I’d imagine you’ve experienced the latter yourself a few times.

To help us mitigate this problem, there are [published guidelines](https://dequeuniversity.com/rules/axe/2.2/color-contrast) we can follow when choosing our text and background colors. So how are we doing in meeting these baselines? **Just 22.04%** of sites give all their text sufficient color contrast. In fact, this number is probably far worse as we could only analyze text with solid backgrounds (image and gradient backgrounds were unable to be analyzed).

![Four colored boxes of orange and gray shades with white text overlayed inside creating two columns, one where the background color is too lightly colored compared to the white text and one where the background color is recommended compared to the white text. The hex code of each color is displayed, white is #FFFFFF, the light shade of orange background is #FCA469, and the recommended shade of orange background is #F56905. Image courtesy of LookZook](/static/images/2019/12_Mobile_Web/example-of-good-and-bad-color-contrast-lookzook.png)

_Example of what text with insufficient color contrast looks like. Courtesy of LookZook_

**_Note:_** The percentage of colorblind men and women varies by racial group. Numbers for other groups can be found in [this paper](https://web.archive.org/web/20180304115406/http://www.allpsych.uni-giessen.de/karl/colbook/sharpe.pdf).

### Font size

The second part of legibility, is ensuring the text on our page is large enough to easily read. This is exceptionally important for all sites, but even more so the older your age demographic is. How large text needs to be varies, but a good rule of thumb is to never use a font size under 12px.

Across the web we found **80.66% of sites** meet this baseline.

## Zooming, scaling and rotating pages

### Zooming and scaling

Designing your site to work perfectly across the tens of thousands of screen sizes and devices is incredibly difficult, albeit impossible. Some users need larger font sizes to read, zoom in on your product images, or need a button to be larger because it's too small and slipped past your QC. Reasons like these are why device features like pinch-to-zoom and scaling are so important—they allow users to tweak our pages so their needs are met.

There do exist very rare cases when disabling this is acceptable, like when the page in question is a web-based game using touch controls. If left enabled in this case, players’ phones will zoom in and out every time the player taps twice on the game, resulting in a less than usable experience.

Because of this, developers are given the ability to disable this feature by setting one of the following two properties in the meta viewport tag:

1. `user-scalable` set to `0` or `no`

2. `maximum-scale` set to `1`, `1.0`, etc

However, developers have misused this so much that **almost one out of every three sites** (32.21%) disable this feature… and Apple (as of iOS 10) no longer allows web-developers to disable zooming—mobile safari simply [ignores the tag](https://archive.org/details/ios-10-beta-release-notes). All sites, no matter what, can be zoomed and scaled on newer Apple devices (**over 11%** of all web traffic worldwide)

**_Note:_** Browser usage stats from: [https://gs.statcounter.com/](https://gs.statcounter.com/)

```<insert graphic of metric 12_04>```

Alt text: Figure 2. Vertical grouped bar chart titled “Are zooming and scaling enabled?” measuring percentage data, ranging from 0 to 80 in increments of 20, vs. the device type, grouped into desktop and mobile. Desktop enabled: 75.46%; Desktop disabled 24.54%; Mobile enabled: 67.79%; Mobile disabled: 32.21%.

### Rotating pages

Mobile devices allow users to rotate them so your website can be viewed in the format users prefer. Users do not always keep the same orientation throughout a session however. When filling out forms, many rotate to landscape mode to use the larger keyboard. Or while browsing products, some enjoy the larger product images landscape mode gives them. Because of these types of use-cases, its very important not to rob the user of this built-in ability of mobile devices. And good news, we found virtually no sites disable this. **Only 87 total sites** (or 0.0016% of all sites) disable this feature. This is fantastic.

## Buttons and links

### Tap targets

We’re used to having precise devices like mice while on desktop, but the story is quite different on mobile. On mobile we engage with sites through these large and imprecise tools we call fingers. Because of how imprecise they can be, we constantly "fat finger" links and buttons—clicking things we never meant to.

Designing tap targets appropriately to mitigate this issue can be difficult because of how widely fingers vary in size. However, lots of research has now been done and there are safe standards both for: how large buttons should be, and how far apart they need to be separated. [See the standards here](https://developers.google.com/web/tools/lighthouse/audits/tap-targets) (or see the illustration below).

As of right now, only **34.43% of sites** have well sized tap-targets on their site. So we have quite a ways to go until "fat fingering" is a thing of the past.

![A diagram displaying two examples of difficult to tap buttons. The first example shows two buttons with no spacing between them; An example below it shows the same buttons but with the recommended amount of spacing between them (8px or 1-2mm). The second example shows a button far too small to tap; An example below it shows the same button enlarged to the recommended size of 40-48px (around 8mm). Image courtesy of LookZook](/static/images/2019/12_Mobile_Web/example-of-easy-to-hit-tap-targets-lookzook.png)

*Detailed information on the minimum size and spacing for buttons. Image courtesy of LookZook*

### Properly labeling our buttons

As designers, we love to use icons in our designs in place of text. They can make our sites look cleaner and more elegant. But while you and everyone on your team may know what these icons mean… many of your users will not (this is even the case with the infamous hamburger icon). If you don’t believe us, do some user-testing and see how often users get confused. You’ll be astounded.

This is why we recommend adding supporting text/labels to your buttons, to clear any of this possible confusion. As of right now, **over 28.59%** of sites have buttons having only a single icon with no supporting text.

**_Note:_** The reported number above is only a lower bound. During our analysis, we only included buttons using font icons with no supporting text. Many buttons now use SVGs instead of font-icons however, so in future runs we will be including them as well.

## Ease of filling out form inputs

From signing up for a new service, buying something online or even to receive notifications of new posts from a blog… form fields are an essential part of the web and something we use daily. Unfortunately, these fields are infamous for how much of a pain they are to fill out on mobile. Thankfully, in recent years browsers have given developers new tools to help ease the pain of completing these fields we know all too well. So let’s take a look at how much they’ve been getting used.

### New input types

In the past, `text` and `password` were some of the only types of inputs available to developers as it met almost all our needs on desktop. This is not the case for mobile devices. Mobile keyboards are incredibly small and a simple task, like entering an email address, requires users to switch between multiple keyboards (the standard keyboard and the special character keyboard for the @). Just entering a phone number can be difficult since the default keyboard’s numbers are tiny and prone to error.

Many new types have since been introduced ([see full list here](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#Form_%3Cinput%3E_types)). They allow developers to inform browsers what kind of data is expected, and browsers to provide customized keyboards specifically for these input types. For example: a type of `email` gives you an alphanumeric keyboard with an @ symbol, and a type of `tel` will display a numpad.

When analyzing sites containing an email input, only **56.42% **use `type="email”`. Similarly for phone inputs, `input=”tel”` is only used **36.7% **of the time, and other new input types have an even lower adoption rate.

Make sure to educate yourself and others on the large amount of input types available and double-check you don’t have any typos like these most common ones:

<table>
  <tr>
    <th>Type</th>
    <th># of pages with this typo / invalid type</th>
  </tr>
  <tr>
    <td>phone</td>
    <td>1917</td>
  </tr>
  <tr>
    <td>name</td>
    <td>1348</td>
  </tr>
  <tr>
    <td>textbox</td>
    <td>833</td>
  </tr>
</table>

_Most commonly used invalid input types_

### Enabling autocomplete for inputs

Allowing users to input information into fields more easily is great, but what about letting them fill them out in a single click? This is what the `autocomplete` input attribute aims to do. Users fill out tons of forms, often with the exact same information each time. Realizing this, browsers have begun to securely store this information so it can be used on future pages. All developers need to do, is use this `autocomplete` attribute to tell browsers what exact piece of information needs to be input, and the browser does the rest ([see here for more details](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/autocomplete)).

Currently, only **29.62%** of pages with input fields utilize this feature.

### Copy + Paste into password fields

Enabling users to copy + paste their passwords into your page allows them to use password managers. Password managers help users generate (and remember) strong passwords and fill them out automatically on sites. When analyzing sites to check how many disable this functionality we found **only 0.02%** do so.

While this is very encouraging, we suspect this number is far higher than we report because many pages host their registration and login forms on separate interior pages (e.g., /login/). During this analysis we only checked the homepages of these sites which means a large number of login/registration forms have not been analyzed.

## Conclusion

For over 13 years we’ve been treating the *mobile* web as an afterthought—a mere exception to desktop. But it’s time for this to change. Mobile is now *THE* web, and desktop is becoming legacy. There are now **4 billion** active smartphones in the world, covering 70% of all potential users… What about PCs? They currently sit at 1.6 billion, and account for less and less of the internet every month.

How well are we doing catering to mobile users? After looking through our research, even though **71.03% of sites** make some kind of effort to adjust their site for mobile... they’re falling well below the mark. Pages take forever to load and become usable thanks to an abuse of javascript; text is often impossible to read; engaging with sites via clicking links or buttons is error-prone and infuriating; and tons of great technologies invented to mitigate these problems (service workers, autocomplete, zooming, new image formats, etc) are barely being used at all.

The mobile web has now been around long enough for there to be an entire generation of kids where this is the only internet they’ve ever known. And what kind of experience are we giving them? We’re essentially taking them back to the dial-up era (good thing I hear AOL still sells those CDs providing 1000 hours of free internet access).

![A 1000 hour free-trial CD for America Online](/static/images/2019/12_Mobile_Web/america-online-1000-hours-free.jpg)

*1000 hours of America Online for free. Taken from [archive.org](https://archive.org/details/America_Online_1000_Hours_Free_for_45_Days_Version_7.0_Faster_Than_Ever_AM402R28)

**_Notes:_**

1. We defined sites making a mobile effort as those who adjust their designs for smaller screens. Or rather, those which have at least one CSS breakpoint at 600px or less.

2. Potential users, or the total addressable market, are those who are 15+ years old: [5.7 billion people](https://www.prb.org/international/geography/world).

3. [Desktop search](https://www.merkleinc.com/thought-leadership/digital-marketing-report) and [web traffic share](https://gs.statcounter.com/platform-market-share/desktop-mobile-tablet/worldwide/#monthly-201205-201909) has been on the decline for years

4. The total number of active smartphones was found by totaling the number of active Androids and iPhones (made public by Apple and Google), and a bit of math to account for Chinese internet-connected phones. [More info here](https://www.ben-evans.com/benedictevans/2019/5/28/the-end-of-mobile).

5. The 1.6 billion desktops is calculated by numbers made public by [Microsoft](https://web.archive.org/web/20181030132235/https://news.microsoft.com/bythenumbers/en/windowsdevices) and [Apple](https://web.archive.org/web/20190628161024/https://appleinsider.com/articles/18/10/30/apple-passes-100m-active-mac-milestone-thanks-to-high-numbers-of-new-users). It does not include linux PC users.

6. Of sites with images, only **4.69% utilize webp**
