---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Page Weight
description: Page Weight chapter of the 2019 Web Almanac covering why page weight matters, bandwidth, complex pages, page weight over time, page requests, and file formats.
hero_alt: Hero image of Web Almanac characters using a set of scales to weigh a web page against variuos boxes labelled with various different kilobytes.
authors: [tammyeverts, khempenius]
reviewers: [paulcalvano]
analysts: [khempenius]
editors: [foxdavidj]
translators: []
discuss: 1773
results: https://docs.google.com/spreadsheets/d/1nWOo8efqDgzmA0wt1ipplziKhlReAxnVCW1HkjuFAxU/
tammyeverts_bio: Tammy Everts has spent more than two decades studying usability and UX. For the past ten years, she's focused on the intersection of UX with web performance and business. She is CXO at <a hreflang="en" href="https://speedcurve.com/">SpeedCurve</a>, co-chair of the <a hreflang="en" href="https://perfnow.nl/">performance.now() conference</a>, and author of the O'Reilly book <em><a hreflang="en" href="http://shop.oreilly.com/product/0636920041450.do">Time Is Money_bio&colon; The Business Value of Performance</a></em>.
khempenius_bio: Katie Hempenius is an engineer on the Chrome team where she works on making the web faster.
featured_quote: The common argument as to why page size doesn't matter anymore is that, thanks to high-speed internet and our souped-up devices, we can serve massive, complex (and massively complex) pages to the general population. This assumption works fine, as long as you're okay with ignoring the vast swathe of internet users who don't have access to said high-speed internet and souped-up devices.
featured_stat_1: 20%
featured_stat_label_1: Sites sending more than 6 MB of Data
featured_stat_2: 434 KB
featured_stat_label_2: Increase in median desktop size in last year
featured_stat_3: 69
featured_stat_label_3: Median requests per home page
---

## Introduction

The median web page is around 1900 KB in size and contains 74 requests. That doesn't sound too bad, right?

Here's the issue with medians: they mask problems. By definition, they focus only on the middle of the distribution. We need to consider percentiles at both extremes to get an understanding of the bigger picture.

Looking at the 90th percentile exposes the unpleasant stuff. Roughly 10% of the pages we're pushing at the unsuspecting public are in excess of 6 MB and contain 179 requests. This is, frankly, terrible. If this doesn't seem terrible to you, then you definitely need to read this chapter.

### Myth: Page size doesn't matter

The common argument as to why page size doesn't matter anymore is that, thanks to high-speed internet and our souped-up devices, we can serve massive, complex (and massively complex) pages to the general population. This assumption works fine, as long as you're okay with ignoring the vast swathe of internet users who don't have access to said high-speed internet and souped-up devices.

Yes, you can build large robust pages that feel fast… to some users. But you should care about page bloat in terms of how it affects all your users, especially mobile-only users who deal with bandwidth constraints or data limits.

<p class="note" data-markdown="1">Check out Tim Kadlec's fascinating online calculator, <a hreflang="en" href="https://whatdoesmysitecost.com/">What Does My Site Cost?</a>, which calculates the cost—in dollars and Gross National Income per capita—of your pages in countries around the world. It's an eye-opener. For instance, Amazon's home page, which at the time of writing weighs 2.79 MB, costs 1.89% of the daily per capita GNI of Mauritania. How global is the world wide web when people in some parts of the world would have to give up a day's wages just to visit a few dozen pages?</p>

### More bandwidth isn't a magic bullet for web performance

Even if more people had access to better devices and cheaper connections, that wouldn't be a complete solution. Double the bandwidth doesn't mean twice as fast. In fact, <a hreflang="en" href="https://developer.akamai.com/blog/2015/06/09/heres-why-more-bandwidth-isnt-magic-bullet-web-performance">it has been demonstrated</a> that increasing bandwidth by up to 1,233% only made pages 55% faster.

The problem is latency. Most of our networking protocols require a lot of round-trips, and each of those round trips imposes a latency penalty. For as long as latency continues to be a performance problem (which is to say, for the foreseeable future), the major performance culprit will continue to be that a typical web page today contains a hundred or so assets hosted on dozens of different servers. Many of these assets are unoptimized, unmeasured, unmonitored—and therefore unpredictable.

### What types of assets does the HTTP Archive track, and how much do they matter?

Here's a quick glossary of the page composition metrics that the HTTP Archive tracks, and how much they matter in terms of performance and user experience:

