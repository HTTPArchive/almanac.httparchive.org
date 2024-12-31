# 2024 Media queries

<!--
  This directory contains all of the 2024 Media chapter queries.

  Each query should have a corresponding `metric_name.sql` file.
  Note that readers are linked to this directory, so try to make the SQL file names descriptive for easy browsing.

  Analysts: if helpful, you can use this README to give additional info about the queries.
-->

## Notes for 2024

2021’s analysis was largely done on custom metrics, which work on what they can see using JS APIs, in the DOM. As such, we worked primarily looked at `<img>` and `<video>` elements, and there were a bunch of things about the actual image resources that we had to work really hard to discover (e.g., `approximateResourceWidth`), or just couldn’t determine at all (is this GIF animated?)

The best thing that happened in 2024 was getting a bunch of metadata about the image resources themselves. Pat Meenan figured out how to get the crawler to run the actual loaded resource bytes through both ImageMagick’s `identify`, and ExifTool. This is available in `$._image_details`.

The biggest unaccomplished goal in 2024 was being able to join up this amazing information about the resources themselves, with the information we glean from Custom Metrics about how those resources were embedded on pages. We no longer need to jump through hoops to calculate `approximateResourceWidth`, or guess at file formats using heuristics. We can know these things definitively now. But I wasn't able to join up the one dataset to the other.

This might be accomplishable in 2024 by getting `_image_details` into [`$WPT_REQUESTS`](https://github.com/HTTPArchive/custom-metrics/blob/d4cdb38201c6c870589edaeb946950656c8009ca/dist/responsive_images.js#L447), accessible within Custom Metric code. Failing that it seems possible to JOIN `_image_details` JSON with the `responsive_images` custom metric JSON over URLs.

It pains me that I never figured out a way to look at background images (or favicons or image resources loaded by JS and painted to a canvas) within custom metrics. Queries that start based on requests tally these non-`<img>` images; queries that look at `responsive-images` (which looks at `<img>` elements), do not.

In general there is a lot of untapped potential in the new ImageMagick and EXIFTool results, but we found this year that these tools report things frustratingly-inconsistently, and getting good results for all of the web's images requires lots of testing and edge cases. I spent probably half of my analysis time this year trying to get good, cross-format color space and depth data, but the way that image formats deal with colorspaces, and the way that `identify` reports things, make this quite tricky! I scaled back my ambitions this year by only looking at ICC profiles (AVIF and PNG allow direct embedding of colorspace info, which `identify` reports in various ways... I digress). Akshay fell into a similar trap trying to write Animated Image queries that dealt not only with Gifs, but with Animated PNGs and AVIFs. We ended up not being able to do that analysis.

The duplication and separation of custom metrics is unfortunate. `media.js`, `Images.js`, and `responsive-images.js` have a lot of duplication and overlap. They could stand a unification and cleanup, if only for clarity's sake.

I didn't do anything new with video at all -- these are just Doug's queries from 2021 with updated dates. I'm positive more can be done here, not sure I'm the person to do it.

---

Some additional notes, that came out of the document review process:

> I've seen multiple sites using `<picture>` where `srcset`/`sizes` would be enough, and even better, without type switching nor art direction. I don't know if this is something that can be detected, maybe for next year.

– Nicolas Hoizey

> Maybe we could add (next year?) details about which types are used in `<source>`s, in which order. (I've seen type switching with JPEG first… 😅)
>
> Also maybe useful:
> - the number of `<source>`s for art direction
> - wheither the latest `<source>` is useful or `<img srcset sizes>` would be enough, for both use cases (another frequent mistake)

– Nicolas Hoizey

## Resources

- [📄 Planning doc][~google-doc]
- [📊 Results sheet][~google-sheets]
- [📝 Markdown file][~chapter-markdown]

[~google-doc]: https://docs.google.com/document/d/1aIMU2N03Fof01066KuMseVdlVdlEmwUGRsB5LsJIOZE/edit
[~google-sheets]: https://docs.google.com/spreadsheets/d/1Q2ITOe6ZMIXGKHtIxqK9XmUA1eQBX9CLQkxarQOJFCk/edit#gid=1778117656
[~chapter-markdown]: https://github.com/HTTPArchive/almanac.httparchive.org/tree/main/src/content/en/2024/media.md
