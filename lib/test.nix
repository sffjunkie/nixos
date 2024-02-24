# Adapted from https://github.com/jetpack-io/nixtest/ to take a reference
# to `lib`
{lib, ...}: rec {
  # Function `run` takes a directory as an argument, finds all test files
  # matching the pattern `**/*.test.nix`, and runs all of those tests.
  #
  # Once the tests have run, it prints a summary of the results. If any of
  # the tests failed, it prints the summary by throwing an exception and
  # exiting with a non-zero exit code.
  #
  # Note that every _test.nix file should evaluate to a list of tests. Each test
  # in the list should have the schema defined in `runTest`.
  run = dir: attrs @ {lib, ...}: let
    results = runDir dir attrs;
  in (
    assertTests results
  );

  # testFiles = path -> list[str]
  # Returns a
  testFiles = dir: (
    let
      fileTypes = builtins.readDir dir;
      filenames = builtins.attrNames fileTypes;
      allTestFiles =
        builtins.foldl' (
          acc: filename: let
            path = dir + "/${filename}";
            fileType = builtins.getAttr filename fileTypes;
            isTestFile = (fileType == "regular") && (builtins.match ".*_test\.nix" filename) != null;
          in (
            if fileType == "directory"
            then acc ++ (testFiles path)
            else if isTestFile
            then acc ++ [path]
            else acc ++ []
          )
        ) []
        filenames;
    in
      allTestFiles
  );

  # Function `runDir` takes a directory as an argument, finds all test files
  # matching the pattern `**/*.test.nix`, and runs all of those tests.
  #
  # It returns a list of results, one for each test.
  runDir = dir: attrs @ {lib, ...}: (
    let
      results =
        builtins.foldl' (
          acc: filepath: (
            acc ++ (runTests ((import filepath) {inherit lib;}))
          )
        ) []
        (testFiles dir);
    in
      results
  );

  # Function runTests runs all of the given tests, by calling `runTest` on each
  # of them.
  #
  # It takes a list of tests as an argument.
  runTests = tests: (
    let
      results = builtins.map (test: runTest test) tests;
    in
      results
  );

  # Function `runTest` runs the gives test. A test is defined as a structure
  # with the following schema:
  # {
  #  name: string             # Name of the test
  #  actual:   any            # The return value from the functionality you want to test
  #  expected: any            # Expected return value of `fn(input)`
  # }
  runTest = test: (
    if test.actual == test.expected
    then {
      name = test.name;
      actual = test.actual;
      expected = test.expected;
      passed = true;
    }
    else {
      # We never get here since assertEqual will throw an error.
      name = test.name;
      actual = test.actual;
      expected = test.expected;
      passed = false;
    }
  );

  # Function `assertTests` takes in a list of test results (as returned by the
  # `run` functions) and throws an error if any of the tests failed.
  assertTests = results: let
    numTests = builtins.length results;
    failures = builtins.filter (test: test.passed == false) results;
    numFailures = builtins.length failures;
  in (
    # results
    if (builtins.length failures) == 0
    then "[PASS] ${toString numTests}/${toString numTests} tests passed\n"
    else
      throw ("${toString numFailures}/${toString numTests} tests failed\n\n"
        + failureMsg failures)
  );

  failureMsg = results: (
    builtins.foldl' (
      acc: result:
        acc
        + ''
          [FAIL] ${result.name}
            Expected: ${builtins.toJSON result.expected}
            Actual:   ${builtins.toJSON result.actual}

        ''
    ) ""
    results
  );
}