- The **total size** is the total weight in bytes of the page. It matters especially to mobile users who have limited and/or metered data.

- **HTML** is typically the smallest resource on the page. Its performance risk is negligible.

- Unoptimized **images** are often the greatest contributor to page bloat. Looking at the 90th percentile of the distribution of page weight, images account for a whopping 5.2 MB of a roughly 7 MB page. In other words, images comprise almost 75% of the total page weight. And if that already wasn't enough, the number of images on a page has been linked to lower conversion rates on retail sites. (More on that later.)

- **JavaScript** matters. A page can have a relatively low JavaScript weight but still suffer from JavaScript-inflicted performance problems. Even a single 100 KB third-party script can wreak havoc with your page. The more scripts on your page, the greater the risk.

  It's not enough to focus solely on blocking JavaScript. It's possible for your pages to contain zero blocking resources and still have less-than-optimal performance because of how your JavaScript is rendered. That's why it's so important to understand CPU usage on your pages, because JavaScript consumes more CPU than all other browser activities combined. While JavaScript blocks the CPU, the browser can't respond to user input. This creates what's commonly called "jank": that annoying feeling of jittery, unstable page rendering.

- **CSS** is an incredible boon for modern web pages. It solves a myriad of design problems, from browser compatibility to design maintenance and updating. Without CSS, we wouldn't have great things like responsive design. But, like JavaScript, CSS doesn't have to be bulky to cause problems. Poorly executed stylesheets can create a host of performance problems, ranging from stylesheets taking too long to download and parse, to improperly placed stylesheets that block the rest of the page from rendering. And, similarly to JavaScript, more CSS files equals more potential trouble.

### Bigger, complex pages can be bad for your business

Let's assume you're not a heartless monster who doesn't care about your site's visitors. But if you are, you should know that serving bigger, more complex pages hurts you, too. That was one of the findings of a <a hreflang="en" href="https://www.thinkwithgoogle.com/marketing-resources/experience-design/mobile-page-speed-load-time/">Google-led machine learning study</a> that gathered over a million beacons' worth of real user data from retail sites.

There were three really important takeaways from this research:

1. **The total number of elements on a page was the greatest predictor of conversions.** Hopefully this doesn't come as a huge surprise to you, given what we've just covered about the performance risks imposed by the various assets that make up a modern web page.

2. **The number of images on a page was the second greatest predictor of conversions.** Sessions in which users converted had 38% fewer images than in sessions that didn't convert.

{{ figure_markup(
  image="ch18_fig1_conversion_difference.png",
  caption="Converted sessions vs non-converted sessions.",
  description="Chart showing 19 converted sessions vs. 31 non-converted sessions",
  width=600,
  height=432
  )
}}

3. **Sessions with more scripts were less likely to convert.** What's really fascinating about this chart isn't just the sharp drop-off in conversion probability after about 240 scripts. It's the long tail that demonstrates how many retail sessions contained up to 1,440 scripts!

{{ figure_markup(
  image="ch18_fig2_conversion_graph.jpg",
  caption="Conversion rate dropping off as scripts increase.",
  description="Chart showing conversion rate climbing up until 80 scripts, and then dropping off as scripts increase up to 1440 scripts.",
  width=600,
  height=336
  )
}}

Now that we've covered why page size and complexity matter, let's get into some juicy HTTP Archive stats so we can better understand the current state of the web and the impact of page bloat.

## Analysis

The statistics in this section are all based on the _transfer size_ of a page and its resources. Not all resources on the web are compressed before sending, but if they are, this analysis uses the compressed size.

### Page weight

Roughly speaking, mobile sites are about 10% smaller than their desktop counterparts. The majority of the difference is due to mobile sites loading fewer image bytes than their desktop counterparts.

#### Mobile

