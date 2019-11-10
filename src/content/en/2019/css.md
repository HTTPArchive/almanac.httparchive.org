---
part_number: I
chapter_number: 2
title: CSS
description: CSS chapter of the 2019 Web Almanac covering color, units, selectors, layout, typography and fonts, spacing, decoration, animation, media queries, and page level statistics.
authors: [una, argyleink]
reviewers: [meyerweb, huijing]
discuss: 1757
published: 2019-11-11T00:00:00.000Z
last_updated: 2019-11-07T21:46:11.000Z 
---

## Introduction
Cascading Style Sheets are used to paint, format, and layout web pages. Their capabilities span concepts as simple as text color to 3D perspective. It also has hooks to empower developers to handle varying screen sizes, viewing contexts, and printing. CSS helps developers wrangle the content and ensure it's adapting properly to the requesting user.

When describing CSS to those not familiar with web technology, it can be helpful to think of it as the language to paint the walls of the house; describing the size and position of windows and doors, as well as flourishing decorations such as wallpaper or plant life. The fun twist to that story, is that depending on the user walking through the house, a developer can adapt the house to that specific user's preferences or contexts!

In this chapter, we'll be inspecting, tallying, and extracting datums about how CSS is used across the web. The goal is to understand holistically what is being used, how they're using it, and to use that information to help inform ourselves (and you) how CSS is growing and being adopted. 

Ready to dig into the fascinating data!? Many of the following numbers may be small, but don't mistake them as insignificant! It can take many years for new things to saturate the web.

## Color

Color is an integral part of theming and styling on the web. We wanted to take a look at how people tend to use color.

### Color Types

