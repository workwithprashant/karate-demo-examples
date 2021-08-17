# karate-demo-examples
This is an example of executing Karate tests using Dry Run option

### Without Dry Run
* Execute `mvn clean test` to run tests without Dry Run


### Dry Run (Default Report)
* Execute `mvn clean test -Dkarate.options="--dryrun"` **OR**  `mvn clean test -Dkarate.options="-D"`to generate dry run report without performing the tests
<br> **Note**: This will generate Karate Report at `target\karate-reports\karate-summary.html`

### Dry Run (Custom Report)
* Execute `mvn clean test -Ddryrun=true` to generate dry run report without performing the tests
<br> **Note**: This will generate Karate Report at `target\karate-reports\karate-summary.html` along with custom report using thymeleaf template at `target\karate-reports\dryrun.scenarios.html`