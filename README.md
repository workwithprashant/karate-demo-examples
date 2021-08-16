# karate-demo-examples
This is an example of executing Karate tests using Dry Run option

* Execute `mvn clean test` to run tests without Dry Run


* Execute `mvn clean test -Ddryrun=true` to generate dry run report without actually executing the tests
<br> **Note**: Report will be generated `target\karate-reports\dryrun.scenarios.html`