Hex is the most popular way to describe color by far, with 93% usage, followed by RGB and then HSL. Interestingly, developers are taking full advantage of the alpha-transparency argument when it comes to these color types: HSLA and RGBA are far more popular than HSL and RGB, with almost double the usage! Even though the alpha-transparency was added later to the web spec, HSLA and RGBA are supported [as far back as IE9](https://caniuse.com/#feat=css3-colors), so you can go ahead and use them, too!

Percentage of types used
```<bar chart of 02_06>```

### Color Selection

There are [148 named CSS colors](https://www.w3.org/TR/css-color-4/#named-colors), not including the special values `transparent` and `currentcolor`. You can use these by their string name for more readible styling. The most popular named colors are `black` and `white`, unsurprisingly, followed by `red` and `blue`.

Top named colors
```<pie chart of 02_06b>```

Language is interestingly inferred via color as well. There are more people using the American-style "gray" than the British-style "grey" when writing code on the web. Almost every instance of [gray colors](https://www.rapidtables.com/web/color/gray-color.html) (`gray`, `lightgray`, `darkgray`, `slategray`, etc.) had nearly double the usage when spelled with an "a" instead of an "e". If gr[a/e]ys were combined, they would rank higher than blue, solidifying themselves in the #4 spot. This could be why `silver` is ranked higher than `grey` with an "e" in the charts!

### Color Count
We ran a fun query to see how many different font colors are used across the web. So this isn't total number of unique colors; rather, it's how many different colors are used just for text. The numbers in this chart are quite high, and from experience, we know that without CSS variables, spacing, sizes and colors can quickly get away from you and fragment into lots of tiny values across your styles. These numbers reflect a difficulty of style management, and we hope this helps create some perspective for you to bring back to your teams or projects. How can you reduce this number into a manageable and reasonable amount?
```<bar chart of 02_32>```

### Color Duplication
Well, we got curious here and wanted to inspect how many duplicate colors are present on a page. Without a tightly managed reusable class CSS system, duplicates are quite easy to create. Turns out, that on average, there's enough duplicates that it could be worth doing a pass to unify them with custom properties.
```<bar chart of 02_33>```

## Units

In CSS, there are a lot of different ways to achieve the same visual result -- using different unit types (i.e. `rem` vs `px` vs `em` vs `ch` or `cm` even!). So which unit types are most popular?

$ of sites using given units
```<side-by-side bar chart of 02_07b for desktop and mobile>```

### Length and Sizing

Unsurprisingly, `px` is the most used unit type, with about 95% of web pages using pixels in some form or another (this could be element sizing, font size, and so on). However, the `em` unit is almost as popular, with about 90% usage. This is over 2x more popular than the `rem` unit, which has only 40% frequency in web pages. If you're wondering what the difference is, `em` is based on the parent font-size, while `rem` is based on the base font size set to the page. It doesn't change per-component like `em` could, and thus allows for adjustment of all spacing evenly.

When it comes to units based on physical space, the `q` unit (1 quarter of a millimeter, or 1/40 of 1cm) is the most commonly used by far, with 22.46% on mobile and 15.13% on desktop. We knew about these types of units (e.q., `mm`, `in`, `cm`), which are specifically useful for print stylesheets, but didn't even know the `q` unit existed until this survey! Did you?

### Viewport-Based Units

We saw larger differences in unit types when it comes to mobile and desktop usage for viewport-based units. 36.8% of mobile sites use `vh` (viewport height), while only 31% of desktop sites do. We also found that `vh` is more common than `vw` (viewport width) by about 11%. `vmin` (viewport minimum) is more popular than `vmax` (viewport maximum), with about 8% usage of `vmin` on mobile while `vmax` is only used by 1% of websites.


### Custom Properties
Custom Properties are what many call CSS variables. They're more dynamic than a typical static variable though! They're very powerful and I feel as a community we're still discovering their potential. 

```<timeseries chart of 02_01d>```

**Figure 1:** Custom Properties growth shown since release

We felt like this was exciting information, since it shows healthy growth of one of our favorite CSS additions. They were available in all major browsers ~2016-2017, so it's fair to say they're fairly new. Many folks are still transitioning from their CSS preprocessor variables to CSS custom properties. We estimate it'll be a few more years until custom properties are the norm.

## Selectors

### ID vs Class selectors
CSS has a few ways to find elements on the page for styling, but let's put IDs and classes against each other to see which is more prevalent! I don't think the results are too surprising -- classes are more popular! 

```<pie chart of 02_08e-f>```

A nice follow up chart is this one, showing that classes take up ~93% of the selectors found in a stylesheet.

```<pie chart of 02_08be-f>```

### Attribute Selectors
CSS has some very powerful comparison selectors, and we were curious about their use on the web. These are selectors like `[target="_blank"]`, `[attribute^="value"]`, `[title~="rad"]`, `[attribute$="-rad"]` or `[attribute*="value"]`. Do you use them? Think they're used a lot? Let's compare how those are used with IDs and classes across the web.

```
<pie chart of 02_43h-l>
<pie chart of 02_44h-l>
```

Much more use with class names than IDs, which feels natural since a stylesheet usually has fewer ID selectors than class selectors, but still neat to see how uses of all these combinations. 

### Classes Per Element
We thought it would be fun to query all webpages to see an average number of classes put on elements! With the rise of OOCSS / atomic / functional CSS strategies which can compose ~10 classes on an element to achieve a design look, perhaps we'd see some interesting results. The query came back quite unexciting, with the average on mobile and desktop being 1 class per element. 
```<pie chart of 02_45d>```

## Layout

### Flexbox
Flexbox is a container style that directs and aligns its children; that is, it helps with layout in a constraint-based way. It had a quite rocky beginning on the web, as its spec went through 2-3 different quite drastic changes from 2010-2013. Fortunately, it settled and was implemented across all browsers by 2014. Given that history, it had a slow adoption rate, but it's been a few years since then! It's quite popular now and has many articles about it and how to leverage it, but it's new in comparison to other layout tactics.

```<pie chart of 02_013c>```

Quite the success story shown here, as nearly 50% of the web has flexbox usage in its stylesheets.

### Grid
Like flexbox, grid too went through a few spec alternations early on in its lifespan, but without changing implementations in publicly-deployed browsers. Microsoft had Grid in the first versions of Windows 8, as the primary layout engine for its horizontally scrolling design style. It was vetted there first, transitioned to the web, and then hardened by the other browsers until its final release in 2017. It had a very successful launch in that nearly all browsers released their implementations at the same time, so web developers just woke up one day to superb grid support. Today, at the end of 2019, grid still feels like a new kid on the block, as folks are still awakening to its power and capabilities.

```<pie chart of 02_014c>```

This chart shows just how little the web development community has exercised and explored their latest layout tool. I look forward to the eventual takeover of grid as the primary layout engine folks lean on when building a site. I love writing grid: I typically reach for it first, then dial my complexity back as I realize and iterate on layout. Curious what the rest of the world will do with this powerful CSS feature over the next few years. 

### Writing Modes
The Web and CSS are international platform features, and writing modes offer a way for HTML and CSS to indicate a users preferred reading/writing direction within our elements.

```<bar chart of 02_12e>```

## Typography

### Fonts Per Page
How many fonts are you using in your webpage or webapp? 0, 10? Average turned out to be 3!

```<bar chart of 02_22>```

### Popular Font Families
A natural follow up to the inquiry of total number of fonts per page, is: what fonts are they!? Designers, tune in, because you'll now get to see if your choices are in line with what's popular or not.

```<bar chart of 02_23>```

Open Sans is a huge winner here, with presence on nearly 1 in 4 pages of the web. We've definitely used Open Sans in projects at agencies. 

### Font Sizes
This is a fun one, because if you asked a user how many font sizes they feel are on a page, they'd generally return a number of 5 or definitely less than 10. Is that reality though? Even in a design system, how many font sizes are there? We queried the web and found the average to be 40 on mobile and 38 on desktop. Might be time to really think hard about custom properties or creating some reusable classes to help you distribute your type ramp.

```<bar chart of 02_36>```

## Spacing

### Margins
Margin is the space outside of elements, like the space you demand when you push your arms out from yourself. This often looks like the spacing between elements, but is not limited to that effect. In a website or app, spacing plays a huge role in UX and design. Let's see how much margin spacing code goes into a stylesheet, shall we?

```<bar chart of 02_40b-f>```

Quite a lot, it seems! An average of 96 distinct margins on desktop and 104 on mobile. That makes for a lot of unique spacing moments in your design. Curious how many margins you have in your site? How can we make all this whitespace more manageable?

### Logical Properties
We estimate that the hegemony of `margin-left` and `padding-top` is of limited duration, soon to be supplemented by their writing direction agnostic, successive, logical property syntax. While we're optimistic, current usage is quite low at 0.67% usage on desktop pages. To us, this feels like a habit change we'll need to develop as an industry, while hopefully training new developers to use the new syntax.

```<bar chart of 02_05d>```

### Z-Index
Vertical layering, or stacking, can be managed with `z-index` in CSS. We were curious how many different values folks use in their sites. The range of what `z-index` accepts is theoretically infinite, bounded only by a browser's variable size limitations. Are all those stack positions used? Let's see!

```<bar chart of 02_37>```

### Z-Index Popular Values
From our work experience, any number of 9's seemed to be the most popular choice. Even though we taught ourselves to use the lowest number possible, that's not the communal norm. So what is then!? If folks need things on top, what are the most popular `z-index` numbers to pass in? Put your drink down -- this one is funny enough you might lose it.

```<scatter chart of 02_38>```

## Decoration

### Filters
Filters are a fun and great way to modify the pixels the browser intends to draw to the screen. It's a post-processing effect that is done against a flat version of the element/node/layer it's applied to. Photoshop made them easy to use, then Instagram made them accessible to the masses through bespoke, stylized combinations. They've been around since ~2012, there are 10 of them, and they can be combined to create unique effects.

We were excited to see that 78% of stylesheets contain the `filter` property! That number was also so high it seemed a little fishy, so we dug in and sought to explain the high number. Because let's be honest, filters are neat, but they don't make it into all of our applications and projects. Unless!

Upon further investigation, we discoverd [FontAwesome](https://fontawesome.com)'s stylesheet comes with some `filter` usage, as well as a [YouTube](https://youtube.com) embed. Therefore, we believe `filter` snuck in the back door by piggybacking onto a couple very popular stylesheets. We also believe that `-ms-filter` presence could have been included as well, contributing to the high percent of use.

```<pie chart of 02_03d>```

### Blend Modes
Blend Modes are similar to filters in that they are a post-processing effect that's run against a flat version of its target elements, but is unique in that it's concerned with pixel convergence. Said another way, blend modes are how 2 pixels _should_ impact each other when they overlap. Which element is on the top or the bottom will affect the way the blend mode manipulates the pixels. There are 16 blend modes -- let's see which ones are the most popular.

TODO: chart is pending resolution of [this request](https://docs.google.com/a/google.com/spreadsheets/d/1uFlkuSRetjBNEhGKWpkrXo4eEIsgYelxY-qR9Pd7QpM/edit?disco=AAAADjuwTws)
```<bar chart of 02_04be>```

Overall, usage of blend modes is much lower than of filters, but is still enough to be considered moderately used.

```<pie chart of 02_04d>```

## Animation

### Transitions
CSS has this awesome interpolation power that can be simply used by just writing a single rule on how to transition those values. If you're using CSS to manage states in your app, how often are you employing transitions to do the task? Let's query the web!

```<bar chart of 02_41b-f>```

That's pretty good! We did see `animate.css` as a popular library to include, which brings in a ton of transition animations, but it's still nice to see folks are considering transitioning their UIs. 

### Keyframe Animations
CSS keyframe animations are a great solution for your more complex animations or transitions. They allow you to be more explicit which provides higher control over the effects. They can be small, like 1 keyframe effect, or be large with many many keyframe effects composing into a robust animation. We were curious the average of keyframe animations per page, which turned out to be much less than CSS transitions.

```<bar chart of 02_42b-f>```

## Media Queries
Media queries let CSS hook into various system-level variables in order to adapt appropriately for the visiting user. Some of these queries could handle print styles, projector screen styles, and viewport/screen size. For a long time, media queries were primarily leveraged for their viewport knowledge. Designers and developers could adapt their layouts based on small screens, large screens, an so forth. Later, the web started bringing more and more capabilities and queries, meaning media queries can now manage accessibility features on top of viewport features. 

### Number of Media Queries Per Page
A good place to start with Media Queries, is just about how many are used per page? How many different moments or contexts does the average page feel they want to respond to?

```<bar chart of 02_39>```

### Popular Media Query Breakpoint Sizes
For viewport media queries, any type of CSS unit can be passed into the query expression for evaluation. In earlier days, folks would pass `em`'s and `px`'s into the query, but more units were added over time, making us very curious about what types of sizes were commonly found across the web. We assume most media queries will follow popular device sizes, but instead of assuming, we asked for a query!

```<bar chart of 02_015e>```

The chart shows that part of our assumptions were correct -- there's certainly a high amount of phone specific sizes in there, but there's also some that aren't. It's interesting also how it's very pixel dominant, with a few trickling entries using `em`'s.

### Portrait vs Landscape Usage
The most popular query value from the popular breakpoint sizes looks to be `768px`, which made us curious. Was this value primarily used to switch to a portrait layout, since it could be based on an assumption that `768px` represents the typical mobile portrait viewport? So we ran a follow up query to see the popularity of using the portrait and landscape modes:

```<bar chart of 02_015bf-g>```

Interestingly, `portrait` isn't used very much, whereas `landscape` is used much more. We can only assume that `768px` has been reliable enough as the portrait layout case that it's reached for much less. We also assume that folks on a desktop computer, testing their work, can't trigger portrait to see their mobile layout as easily as they can just squish the browser. Hard to tell, but the data is fascinating.  

### Most Popular Unit Types
In the width and height media queries we've seen so far, pixels look like the dominant unit of choice for developers looking to adapt their UI to viewports. We wanted to exclusively query this though, and really take a look at the types of units folks use. Here's what was discovered.

```<bar chart of 02_017f-h>```

### min-width vs max-width
Wen folks write a media query, are they typically checking for a viewport that's over or under a specific range, OR both, checking if it's between a range of sizes? Let's ask the web!

```<bar chart of 02_016f-h>```

No clear winners here; max- and min- are nearly equally used. 

### Print & Speech
Websites feel like digital paper, right? As users, it's generally known that you can just hit print from your browser and turn that digital content into physical content. A website isn't required to change itself for that use case, but it can if it wants to! Lesser known is the ability to adjust your website in the use case of it being read by a tool or robot. So just how often are these features taken advantage of?

```<bar chart of 02_018h-j>```

## Page Level

### Stylesheets
How many stylesheets do you reference from your home page? How many from your apps? Do you serve more or less to mobile vs desktop? Here's a chart of everyone else!

```<bar chart of 02_019>```

### Stylesheet Names
What do you name your stylesheets? Have you been consistent throughout your career? Have you slowly converged or consistently diverged? This chart shows a small glimpse into library popularity, but also a large glimpse into popular names of CSS files.

```<bar chart of 02_020>```

Look at all those creative file names 😂: style, styles, main, default, all.  One stood out though, do you see it? `BfWyFJ2Rl5s.css` takes the #9 and the #10 spot for most popular. We went researching it a bit and our best guess is that it's related to Facebook like buttons. Do you know what that file is? Send Una or Adam an email, because we'd love to hear the story. 

### Stylesheet Size
How big are these stylesheets? Is our CSS size something to worry about? Judging by this data, our CSS is not a main offender for page bloat.

```<bar chart of 02_24>```

### Libraries
It's common, popular, convenient and powerful to reach for a CSS library to kick start a new project. While you may not be such a dev to reach for a library, we've queried the web in 2019 to see which are leading the pack. If the results astound you, like they did us, I think it's an interesting clue to just how small of a developer bubble we can live in. Things can feel massively popular, but when the web in inquired, reality is a bit different.

```<bar chart of 02_010e>```

This chart makes me think that Bootstrap is a strong skill to have for getting a job. Look at all the opportunity there is to help! It's also worth noting that this is a positive signal chart only: the math doesn't add up to 100% because not all sites are using a CSS framework. A little bit over half of all sites *are not* using a CSS framework. Very interesting, no!?

### Reset Utilities
CSS reset utilities intend to normalize or create a baseline for native web elements. In case you didn't know, each browser serves its own stylesheet for all HTML elements, and each browser gets to make their own unique decisions about how those elements look or behave. Reset utilities have looked at these files, found their common ground (or not), and ironed out any differences so you as a developer can style in one browser and have reasonable confidence it will look the same in another.

So let's take a peek at how many sites are using one! Their existence seems quite reasonable, so how many folks agree with their tactics and use them in their sites?

```<bar chart of 02_011e>```

Turns out that about 1/3 of the web is using [normalize.css](https://necolas.github.io/normalize.css), which could be considered a more gentle approach to the task then a reset is. We looked a little deeper, and it turns out that Bootstrap.css includes normalize.css, which likely accounts for a massive amount of its usage. It's worth noting as well that normalize.css has more adoption than Bootstrap, so there are plenty of folks using it on its own. 

### @supports & @import
CSS `@supports` is a way for the browser to check whether a particular property-value combination is parsed as valid, and then apply styles if the check returns as true.

```<bar chart of 02_02f>```

**Figure 2:** @supports usage across mobile and desktop

Considering `@supports` was implemented across most browsers in 2013, it's not too surprising to see a high amount of usage and adoption. We're impressed at the mindfulness of developers here -- this is considerate coding! 29% of all websites are checking for some display related support before using it. 👍

An interesting follow up to this is, that there's more usage of `@supports` than `@imports`!

```<bar chart of 02_02e>```

We did not expect that! `@import` has been in browsers since ~1994.

## Conclusion
There is so much more here to datamine! Many of the results surprised us, and we can only hope that they've surprised you as well. This surprising data set made the summarizing very fun, and left us with lots of clues and trails to investigate if we want to hunt down the reasons *why* some of the results are the way they are. 

Which results did you find the most alarming?
Which results make you head to your codebase for a quick query?

We felt the biggest takeaway from these results is that custom properties offer the most bang for your buck in terms of performance, DRYness, and scalability of your stylesheets. We look forward to scrubbing the internet's stylesheets again, hunting for new datums and provocative chart treats. Reach out to [@una](https://twitter.com/una) or [@argyleink](https://twitter.com/argyleink) with your queries, questions and assertions. We'd love to hear about them. 