<figure>
  <table>
    <tr>
      <th>Percentile</th>
      <th>Total (KB)</th>
      <th>HTML (KB)</th>
      <th>JS (KB)</th>
      <th>CSS (KB)</th>
      <th>Image (KB)</th>
      <th>Document (KB)</th>
    </tr>
    <tr>
      <td>90</td>
      <td>6226</td>
      <td>107</td>
      <td>1060</td>
      <td>234</td>
      <td>4746</td>
      <td>49</td>
    </tr>
    <tr>
      <td>75</td>
      <td>3431</td>
      <td>56</td>
      <td>668</td>
      <td>122</td>
      <td>2270</td>
      <td>25</td>
    </tr>
    <tr>
      <td>50</td>
      <td>1745</td>
      <td>26</td>
      <td>360</td>
      <td>56</td>
      <td>893</td>
      <td>13</td>
    </tr>
    <tr>
      <td>25</td>
      <td>800</td>
      <td>11</td>
      <td>164</td>
      <td>22</td>
      <td>266</td>
      <td>7</td>
    </tr>
    <tr>
      <td>10</td>
      <td>318</td>
      <td>6</td>
      <td>65</td>
      <td>5</td>
      <td>59</td>
      <td>4</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Page weight on mobile broken down by resource type.") }}</figcaption>
</figure>

#### Desktop

<figure>
  <table>
    <tr>
      <th>Percentile</th>
      <th>Total (KB)</th>
      <th>HTML (KB)</th>
      <th>JS (KB)</th>
      <th>CSS (KB)</th>
      <th>Image (KB)</th>
      <th>Document (KB)</th>
    </tr>
    <tr>
      <td>90</td>
      <td>6945</td>
      <td>110</td>
      <td>1131</td>
      <td>240</td>
      <td>5220</td>
      <td>52</td>
    </tr>
    <tr>
      <td>75</td>
      <td>3774</td>
      <td>58</td>
      <td>721</td>
      <td>129</td>
      <td>2434</td>
      <td>26</td>
    </tr>
    <tr>
      <td>50</td>
      <td>1934</td>
      <td>27</td>
      <td>391</td>
      <td>62</td>
      <td>983</td>
      <td>14</td>
    </tr>
    <tr>
      <td>25</td>
      <td>924</td>
      <td>12</td>
      <td>186</td>
      <td>26</td>
      <td>319</td>
      <td>8</td>
    </tr>
    <tr>
      <td>10</td>
      <td>397</td>
      <td>6</td>
      <td>76</td>
      <td>8</td>
      <td>78</td>
      <td>4</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Page weight on desktop broken down by resource type.") }}</figcaption>
</figure>

### Page weight over time

Over the past year the median size of a desktop site increased by 434 KB, and the median size of a mobile site increased by 179 KB. Images are overwhelmingly driving this increase.

#### Mobile

<figure>
  <table>
    <tr>
      <th>Percentile</th>
      <th>Total (KB)</th>
      <th>HTML (KB)</th>
      <th>JS (KB)</th>
      <th>CSS (KB)</th>
      <th>Image (KB)</th>
      <th>Document (KB)</th>
    </tr>
    <tr>
      <td>90</td>
      <td>+376</td>
      <td>-50</td>
      <td>+46</td>
      <td>+36</td>
      <td>+648</td>
      <td>+2</td>
    </tr>
    <tr>
      <td>75</td>
      <td>+304</td>
      <td>-7</td>
      <td>+34</td>
      <td>+21</td>
      <td>+281</td>
      <td>0</td>
    </tr>
    <tr>
      <td>50</td>
      <td>+179</td>
      <td>-1</td>
      <td>+27</td>
      <td>+10</td>
      <td>+106</td>
      <td>0</td>
    </tr>
    <tr>
      <td>25</td>
      <td>+110</td>
      <td>-1</td>
      <td>+16</td>
      <td>+5</td>
      <td>+36</td>
      <td>0</td>
    </tr>
    <tr>
      <td>10</td>
      <td>+72</td>
      <td>0</td>
      <td>+13</td>
      <td>+2</td>
      <td>+20</td>
      <td>+1</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Change in mobile page weight since 2018.") }}</figcaption>
</figure>

#### Desktop

<figure>
  <table>
    <tr>
      <th>Percentile</th>
      <th>Total (KB)</th>
      <th>HTML (KB)</th>
      <th>JS (KB)</th>
      <th>CSS (KB)</th>
      <th>Image (KB)</th>
      <th>Document (KB)</th>
    </tr>
    <tr>
      <td>90</td>
      <td>+1106</td>
      <td>-75</td>
      <td>+22</td>
      <td>+45</td>
      <td>+1291</td>
      <td>+5</td>
    </tr>
    <tr>
      <td>75</td>
      <td>+795</td>
      <td>-12</td>
      <td>+9</td>
      <td>+32</td>
      <td>+686</td>
      <td>+1</td>
    </tr>
    <tr>
      <td>50</td>
      <td>+434</td>
      <td>-1</td>
      <td>+10</td>
      <td>+15</td>
      <td>+336</td>
      <td>0</td>
    </tr>
    <tr>
      <td>25</td>
      <td>+237</td>
      <td>0</td>
      <td>+12</td>
      <td>+7</td>
      <td>+138</td>
      <td>0</td>
    </tr>
    <tr>
      <td>10</td>
      <td>+120</td>
      <td>0</td>
      <td>+10</td>
      <td>+2</td>
      <td>+39</td>
      <td>+1</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Change in desktop page weight since 2018.") }}</figcaption>
