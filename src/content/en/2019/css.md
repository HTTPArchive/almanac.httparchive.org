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

### Color Types
<pie chart of 02_06>




## Units

### Custom Properties
Custom Properties are what many call CSS variables. They're more dynamic than a typical static variable though! They're very powerful and I feel as a community we're still discovering their potential. 

<timeseries chart of 02_01d>

**Figure 1:** Custom Properties growth shown since release

We felt like this was exciting information, since it shows healthy grow of one of our favorite CSS additions. They were available in all major browsers ~2016-2017, so it's fair to say they're fairly new. Many folks are still transitioning from their CSS preprocessor variables to CSS custom properties. We estimate it'll be a few more years until custom properties are the norm.





## Selectors




## Layout




## Fonts




## Spacing




## Decoration

### Filters

<pie chart of 02_01d>

### Blend Modes




## Animation




## Performance




## Media Queries

### @supports & @import
CSS @supports is a way for CSS to check whether or not something is supported before employing it's usage.

<bar chart of 02_02f>

**Figure 2:** @supports usage across mobile and desktop

Considering @supports was implemented across most browsers in 2013, it's not too surprising to see a high amount of usage and adoption. We're impressed at the mindfulness of developers here. This is considerate coding! 29% of all websites are checking for some display related support before using it. 👍

An interesting follow up to this is, that there's more usage of @supports then @imports!

<bar chart of 02_02e>

We did not expect that! @import has been in browsers since ~2007. 




## Page Level






## Logical Properties


