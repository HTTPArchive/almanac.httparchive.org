const { JSDOM } = require('jsdom');

const generate_table_of_contents = (html) => {
  const dom = new JSDOM(html);
  const all_headings = Object.values(
    dom.window.document.querySelectorAll('h1, h2, h3, h4, h5, h6')
  );
  const starting_level = get_level(all_headings[0]);
  const toc = nest_headings(all_headings, starting_level);

  return toc;
};

// This is a recursive function to nest the headings.
const nest_headings = (source, current_level = 1) => {
  // The list of headings to output.
  let target = [];

  while (source.length) {
    // Pull the first item off of the source list.
    const element = source.shift();
    const id = element.id;
    // Every title should be in an Anchor element, but let's check to be sure
    const title = element.firstChild && element.firstChild.nodeName === 'A' ? element.firstChild.innerHTML : element.textContent;
    const level = get_level(element);

    const heading = {
      id,
      level,
      title
    };

    if (level === current_level) {
      // The heading is at this level, add it to the list.
      target.push(heading);
    } else if (level > current_level) {
      /* The heading needs to be added to the next level.
        - Put the element back on the source array.
        - Get the last item on the list, that becomes the parent.
        - Use the rest of the source list to recurse and generate the 
          rest of the children.
        - Set the children property of the parent heading, including
            * Previous children
            * The recursively generated children
      */
      source.unshift(element);
      const parent = target[target.length - 1];
      let children = nest_headings(source, level);
      parent.children = [...(parent.children || []), ...children];
    } else {
      /* The next item on the source is at a higher level, break out of this
         level of recursion after putting the element back on the array.
      */
      source.unshift(element);
      return target;
    }
  }

  return target;
};

const get_level = (element) => element && Number(element.localName.match(/\d+/)[0]);

module.exports = {
  generate_table_of_contents
};