</figure>

For a longer-term perspective on how page weight has changed over time, check out <a hreflang="en" href="https://httparchive.org/reports/page-weight#bytesTotal">this timeseries graph</a> from HTTP Archive. Median page size has grown at a fairly constant rate since the HTTP Archive started tracking this metric in November 2010 and the increase in page weight observed over the past year is consistent with this.

### Page requests

The median desktop page makes 74 requests, and the median mobile page makes 69. Images and JavaScript account for the majority of these requests.  There was no significant change in the quantity or distribution of requests over the last year.

#### Mobile

<figure>
  <table>
    <tr>
      <th>Percentile</th>
      <th>Total</th>
      <th>HTML</th>
      <th>JS</th>
      <th>CSS</th>
      <th>Image</th>
      <th>Document</th>
    </tr>
    <tr>
      <td>90</td>
      <td>168</td>
      <td>15</td>
      <td>52</td>
      <td>20</td>
      <td>79</td>
      <td>7</td>
    </tr>
    <tr>
      <td>75</td>
      <td>111</td>
      <td>7</td>
      <td>32</td>
      <td>12</td>
      <td>49</td>
      <td>2</td>
    </tr>
    <tr>
      <td>50</td>
      <td>69</td>
      <td>3</td>
      <td>18</td>
      <td>6</td>
      <td>28</td>
      <td>0</td>
    </tr>
    <tr>
      <td>25</td>
      <td>40</td>
      <td>2</td>
      <td>9</td>
      <td>3</td>
      <td>15</td>
      <td>0</td>
    </tr>
    <tr>
      <td>10</td>
      <td>22</td>
      <td>1</td>
      <td>4</td>
      <td>1</td>
      <td>7</td>
      <td>0</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Mobile page requests broken down by resource type.") }}</figcaption>
</figure>

#### Desktop

<figure>
  <table>
    <tr>
      <th>Percentile</th>
      <th>Total</th>
      <th>HTML</th>
      <th>JS</th>
      <th>CSS</th>
      <th>Image</th>
      <th>Document</th>
    </tr>
    <tr>
      <td>90</td>
      <td>179</td>
      <td>14</td>
      <td>53</td>
      <td>20</td>
      <td>90</td>
      <td>6</td>
    </tr>
    <tr>
      <td>75</td>
      <td>118</td>
      <td>7</td>
      <td>33</td>
      <td>12</td>
      <td>54</td>
      <td>2</td>
    </tr>
    <tr>
      <td>50</td>
      <td>74</td>
      <td>4</td>
      <td>19</td>
      <td>6</td>
      <td>31</td>
      <td>0</td>
    </tr>
    <tr>
      <td>25</td>
      <td>44</td>
      <td>2</td>
      <td>10</td>
      <td>3</td>
      <td>16</td>
      <td>0</td>
    </tr>
    <tr>
      <td>10</td>
      <td>24</td>
      <td>1</td>
      <td>4</td>
      <td>1</td>
      <td>7</td>
      <td>0</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Desktop page requests broken down by resource type.") }}</figcaption>
</figure>

### File formats

The preceding analysis has focused on analyzing page weight through the lens of resource types. However, in the case of images and media, it's possible to dive a level deeper and look at the differences in resource sizes between specific file formats.

#### File size by image format (mobile)

