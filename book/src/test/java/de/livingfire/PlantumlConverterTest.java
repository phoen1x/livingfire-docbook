package de.livingfire;

import static org.assertj.core.api.Assertions.assertThat;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

public class PlantumlConverterTest {

    private PlantumlConverter converter;

    @Before
    public void setUp() {
        Path markdownPath = Paths.get("src/test/resources/plantuml.md");
        Path mediaPath = Paths.get("target");
        this.converter = new PlantumlConverter(markdownPath, mediaPath, true);
        this.converter.init();
    }

    @Test
    public void testGetHash() throws Exception {
        String expected = "74B87337454200D4D33F80C4663DC5E5";
        String actual = this.converter.getHash("aaaa");
        assertThat(expected).isEqualTo(actual);
    }

    @Test
    public void testInit() throws Exception {
        String contentExpected = new String(Files.readAllBytes(Paths.get("src/test/resources/plantuml.md")));

        assertThat(contentExpected).isEqualTo(this.converter.getMarkdownContent());

        Map<String, String> actual = this.converter.getReplacements();
        assertThat(actual).hasSize(2);
    }

    @Test
    public void testWritePlantuml() throws Exception {
        this.converter.writePlantuml();
    }

    @Test
    public void testBackupMarkdown() throws Exception {
        this.converter.backupMarkdown();
    }

    @Test
    public void testReplaceLinks() throws Exception {
        this.converter.replaceLinks();
    }
}
