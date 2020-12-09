/**
 * Show the contributors should be added in `config/year.json` file and which should remove based on their contributions in a perticular team
 *
 * @param {object} configs all config file generate with get_yearly_configs().
 * @param {object}  chapter_contributors parsed contributors for each year (author, analyst, reviewer)[Must be a Set (finding is more efficient)]
 * @returns void does not return anything just output in console.
 */
const get_contributors_difference = async (configs, chapter_contributors) => {
  let not_contributed_but_in_file = {};
  let contributed_but_not_in_file = {};

  for (let year in chapter_contributors) {
    not_contributed_but_in_file[year] = {
      "authors": new Set(),
      "reviewers": new Set(),
      "analysts": new Set()
    };

    contributed_but_not_in_file[year] = {
      "authors": new Set(),
      "reviewers": new Set(),
      "analysts": new Set()
    };

    const config_contributors = configs[year].contributors;
    const year_chapter_contributors = chapter_contributors[year];

    // Generates contributors who are in config/year.json file but not contributed for a team
    for (let contributor in config_contributors) {
      const contributor_teams = config_contributors[contributor].teams;
      if (contributor_teams.includes("analysts")) {
        if (!year_chapter_contributors.analysts.has(contributor)) {
          not_contributed_but_in_file[year].analysts.add(contributor);
        }
      }

      if (contributor_teams.includes("authors")) {
        if (!year_chapter_contributors.authors.has(contributor)) {
          not_contributed_but_in_file[year].authors.add(contributor);
        }
      }

      if (contributor_teams.includes("reviewers")) {
        if (!year_chapter_contributors.reviewers.has(contributor)) {
          not_contributed_but_in_file[year].reviewers.add(contributor);
        }
      }
    }

    // Generates contributes who contributed in team but not in config/year.json file
    const year_chapter_authors = year_chapter_contributors.authors;
    const year_chapter_reviewers = year_chapter_contributors.reviewers;
    const year_chapter_analysts = year_chapter_contributors.analysts;
    year_chapter_authors.forEach(author => {
      if (!config_contributors[author] || !config_contributors[author].teams.includes("authors")) {
        contributed_but_not_in_file[year].authors.add(author);
      }
    });
    year_chapter_reviewers.forEach(reviewer => {
      if (!config_contributors[reviewer] || !config_contributors[reviewer].teams.includes("reviewers")) {
        contributed_but_not_in_file[year].reviewers.add(reviewer);
      }
    });
    year_chapter_analysts.forEach(analyst => {
      if (!config_contributors[analyst] || !config_contributors[analyst].teams.includes("analysts")) {
        contributed_but_not_in_file[year].analysts.add(analyst);
      }
    });


    // Print the data in console
    const not_contributed_authors = not_contributed_but_in_file[year].authors;
    const not_contributed_analysts = not_contributed_but_in_file[year].analysts;
    const not_contributed_reviewers = not_contributed_but_in_file[year].reviewers;
    const contributed_authors = contributed_but_not_in_file[year].authors;
    const contributed_analysts = contributed_but_not_in_file[year].analysts;
    const contributed_reviewers = contributed_but_not_in_file[year].reviewers;

    if (not_contributed_analysts.size > 0 || not_contributed_authors.size > 0 || not_contributed_reviewers.size > 0 || contributed_analysts.size > 0 || contributed_authors.size > 0 || contributed_reviewers.size > 0) {
      console.log("\n****************************************************");
      console.log(`Contributor Discrepancies in config/${year}.json`);
      if (not_contributed_authors.size > 0 || contributed_authors.size > 0) {
        console.log("\tAuthors");
        if (not_contributed_authors.size > 0) {
          console.log("\t\tRemove(did not contribute, but listed)");
          not_contributed_authors.forEach(author => console.log("\t\t\t### ", author));
        }
        if (contributed_authors.size > 0) {
          console.log("\t\tAdd(contributed, but are not listed)");
          contributed_authors.forEach(author => console.log("\t\t\t### ", author));
        }
      }

      if (not_contributed_analysts.size > 0 || contributed_analysts.size > 0) {
        console.log("\n\tAnalysts");
        if (not_contributed_analysts.size > 0) {
          console.log("\t\tRemove(did not contribute, but listed)");
          not_contributed_analysts.forEach(analyst => console.log("\t\t\t### ", analyst));
        }
        if (contributed_analysts.size > 0) {
          console.log("\t\tAdd(contributed, but are not listed)");
          contributed_analysts.forEach(analyst => console.log("\t\t\t### ", analyst));
        }
      }

      if (not_contributed_reviewers.size > 0 || contributed_reviewers.size > 0) {
        console.log("\n\tReviewers");
        if (not_contributed_reviewers.size > 0) {
          console.log("\t\tRemove(did not contribute, but listed)");
          not_contributed_reviewers.forEach(reviewer => console.log("\t\t\t### ", reviewer));
        }
        if (contributed_reviewers.size > 0) {
          console.log("\t\tAdd(contributed, but are not listed)");
          contributed_reviewers.forEach(reviewer => console.log("\t\t\t### ", reviewer));
        }
      }
    }
  }
};


module.exports = {
  get_contributors_difference
};
