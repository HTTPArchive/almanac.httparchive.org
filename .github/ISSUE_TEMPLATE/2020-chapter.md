---
name: 2020 Chapter
about: Template for creating a new chapter tracking issue for the 2020 Web Almanac
title: "[Title] 2020"
labels: help wanted, analysis, writing
assignees: ''

---

# Part [Number] Chapter [Number]: [Title]

## Content team
| Authors | Reviewers | Analysts | Draft | Queries | Results |
| ------- | --------- | -------- | ----- | ------- | ------- |
| TBD | TBD | TBD | [Doc](#~draft-doc) | [*.sql](#~sql-dir) | [Sheet](#~results-sheet) |

**Content team lead:** TBD

Welcome chapter contributors! You'll be using this issue throughout the [chapter lifecycle](https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Chapter-Lifecycle) to coordinate on the content planning, analysis, and writing stages.

The **content team** is made up of the following contributors:

- [Authors](https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide)
- [Reviewers](https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Reviewers'-Guide)
- [Analysts](https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Analysts'-Guide)

**New contributors:** If you're interested in joining the content team for this chapter, just leave a comment below and the content team lead will loop you in.

_Note: To ensure that you get notifications when tagged, you must be "[watching](https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Chapter-Lifecycle/_edit#notifications)" this repository._

## Milestones

### [**0. Form the content team**](https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Chapter-Lifecycle#0-create-content-team)
+ [ ] **Jul 6th**: Project owners have selected an author to be the content team lead
+ [ ] **Jul 13th**: The content team has at least one author, reviewer, and analyst (minimally viable team formed)

### [**1. Plan content**](https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Chapter-Lifecycle#1-plan-content)
+ [ ] **Jul 20th:** The content team has completed the chapter outline in the [draft doc](#~draft-doc)
+ [ ] **Jul 27th**: Analysts have triaged the feasibility of all proposed metrics

### [**2. Gather data**](https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Chapter-Lifecycle#1-plan-content)
+ [ ] **Jul 27th**: Analysts have prepared all feasible metrics for testing and added queries to the [sql directory](#~sql-dir)
+ [ ] **Sep 7th**: Analysts have queried all metrics and saved the output to the [results sheet](#~results-sheet)

### [**3. Validate results**](https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Chapter-Lifecycle#3-validate-results)
+ [ ] **Sep 14th**: The content team has reviewed the [results sheet](#~results-sheet)

### [**4. Draft content**](https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Chapter-Lifecycle#4-draft-content)
+ [ ] **Oct 12th**: Authors have completed the first draft in the [doc](#~draft-doc)
+ [ ] **Oct 26th**: The content team has prototyped all data visualizations

### [**5. Publication**](https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Chapter-Lifecycle#5-publication)
+ [ ] **Oct 26th**: The content team has reviewed the final draft, converted to markdown, and filed a PR to add it to the [2020 content directory](https://github.com/HTTPArchive/almanac.httparchive.org/tree/main/src/content/en/2020)
- **Nov 9th**: Target launch date

[~draft-doc]: #
[~sql-dir]: https://github.com/HTTPArchive/almanac.httparchive.org/tree/main/sql/2020/${chapter_slug}/
[~results-sheet]: #