<figure>
  <table>
    <tr>
      <th>Percentile</th>
      <th>GIF (KB)</th>
      <th>ICO (KB)</th>
      <th>JPG (KB)</th>
      <th>PNG (KB)</th>
      <th>SVG (KB)</th>
      <th>WEBP (KB)</th>
    </tr>
    <tr>
      <td>10</td>
      <td>0</td>
      <td>0</td>
      <td>3.08</td>
      <td>0.37</td>
      <td>0.25</td>
      <td>2.54</td>
    </tr>
    <tr>
      <td>25</td>
      <td>0.03</td>
      <td>0.26</td>
      <td>7.96</td>
      <td>1.14</td>
      <td>0.43</td>
      <td>4.89</td>
    <tr>
      <td>50</td>
      <td>0.04</td>
      <td>1.12</td>
      <td>21</td>
      <td>4.31</td>
      <td>0.88</td>
      <td>13</td>
    </tr>
    <tr>
      <td>75</td>
      <td>0.06</td>
      <td>2.72</td>
      <td>63</td>
      <td>22</td>
      <td>2.41</td>
      <td>33</td>
    </tr>
    <tr>
      <td>90</td>
      <td>2.65</td>
      <td>13</td>
      <td>155</td>
      <td>90</td>
      <td>7.91</td>
      <td>78</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Images file sizes on mobile broken down by image format.") }}</figcaption>
</figure>

Some of these results, particularly those for GIFs, are really surprising. If GIFs are so small, then why are they being replaced by formats like JPG, PNG, and WEBP?

The data above obscures the fact that the vast majority of GIFs on the web are actually tiny 1x1 pixels. These pixels are typically used as "tracking pixels", but can also be used as a hack to generate various CSS effects. While these 1x1 pixels are images in the literal sense, the spirit of their usage is probably closer to what we'd associate with scripts or CSS.

Further investigation into the data set revealed that 62% of GIFs are 43 bytes or smaller (43 bytes is the size of a transparent, 1x1 pixel GIF) and 84% of GIFs are 1 KB or smaller.

{{ figure_markup(
  image="ch18_fig3_gif_cdf.png",
  caption="Cumulative distribution function of GIF file sizes.",
  description="Chart showing 25% of GIFs are 35 bytes or smaller (which is the optimal size of a 1x1 white GIF) and 62% of GIFs are 43 bytes or smaller (which is the optimal size of a 1x1 transparent GIF). This increases to just over 75% of GIFs being 100 bytes or less.",
  width=600,
  height=330
  )
}}

The tables below show two different approaches to removing these tiny images from the data set: the first one is based on images with a file size greater than 100 bytes, the second is based on images with a file size greater than 1024 bytes.

#### File size by image format for images > 100 bytes

<figure>
  <table>
    <tr>
      <th>Percentile</th>
      <th>GIF (KB)</th>
      <th>ICO (KB)</th>
      <th>JPG (KB)</th>
      <th>PNG (KB)</th>
      <th>SVG (KB)</th>
      <th>WEBP (KB)</th>
    </tr>
    <tr>
      <td>10</td>
      <td>0.27</td>
      <td>0.31</td>
      <td>3.08</td>
      <td>0.4</td>
      <td>0.28</td>
      <td>2.1</td>
    </tr>
    <tr>
      <td>25</td>
      <td>0.75</td>
      <td>0.6</td>
      <td>7.7</td>
      <td>1.17</td>
      <td>0.46</td>
      <td>4.4</td>
    </tr>
    <tr>
      <td>50</td>
      <td>2.14</td>
      <td>1.12</td>
      <td>20.47</td>
      <td>4.35</td>
      <td>0.95</td>
      <td>11.54</td>
    </tr>
    <tr>
      <td>75</td>
      <td>7.34</td>
      <td>4.19</td>
      <td>61.13</td>
      <td>21.39</td>
      <td>2.67</td>
      <td>31.21</td>
    </tr>
    <tr>
      <td>90</td>
      <td>35</td>
      <td>14.73</td>
      <td>155.46</td>
      <td>91.02</td>
      <td>8.26</td>
      <td>76.43</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="File size by image format for images > 100 bytes.") }}</figcaption>
</figure>

#### File size by image format for images > 1024 bytes

