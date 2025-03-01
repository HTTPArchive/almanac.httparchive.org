var parsel = (() => {
const TOKENS = {
  attribute: /\[\s*(?:(?<namespace>\*|[-\w]*)\|)?(?<name>[-\w\u{0080}-\u{FFFF}]+)\s*(?:(?<operator>\W?=)\s*(?<value>.+?)\s*(?<caseSensitive>[iIsS])?\s*)?\]/gu,
  id: /#(?<name>(?:[-\w\u{0080}-\u{FFFF}]|\\.)+)/gu,
  class: /\.(?<name>(?:[-\w\u{0080}-\u{FFFF}]|\\.)+)/gu,
  comma: /\s*,\s*/g, // must be before combinator
  combinator: /\s*[\s>+~]\s*/g, // this must be after attribute
  "pseudo-element": /::(?<name>[-\w\u{0080}-\u{FFFF}]+)(?:\((?<argument>¶+)\))?/gu, // this must be before pseudo-class
  "pseudo-class": /:(?<name>[-\w\u{0080}-\u{FFFF}]+)(?:\((?<argument>¶+)\))?/gu,
  type: /(?:(?<namespace>\*|[-\w]*)\|)?(?<name>[-\w\u{0080}-\u{FFFF}]+)|\*/gu // this must be last
};

const TOKENS_WITH_PARENS = new Set(["pseudo-class", "pseudo-element"]);
const TOKENS_WITH_STRINGS = new Set([...TOKENS_WITH_PARENS, "attribute"]);
const TRIM_TOKENS = new Set(["combinator", "comma"]);
const RECURSIVE_PSEUDO_CLASSES = new Set(["not", "is", "where", "has", "matches", "-moz-any", "-webkit-any"]);

const TOKENS_FOR_RESTORE = Object.assign({}, TOKENS);
TOKENS_FOR_RESTORE["pseudo-element"] = RegExp(TOKENS["pseudo-element"].source.replace("(?<argument>¶+)", "(?<argument>.+?)"), "gu")
TOKENS_FOR_RESTORE["pseudo-class"] = RegExp(TOKENS["pseudo-class"].source.replace("(?<argument>¶+)", "(?<argument>.+)"), "gu")

function gobbleParens(text, i) {
  let str = "", stack = [];

  for (; i < text.length; i++) {
    let char = text[i];

    if (char === "(") {
      stack.push(char);
    }
    else if (char === ")") {
      if (stack.length > 0) {
        stack.pop();
      }
      else {
        throw new Error("Closing paren without opening paren at " + i);
      }
    }

    str += char;

    if (stack.length === 0) {
      return str;
    }
  }

  throw new Error("Opening paren without closing paren");
}

function tokenizeBy (text, grammar) {
  if (!text) {
    return [];
  }

  var strarr = [text];

  tokenloop: for (var token in grammar) {
    let pattern = grammar[token];

    for (var i=0; i < strarr.length; i++) { // Don’t cache length as it changes during the loop
      var str = strarr[i];

      if (typeof str === "string") {
        pattern.lastIndex = 0;

        var match = pattern.exec(str);

        if (match) {
          let from = match.index - 1;
          let args = [];
          let content = match[0];

          let before = str.slice(0, from + 1);
          if (before) {
            args.push(before);
          }

          args.push({
            type: token,
            content,
            ...match.groups
          });

          let after = str.slice(from + content.length + 1);
          if (after) {
            args.push(after);
          }

          strarr.splice(i, 1, ...args);
        }

      }
    }
  }

  let offset = 0;
  for (let i=0; i<strarr.length; i++) {
    let token = strarr[i];
    let length = token.length || token.content.length;

    if (typeof token === "object") {
      token.pos = [offset, offset + length];

      if (TRIM_TOKENS.has(token.type)) {
        token.content = token.content.trim() || " ";
      }
    }

    offset += length;
  }

  return strarr;
}

function tokenize (selector) {
  if (!selector) {
    return null;
  }

  selector = selector.trim(); // prevent leading/trailing whitespace be interpreted as combinators

  // Replace strings with whitespace strings (to preserve offsets)
  let strings = [];
  // FIXME Does not account for escaped backslashes before a quote
  selector = selector.replace(/(['"])(\\\1|.)+?\1/g, (str, quote, content, start) => {
    strings.push({str, start});
    return quote + "§".repeat(content.length) + quote;
  });

  // Now that strings are out of the way, extract parens and replace them with parens with whitespace (to preserve offsets)
  let parens = [], offset = 0, start;
  while ((start = selector.indexOf("(", offset)) > -1) {
    let str = gobbleParens(selector, start);
    parens.push({str, start});
    selector = selector.substring(0, start) + "(" + "¶".repeat(str.length - 2) + ")" + selector.substring(start + str.length);
    offset = start + str.length;
  }

  // Now we have no nested structures and we can parse with regexes
  let tokens = tokenizeBy(selector, TOKENS);

  // Now restore parens and strings in reverse order
  function restoreNested(strings, regex, types) {
    for (let str of strings) {
      for (let token of tokens) {
        if (types.has(token.type) && token.pos[0] < str.start && str.start < token.pos[1]) {
          let content = token.content;
          token.content = token.content.replace(regex, str.str);

          if (token.content !== content) { // actually changed?
            // Re-evaluate groups
            TOKENS_FOR_RESTORE[token.type].lastIndex = 0;
            let match = TOKENS_FOR_RESTORE[token.type].exec(token.content);
            let groups = match.groups;
            Object.assign(token, groups);
          }
        }
      }
    }
  }

  restoreNested(parens, /\(¶+\)/, TOKENS_WITH_PARENS);
  restoreNested(strings, /(['"])§+?\1/, TOKENS_WITH_STRINGS);

  return tokens;
}

// Convert a flat list of tokens into a tree of complex & compound selectors
function nestTokens(tokens, {list = true} = {}) {
  if (list && tokens.find(t => t.type === "comma")) {
    let selectors = [], temp = [];

    for (let i=0; i<tokens.length; i++) {
      if (tokens[i].type === "comma") {
        if (temp.length === 0) {
          throw new Error("Incorrect comma at " + i);
        }

        selectors.push(nestTokens(temp, {list: false}));
        temp.length = 0;
      }
      else {
        temp.push(tokens[i]);
      }
    }

    if (temp.length === 0) {
      throw new Error("Trailing comma");
    }
    else {
      selectors.push(nestTokens(temp, {list: false}));
    }

    return { type: "list", list: selectors };
  }

  for (let i=tokens.length - 1; i>=0; i--) {
    let token = tokens[i];

    if (token.type === "combinator") {
      let left = tokens.slice(0, i);
      let right = tokens.slice(i + 1);

      return {
        type: "complex",
        combinator: token.content,
        left: nestTokens(left),
        right: nestTokens(right)
      };
    }
  }

  if (tokens.length === 0) {
    return null;
  }

  // If we're here, there are no combinators, so it's just a list
  return tokens.length === 1? tokens[0] : {
    type: "compound",
    list: [...tokens] // clone to avoid pointers messing up the AST
  };
}

// Traverse an AST (or part thereof), in depth-first order
function walk(node, callback, o, parent) {
  if (!node) {
    return;
  }

  if (node.type === "complex") {
    walk(node.left, callback, o, node);
    walk(node.right, callback, o, node);
  }
  else if (node.type === "compound") {
    for (let n of node.list) {
      walk(n, callback, o, node);
    }
  }
  else if (node.subtree && o && o.subtree) {
    walk(node.subtree, callback, o, node);
  }

  callback(node, parent);
}

/**
 * Parse a CSS selector
 * @param selector {String} The selector to parse
 * @param options.recursive {Boolean} Whether to parse the arguments of pseudo-classes like :is(), :has() etc. Defaults to true.
 * @param options.list {Boolean} Whether this can be a selector list (A, B, C etc). Defaults to true.
 */
function parse(selector, {recursive = true, list = true} = {}) {
  let tokens = tokenize(selector);

  if (!tokens) {
    return null;
  }

  let ast = nestTokens(tokens, {list});

  if (recursive) {
    walk(ast, node => {
      if (node.type === "pseudo-class" && node.argument && RECURSIVE_PSEUDO_CLASSES.has(node.name)) {
        node.subtree = parse(node.argument, {recursive: true, list: true});
      }
    });
  }

  return ast;
}

function specificityToNumber(specificity, base) {
  base = base || Math.max(...specificity) + 1;

  return specificity[0] * base ** 2 + specificity[1] * base + specificity[2];
}

function maxIndexOf(arr) {
  let max = arr[0], ret = 0;

  for (let i=0; i<arr.length; i++) {
    if (arr[i] > max) {
      ret = i;
      max = arr[i];
    }
  }

  return arr.length === 0? -1 : ret;
}

/**
 * Calculate specificity of a selector.
 * If the selector is a list, the max specificity is returned.
 */
function specificity(selector, {format = "array"} = {}) {
  let ast = typeof selector === "object"? selector : parse(selector, {recursive: true});

  if (!ast) {
    return null;
  }

  if (ast.type === "list") {
    // Return max specificity
    let base = 10;
    let specificities = ast.list.map(s => {
      let sp = specificity(s);
      base = Math.max(base, ...sp);
      return sp;
    });
    let numbers = specificities.map(s => specificityToNumber(s, base));
    let i = maxIndexOf(numbers);
    return specificities[i];
  }

  let ret = [0, 0, 0];

  walk(ast, node => {
    if (node.type === "id") {
      ret[0]++;
    }
    else if (node.type === "class" || node.type === "attribute") {
      ret[1]++;
    }
    else if ((node.type === "type" && node.content !== "*") || node.type === "pseudo-element") {
      ret[2]++;
    }
    else if (node.type === "pseudo-class" && node.name !== "where") {
      if (RECURSIVE_PSEUDO_CLASSES.has(node.name) && node.subtree) {
        // Max of argument list
        let sub = specificity(node.subtree);
        sub.forEach((s, i) => ret[i] += s);
      }
      else {
        ret[1]++;
      }
    }
  });

  return ret;
}


return {gobbleParens, tokenizeBy, tokenize, nestTokens, walk, parse, specificityToNumber, specificity};
})();

/* countDeclarations.js */

/**
 * Count total declarations that pass a given test.
 * @see {@link module:walkDeclarations} for arguments
 * @returns {number} Declaration count that pass the provided conditions.
 */
function countDeclarations(rules, test) {
  let ret = 0;

  walkDeclarations(rules, declaration => ret++, test);

  return ret;
}


/* countDeclarationsByProperty.js */

/**
 * Count properties that pass a given test, in rules that pass a given test
 * @see {@link module:walkDeclarations} for arguments
 * @return {Object} Property names and declaration counts. Use `sumObject(ret)` to get total count.
 */
function countDeclarationsByProperty(rules, test) {
  let ret = {};

  walkDeclarations(rules, declaration => {
    ret[declaration.property] = (ret[declaration.property] || 0) + 1;
  }, test);

  return sortObject(ret);
}


/* extractFunctionCalls.js */
/**
 * Extract all or some function calls from a string
 * @param {string} value - The value to extract function calls from.
 *                         Note that this will also extract nested function calls, you can use `pos` to discard those if they are not of interest.
 * @param {Object} [test]
 * @param {string|RegExp|Function|Array} test.names
 * @param {string|RegExp|Function|Array} test.args
 * @param {Boolean} test.topLevel If true, only return top-level functions
 * @return {Array<Object>} Array of objects, one for each function call with `{name, args, pos}` keys
 */
function extractFunctionCalls(value, test) {
  // First, extract all function calls
  let ret = [];

  for (let match of value.matchAll(/(?<name>[\w-]+)\(/gi)) {
    let index = match.index;
    let openParen = index + match[0].length;
    let rawArgs = parsel.gobbleParens(value, openParen - 1);
    let args = rawArgs.slice(1, -1).trim();
    let name = match.groups.name;

    ret.push({name, pos: [index, index + match[0].length + rawArgs.length - 1], args})
  }

  if (test) {
    if (test.names || test.args) {
      ret = ret.filter(f => {
        return matches(f.name, test.names) && matches(f.args, test.args);
      });
    }

    if (test.topLevel && ret.length > 0) {
      // Filter out nested functions
      let [start, end] = ret[0].pos;

      // Note that because we did the rest of the filtering earlier, this only takes into account
      // the functions that passed the test. E.g. if we're only extracting rgb() functions, it will
      // NOT consider linear-gradient(rgb(...)) as nested.
      ret = ret.filter(f => {
        let [s, e] = f.pos;
        if (s > start && e < end) {
          // Nested
          return false;
        }

        // Not nested
        [start, end] = [s, e];
        return true;
      });
    }
  }

  return ret;
}


// Get distinct values of properties that pass a given test, in rules that pass a given test
// Returns object of properties with arrays of values.
function getPropertyValues(rules, test) {
  let ret = {};

  walkDeclarations(rules, declaration => {
    if (matches(declaration.property, test && test.properties) && matches(declaration.value, test && test.values)) {
      ret[declaration.property] = (ret[declaration.property] || new Set());
      ret[declaration.property].add(declaration.value);
    }
  }, {rules: test && test.rules});

  return sortObject(ret);
}


/* incrementByKey.js */

/**
 * Increment a value in an object, whether the key exists or not
 * @param {Object} obj - The object
 * @param {string} key - The object property
 * @return {number} The new value
 */
function incrementByKey(obj, key) {
  return obj[key] = (obj[key] || 0) + 1;
}


/* matches.js */
/**
 * Test whether a value passes a given test.
 * The test could be a string, regexp, function, or array of any of these.
 * This is at the core of most walkers.
 * @param value
 * @param {string|RegExp|Function|Array} [test]
 * @return {Boolean} true if no test is provided, or test passes, false otherwise.
 */
function matches(value, test, not) {
  if (!test) {
    return !not;
  }

  if (Array.isArray(test)) {
    return test.some(t => matches(value, t));
  }

  let type = typeof test;

  if (type === "string") {
    return value === test;
  }
  else if (type === "function") {
    return test(value);
  }
  else if (test instanceof RegExp) {
    let ret = test.test(value);
    test.lastIndex = 0;
    return ret;
  }

  return false;
}


/* removeFunctionCalls.js */
/**
 * Remove function calls from a string
 * @param {string} value - @see {@link module:extractFunctionCalls} for arguments
 * @param {Object} [test] @see {@link module:extractFunctionCalls} for arguments.
 *                        Except `topLevel` which is always true, as it doesn't make sense otherwise.
 * @return {String} The string
 */
function removeFunctionCalls(value, test = {}) {
  test.topLevel = true;
  let offset = 0;

  for (let f of extractFunctionCalls(value, test)) {
    let [start, end] = f.pos;
    start -= offset;
    end -= offset;

    value = value.substring(0, start) + value.substring(end);
    offset += end - start;
  }

  return value;
}


/* sortObject.js */
/**
 * Sort an object literal and return the result as a new object literal
 * @param {Object} obj
 * @param {Function} [f=x=>x] Optional function to pass arguments through, useful if e.g. we are sorting by a property of an object.
 */
function sortObject(obj, f = x => x) {
  if (!obj) {
    return obj;
  }

  return Object.fromEntries(Object.entries(obj).sort((a, b) => f(b[1]) - f(a[1])));
}


/* sumObject.js */
/**
 * Sum all values of an object and return the result
 * @param {Object} obj
 */
function sumObject(obj) {
  return Object.values(obj).reduce((a, c) => a + c, 0);
}


/* walkDeclarations.js */

/**
 * Recursively walk all declarations
 * @param {Object|Array} rules - AST, array of rules, or single rule
 * @param {Function} callback - Callback to be executed on each declaration. Arguments: (declaration, rule)
 * @param {Object} [test] - Conditions that need to be satisfied for a declaration to be visited, all optional
 * @param {string|RegExp|Function|Array} test.properties - Test for property names
 * @param {string|RegExp|Function|Array} test.values - Test for values
 * @param {string|RegExp|Function|Array} test.rules - Test for rules
 */
function walkDeclarations(rules, callback, test) {
  if (!rules) {
    return;
  }

  if (rules.stylesheet) {
    // AST passed
    rules = rules.stylesheet.rules;
  }
  else if (!Array.isArray(rules)) {
    // Single rule
    rules = [rules];
  }

  for (let rule of rules) {
    if (!matches(rule, test && test.rules) || matches(rule, test && test.not && test.not.rules, true)) {
      continue;
    }

    // Walk declarations directly in rule
    if (rule.declarations) {
      for (let declaration of rule.declarations) {
        if (declaration.type !== "declaration") {
          continue;
        }

        let {property, value} = declaration;
        let important = false;

        value = value.replace(/\s*!important\s*$/, () => {
          important = true;
          return "";
        });

        if (!test ||
                matches(property, test.properties)
            &&  matches(value, test.values)
            && !matches(property, test.not && test.not.properties, true)
            && !matches(value, test.not && test.not.values, true)
        ) {
          callback({property, value, important}, rule);
        }
      }
    }

    // Walk declarations of nested rules (e.g. @media, @supports have nested rules)
    if (rule.rules) {
      walkDeclarations(rule.rules, callback, test);
    }
  }
}


/* walkRules.js */
/**
 * Recursively walk all "normal" rules, i.e. rules with selectors
 * @param rules {Object|Array} AST or array of CSS rules
 * @param callback {Function} Function to be executed for each matching rule. Rule passed as the only argument.
 * @param [test] {Object}
 * @param test.rules {string|RegExp|Function|Array} Which rules the callback runs on
 * @param test.type {string|RegExp|Function|Array} Which rule types the walker runs on
 * @param test.ancestors {string|RegExp|Function|Array} Which rules the walker descends on
 * @return The return value of the callback (which also breaks the loop) or undefined.
 */
function walkRules(rules, callback, test) {
  if (!rules) {
    return;
  }

  if (!Array.isArray(rules)) {
    // AST passed
    rules = rules.stylesheet.rules;
  }

  for (let rule of rules) {
    if (!test ||
            matches(rule, test && test.rules)
        &&  matches(rule.type, test && test.type)
        && !matches(rule, test.not && test.not.rules, true)
        && !matches(rule.type, test.not && test.not.type, true)
    ) {
      let ret = callback(rule);

      if (ret !== undefined) {
        // Break loop and return immediately
        return ret;
      }
    }

    if (
            matches(rule, test && test.ancestors)
        && !matches(rule, test && test.not && test.not.ancestors, true)
    ) {
      if (rule.rules) {
        walkRules(rule.rules, callback, test);
      }
    }
  }
}


/* walkSelectors.js */

/**
 * Walk all selectors in rules that have selectors
 * @param {Object|Array} rules - AST, array of rules, or single rule
 * @param {Function} callback - Function to be executed for each matching rule. Rule passed as the only argument.
 * @param {Object} [test]
 * @param {string|RegExp|Function|Array} test.selectors - Which selectors the callback runs on
 * @see {@link module:walkRules} for test properties available that filter the rules inspected
 */
function walkSelectors(rules, callback, test) {
  if (rules.stylesheet) {
    // AST passed
    rules = rules.stylesheet.rules;
  }
  else if (!Array.isArray(rules)) {
    // Single rule
    rules = [rules];
  }

  walkRules(rules, rule => {
    if (rule.selectors) {
      for (let selector of rule.selectors) {
        if (matches(selector, test && test.selectors)) {
          callback(selector, rule.selectors);
        }
      }
    }
  }, test);
}
