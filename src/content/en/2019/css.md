---
part_number: I
chapter_number: 2
title: CSS
authors: [una, argyleink]
reviewers: [meyerweb, huijing]
---

## Introduction
Cascading Style Sheets are used to paint, format, and layout web pages. Their capabilities span concepts as simple as text color to 3D perspective. It also has hooks to empower developers to handle varying screen sizes, viewing contexts, and printing. CSS helps developers wrangle the content and ensure it's adapting properly the requesting user.

When describing CSS to those not familiar with web technology, it can be helpful to think of it as the language to paint the walls of the house, describe the size and position of windows and doors, as well as flourishing decorations such as wallpaper or plant life. The fun twist to that story, is that depending on who is walking through the house, a developer can adapt to their preferences or contexts!

In this chapter, we'll be inspecting, tallying, and extracting datums about how CSS is used across the web. The goal is to understand holistically what is being used, how they're using it, and to use that information to help inform ourselves (and you) how CSS is growing and being adopted. 

Ready to dig into the fascinating data!? Many of the following numbers may be small, but don't mistake them as insignificant! It can take many years for new things to saturate the web.





## Color

Color is an integral part of theming and styling on the web. We wanted to take a look at how people tend to use color.

### Color Types

Hex is the most popular way to describe color by far (with 93% usage), followed by RGB and then HSL. Interestingly, developers are taking full advantage of the alpha-transparency argument when it comes to these color types. HSLA and RGBA are far more popular than HSL and RGB, with almost double the usage! Even though the alpha-transparency was added later to the web spec, HSLA and RGBA are supported [as far back as IE9](https://caniuse.com/#feat=css3-colors), so you can go ahead and use them, too!

Percentage of types used
<bar chart of 02_06>

### Color Selection

There are [148 named CSS colors](https://www.w3.org/TR/css-color-4/#named-colors), not including the special values `transparent` and `currentcolor`. You can use these by their string name for more readible styling. The most popular named colors are black and white, unsurprisingly, followed by red and blue.

Language is interestingly inferred via color as well. There are more people using the American-style "gray" than the British-style "grey" when writing code on the web. Almost every instance of [gray colors](https://www.rapidtables.com/web/color/gray-color.html) (gray, lightgray, darkgray, slategray, etc.) had nearly double the usage when spelled with an "a" instead of an "e". If gr[a/e]ys were combined, they would rank higher than blue, solidifying themselves in the #4 spot. This could be why silver is ranked higher than grey with an "e" in the charts!

Top named colors
<pie chart of 02_06b>

## Units

### Length

$ of sites using given units
<pie chart of 02_07b>


### Custom Properties
Custom Properties are what many call CSS variables. They're more dynamic than a typical static variable though! They're very powerful and I feel as a community we're still discovering their potential. 

<timeseries chart of 02_01d>

**Figure 1:** Custom Properties growth shown since release

We felt like this was exciting information, since it shows healthy grow of one of our favorite CSS additions. They were available in all major browsers ~2016-2017, so it's fair to say they're fairly new. Many folks are still transitioning from their CSS preprocessor variables to CSS custom properties. We estimate it'll be a few more years until custom properties are the norm.




## Selectors

### ID vs Class selectors
ID and class selector usage
<pie chart of 02_08f>



## Layout

### Flexbox
% of sites using flexbox
<pie chart of 02_013c>

### Grid
% of sites using grid
<pie chart of 02_014c>

### Writing Direction
Pages using dir:ltr
<pie chart of 02_012>



## Fonts




## Spacing

### Logical Properties
% of sites using logical props atm
<bar chart of 02_05d>


## Decoration

### Filters
$ of sites using filters
<pie chart of 02_03d>


### Blend Modes

Presence in stylesheets
<pie chart of 02_04d>

Which are used?
<bar chart of 02_04be>


## Animation




## Performance




## Media Queries

### Popular Media Query Adaption Sizes
Percent of viewport lengths used
<bar chart of 02_015e>

### Portrait vs Landscape Usage
<bar chart of 02_015bf>

### Print
<bar chart of 02_018h>

### @supports & @import
CSS @supports is a way for CSS to check whether or not something is supported before employing it's usage.

<bar chart of 02_02f>

**Figure 2:** @supports usage across mobile and desktop

Considering @supports was implemented across most browsers in 2013, it's not too surprising to see a high amount of usage and adoption. We're impressed at the mindfulness of developers here. This is considerate coding! 29% of all websites are checking for some display related support before using it. 👍

An interesting follow up to this is, that there's more usage of @supports then @imports!

<bar chart of 02_02e>

We did not expect that! @import has been in browsers since ~2007. 




## Page Level

### Stylesheets
Number of stylesheets per page
<bar chart of 02_019>

### Stylesheet Names
Common stylesheet names
<bar chart of 02_020>

### Libraries
% of sites using given libs
<bar chart of 02_010e>

### Reset Utilities
% of sites using given resets
<bar chart of 02_011e>

