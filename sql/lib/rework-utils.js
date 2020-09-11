/**
 * Test whether a value passes a given test.
 * The test could be a string, regexp, function, or array of any of these.
 * This is at the core of most walkers.
 * @param value
 * @param {string|RegExp|Function|Array} [test]
 * @return {Boolean} true if no test is provided, or test passes, false otherwise.
 */
function matches(value, test) {
  if (!test) {
    return true;
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
    return test.test(value);
  }

  return false;
}

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
    if (!matches(rule, test && test.rules)) {
      continue;
    }

    // Walk declarations directly in rule
    if (rule.declarations) {
      for (let declaration of rule.declarations) {
        if (matches(declaration.property, test && test.properties) && matches(declaration.value, test && test.values)) {
          callback(declaration, rule);
        }
      }
    }

    // Walk declarations of nested rules (e.g. @media, @supports have nested rules)
    if (rule.rules) {
      walkDeclarations(rule.rules, callback, test);
    }
  }
}

/**
 * Recursively walk all "normal" rules, i.e. rules with selectors
 * @param rules {Object|Array} AST or array of CSS rules
 * @param callback {Function} Function to be executed for each matching rule. Rule passed as the only argument.
 * @param [test] {Object}
 * @param test.rules {string|RegExp|Function|Array} Which rules the callback runs on
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
    if (matches(rule, test && test.rules)) {
      let ret = callback(rule);

      if (ret !== undefined) {
        // Break loop and return immediately
        return ret;
      }
    }

    if (matches(rule, test && test.ancestors)) {
      if (rule.rules) {
        walkRules(rule.rules, callback, test);
      }
    }
  }
}

/**
 * Sort an object literal and return the result as a new object literal
 * @param {Object} obj
 * @param {Function} [f=x=>x] Optional function to pass arguments through, useful if e.g. we are sorting by a property of an object.
 */
function sortObject(obj, f = x => x) {
  return Object.fromEntries(Object.entries(obj).sort((a, b) => f(b[1]) - f(a[1])));
}

/**
 * Sum all values of an object and return the result
 * @param {Object} obj
 */
function sumObject(obj) {
  Object.values(obj).reduce((a, c) => a + c, 0);
}

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