<figure>
  <table>
    <tr>
      <th>Percentile</th>
      <th>GIF (KB)</th>
      <th>ICO (KB)</th>
      <th>JPG (KB)</th>
      <th>PNG (KB)</th>
      <th>SVG (KB)</th>
      <th>WEBP (KB)</th>
    </tr>
    <tr>
      <td>10</td>
      <td>1.28</td>
      <td>1.12</td>
      <td>3.4</td>
      <td>1.5</td>
      <td>1.2</td>
      <td>3.08</td>
    </tr>
    <tr>
      <td>25</td>
      <td>1.9</td>
      <td>1.12</td>
      <td>8.21</td>
      <td>2.88</td>
      <td>1.52</td>
      <td>5</td>
    </tr>
    <tr>
      <td>50</td>
      <td>4.01</td>
      <td>2.49</td>
      <td>21.19</td>
      <td>8.33</td>
      <td>2.81</td>
      <td>12.52</td>
    </tr>
    <tr>
      <td>75</td>
      <td>11.92</td>
      <td>7.87</td>
      <td>62.54</td>
      <td>33.17</td>
      <td>6.88</td>
      <td>32.83</td>
    </tr>
    <tr>
      <td>90</td>
      <td>67.15</td>
      <td>22.13</td>
      <td>157.96</td>
      <td>127.15</td>
      <td>19.06</td>
      <td>79.53</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="File size by image format for images > 1024 bytes.") }}</figcaption>
</figure>

The low file size of PNG images compared to JPEG images may seem surprising. JPEG uses [lossy compression](https://en.wikipedia.org/wiki/Lossy_compression). Lossy compression results in data loss, which makes it possible to achieve smaller file sizes. Meanwhile, PNG uses [lossless compression](https://en.wikipedia.org/wiki/Lossless_compression). This does not result in data loss, which this produces higher-quality, but larger images. However, this difference in file sizes is probably a reflection of the popularity of PNGs for iconography due to their transparency support, rather than differences in their encoding and compression.

#### File size by media format

MP4 is overwhelmingly the most popular video format on the web today. In terms of popularity, it is followed by WebM and MPEG-TS respectively.

Unlike some of the other tables in this data set, this one has mostly happy takeaways. Videos are consistently smaller on mobile, which is great to see. In addition, the median size of an MP4 video is a very reasonable 18 KB on mobile and 39 KB on desktop. The median numbers for WebM are even better but they should be taken with a grain of salt: the duplicate measurement of 0.29 KB across multiple clients and percentiles is a little bit suspicious. One possible explanation is that identical copies of one very tiny WebM video is included on many pages. Of the three formats, MPEG-TS consistently has the highest file size across all percentiles. This may be related to the fact that it was released in 1995, making it the oldest of these three media formats.

##### Mobile

<figure>
  <table>
    <tr>
      <th>Percentile</th>
      <th>MP4 (KB)</th>
      <th>WebM (KB)</th>
      <th>MPEG-TS (KB)</th>
    </tr>
    <tr>
      <td>10</td>
      <td>0.89</td>
      <td>0.29</td>
      <td>0.01</td>
    </tr>
    <tr>
      <td>25</td>
      <td>2.07</td>
      <td>0.29</td>
      <td>55</td>
    </tr>
    <tr>
      <td>50</td>
      <td>18</td>
      <td>1.44</td>
      <td>153</td>
    </tr>
    <tr>
      <td>75</td>
      <td>202</td>
      <td>223</td>
      <td>278</td>
    </tr>
    <tr>
      <td>90</td>
      <td>928</td>
      <td>390</td>
      <td>475</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Video size by media format on mobile.") }}</figcaption>
</figure>

##### Desktop

<figure>
  <table>
    <tr>
      <th>Percentile</th>
      <th>MP4 (KB)</th>
      <th>WebM (KB)</th>
      <th>MPEG-TS (KB)</th>
    </tr>
    <tr>
      <td>10</td>
      <td>0.27</td>
      <td>0.29</td>
      <td>34</td>
    </tr>
    <tr>
      <td>25</td>
      <td>1.05</td>
      <td>0.29</td>
      <td>121</td>
    </tr>
    <tr>
      <td>50</td>
      <td>39</td>
      <td>17</td>
      <td>286</td>
    </tr>
    <tr>
      <td>75</td>
      <td>514</td>
      <td>288</td>
      <td>476</td>
    </tr>
    <tr>
      <td>90</td>
      <td>2142</td>
      <td>896</td>
      <td>756</td>
    </tr>
  </table>
  <figcaption>{{ figure_link(caption="Video size by media format on desktop.") }}</figcaption>
</figure>

## Conclusion

Over the past year, pages increased in size by roughly 10%. Brotli, performance budgets, and basic image optimization best practices are probably the three techniques which show the most promise for maintaining or improving page weight while also being widely applicable and fairly easy to implement. That being said, in recent years, improvements in page weight have been more constrained by the low adoption of best practices than by the technology itself. In other words, although there are many existing techniques for improving page weight, they won't make a difference if they aren't put to use.
