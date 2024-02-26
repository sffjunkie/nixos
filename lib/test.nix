# Adapted from https://github.com/jetpack-io/nixtest/
# - takes a reference to `lib`
# - Adding a 'skip' attribute to a test skips it
# - Adding a 'skipIf' attribute skips the test if the attribute value is Trueish
{lib, ...}: rec {
  # TestResult = attrSet{ passed: list[Test], failed: list[Test], skipped: list[Test] }
  # Test =  attrSet{ name, actual, expected, skip };

  # Function `run` takes a directory as an argument, finds all test files
  # matching the pattern `**/*.test.nix`, and runs all of those tests.
  #
  # Once the tests have run, it prints a summary of the results. If any of
  # the tests failed, it prints the summary by throwing an exception and
  # exiting with a non-zero exit code.
  #
  # Note that every _test.nix file should evaluate to a list of tests. Each test
  run = {dir, ...} @ inputs: let
    results = runDir dir inputs;
  in (
    showTestResults results
  );

  # runDir = path -> list[TestResult]
  #
  runDir = dir: inputs: (
    let
      results =
        builtins.foldl' (
          acc: filepath: (
            let
              tests = import filepath inputs;
              result = runTests tests filepath;
            in
              acc ++ [result]
          )
        ) []
        (testFiles dir);
    in
      results
  );

  # testFiles = path -> list[str]
  #
  # Function `testFiles` takes a directory as an argument, finds all test files
  # matching the pattern `**/*.test.nix` in this directory and its
  # sub-directories.
  testFiles = dir: (
    let
      fileTypes = builtins.readDir dir;
      filenames = builtins.attrNames fileTypes;
      allTestFiles =
        builtins.foldl' (
          acc: filename: let
            path = lib.concatStringsSep "/" [dir "${filename}"];
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

  addFilePath = filepath: result: (
    let
      newResult = result // {path = filepath;};
    in
      newResult
  );

  isTrueish = value:
    (lib.isList value && value != [])
    || (lib.isAttrs value && value != {})
    || (lib.isBool value && value != false)
    || (lib.isString value && value != "")
    || ((lib.isInt value || lib.isFloat value) && value != 0);

  # runTests = list[Test] -> TestResult
  # Runs all of the non skipped tests, by calling `runTest` on each of them.
  #
  # It takes a list of tests as an argument
  # and returns an attrSet with the following attrs
  #   passed = the results from tests that passed
  #   failed = the results from tests that failed
  #   skipped = list of tests that have been skipped.
  runTests = tests: filepath: (
    let
      skipIf = builtins.filter (test: lib.hasAttrByPath ["skipIf"] test) tests;
      skipIfSkip = builtins.filter (test: isTrueish test.skipIf) skipIf;
      skipIfRun = builtins.filter (test: !isTrueish test.skipIf) skipIf;
      skippedTests = builtins.filter (test: lib.hasAttrByPath ["skip"] test) tests ++ skipIfSkip;
      skipped = map (test: addFilePath filepath test) skippedTests;

      testsToRun =
        builtins.filter
        (test: (!lib.hasAttrByPath ["skip"] test) && (!lib.hasAttrByPath ["skipIf"] test))
        tests
        ++ skipIfRun;

      results = builtins.map (test: addFilePath filepath (evaluateTest test)) testsToRun;

      failed = builtins.filter (test: test.passed == false) results;
      passed = builtins.filter (test: test.passed == true) results;
    in {
      inherit failed passed skipped;
    }
  );

  evaluateTest = test: (
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

  # showTestResults = list[TestResult] -> str
  showTestResults = results: (
    let
      failed = lib.flatten (map (item: item.failed) results);
      passed = lib.flatten (map (item: item.passed) results);
      skipped = lib.flatten (map (item: item.skipped) results);

      numFailed = builtins.length failed;
      numPassed = builtins.length passed;
      numSkipped = builtins.length skipped;
      numTests = numFailed + numPassed + numSkipped;

      failedText =
        if numFailed > 0
        then
          "[FAIL] ${toString numFailed}/${toString numTests} tests failed\n"
          + failedMsg failed
        else "";
      skippedText =
        if numSkipped > 0
        then
          "[SKIP] ${toString numSkipped}/${toString numTests} tests skipped\n"
          + skippedMsg skipped
        else "";
      passedText = "[PASS] ${toString numPassed}/${toString numTests} tests passed\n";
      msg = failedText + skippedText + passedText;
    in
      msg
  );

  failedMsg = failed_tests: (
    builtins.foldl' (
      acc: result:
        acc
        + "    ${result.name}\n"
        + "         File:     ${builtins.toJSON result.path}\n"
        + "         Expected: ${builtins.toJSON result.expected}\n"
        + "         Actual:   ${builtins.toJSON result.actual}\n\n"
    ) ""
    failed_tests
  );

  skippedMsg = skipped_tests: (
    builtins.foldl' (
      acc: result: (
        let
          skipText =
            if result.skip != ""
            then result.skip
            else "skipIf: ?";
        in
          acc
          + "    ${result.name}\n"
          + "         Skipped:  ${skipText}\n"
          + "         File:     ${builtins.toJSON result.path}\n\n"
      )
    ) ""
    skipped_tests
  );
}
