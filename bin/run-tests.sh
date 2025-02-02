#!/usr/bin/env sh

# Synopsis:
# Test the test runner by running it against a predefined set of solutions 
# with an expected output.

# Output:
# Outputs the diff of the expected test results against the actual test results
# generated by the test runner.

# Example:
# ./bin/run-tests.sh
sqlite3 --version
exit 1
exit_code=0

# Iterate over all test directories
for test_dir in tests/*; do
    test_dir_name=$(basename "${test_dir}")
    test_dir_path=$(realpath "${test_dir}")

    bin/run.sh "${test_dir_name}" "${test_dir_path}" "${test_dir_path}"

    # OPTIONAL: Normalize the results file
    # If the results.json file contains information that changes between 
    # different test runs (e.g. timing information or paths), you should normalize
    # the results file to allow the diff comparison below to work as expected

    file="results.json"
    expected_file="expected_${file}"
    echo "${test_dir_name}: comparing ${file} to ${expected_file}"

    if ! diff "${test_dir_path}/${file}" "${test_dir_path}/${expected_file}"; then
        exit_code=1
    fi
done

exit ${exit_code}
