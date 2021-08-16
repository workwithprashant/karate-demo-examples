import com.google.common.base.Functions;
import com.intuit.karate.*;
import com.intuit.karate.core.FeatureResult;
import com.intuit.karate.core.ScenarioResult;
import com.intuit.karate.core.Tag;
import com.intuit.karate.report.Report;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * The type Test runner.
 */
public class TestRunner {
    /**
     * The constant TEST_ID_PATTERN.
     */
    public static final String TEST_ID_PATTERN = "^([a-zA-Z]+-[0-9]+)(.*:).*";
    private static final Logger log = LoggerFactory.getLogger(TestRunner.class);

    private void generateDryRunReport(Results results) {
        Stream<FeatureResult> allFeatureResults = results.getFeatureResults();
        Iterator<FeatureResult> iterator = allFeatureResults.iterator();
        List<Map<String, String>> scnResults = new ArrayList<>();
        String testMgmtUrl = "https://jira.com/browse/"; // Dummy URL
        while (iterator.hasNext()) {
            FeatureResult frCurrent = iterator.next();
            String frLoc = frCurrent.getDisplayName();
            String frName = frCurrent.getFeature().getName();
            String featureId = "";
            if (frName.matches(TEST_ID_PATTERN)) {
                featureId = frName.replaceAll(TEST_ID_PATTERN, "$1");
                frName = frName.replaceAll("^([a-zA-Z]+-[0-9]+)(.*:)", "");
            }
            for (ScenarioResult srCurrent : frCurrent.getScenarioResults()) {
                String uniqueKey = String.format("%s:%s", frLoc.replace("/", "/ "), srCurrent.getScenario().getLine());
                String scnName = srCurrent.getScenario().getName();
                String testCaseId = "";
                if (scnName.matches(TEST_ID_PATTERN)) {
                    testCaseId = scnName.replaceAll(TEST_ID_PATTERN, "$1");
                    scnName = scnName.replaceAll("^([a-zA-Z]+-[0-9]+)(.*:)", "");
                }
                String scnDescription = srCurrent.getScenario().getDescription();
                List<Tag> scnTagsList = srCurrent.getScenario().getTags();
                List<String> scnTags = (scnTagsList == null || scnTagsList.isEmpty()) ? Collections.emptyList() : scnTagsList.stream().map(Functions.toStringFunction()).collect(Collectors.toList());
                Map<String, String> scnMap = new HashMap<>();
                scnMap.put("frLoc", uniqueKey);
                scnMap.put("frName", frName);
                scnMap.put("frId", featureId);
                scnMap.put("testCaseId", testCaseId);
                scnMap.put("scnName", scnName);
                scnMap.put("scnDescription", scnDescription);
                scnMap.put("scnTags", scnTags.isEmpty() ? "" : String.join(" ", scnTags));
                scnResults.add(scnMap);
            }
        }
        Map<String, Object> finalResults = new HashMap<>();
        finalResults.put("scnResults", scnResults);
        finalResults.put("testMgmtUrl", testMgmtUrl);
        File dryRunReportFile = Report.template("dryrun.scenarios.html")
                .resourceRoot("classpath:templates")
                .variables(finalResults)
                .reportDir(Paths.get("target", "karate-reports").toString())
                .build()
                .render();

        log.info("Dry Run report created at {}", dryRunReportFile.getAbsolutePath());
    }

    /**
     * Test parallel.
     */
    @Test
    public void testParallel() {
        Runner.Builder kBuilder = Runner
                .path("classpath:")
                .tags(Arrays.asList("demo3,demo2"))
                .dryRun(isDryRun());

        Results results = kBuilder
                .parallel(1);

        if(isDryRun()){
            log.info("Generating Dry Run Report");
            generateDryRunReport(results);
        }
    }

    /**
     * Instantiates a new Is dry run.
     *
     * @return the boolean
     */
    public boolean isDryRun() {
        HashMap<String, String> systemProperties = new HashMap(System.getProperties());
        String dryRun = systemProperties.getOrDefault("dryrun", "false");
        return dryRun.equalsIgnoreCase("true");
    }


}
