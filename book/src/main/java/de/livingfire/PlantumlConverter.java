package de.livingfire;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.xml.bind.annotation.adapters.HexBinaryAdapter;

public class PlantumlConverter {

    private Path markdownPath;
    private Path mediaPath;
    private boolean noop;
    private Map<String, String> replacements;
    private String markdownContent;

    public PlantumlConverter(Path markdownPath,
                             Path mediaPath,
                             boolean noop) {
        this.markdownPath = markdownPath;
        this.mediaPath = mediaPath;
        this.noop = noop;
        this.replacements = new HashMap<>();
    }

    public void init() {
        try {
            this.markdownContent = new String(Files.readAllBytes(this.markdownPath));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        Matcher matcher = Pattern.compile("(```plantuml\\n)([^`]+)(```\\n)", Pattern.DOTALL)
                                 .matcher(this.markdownContent);
        while (matcher.find()) {
            String uml = matcher.group(2);
            this.replacements.put(getHash(uml), uml);
        }
    }

    public String getHash(String text) {
        byte[] hashBytes;
        try {
            hashBytes = MessageDigest.getInstance("MD5")
                                     .digest(text.getBytes());
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
        return (new HexBinaryAdapter()).marshal(hashBytes);
    }

    public void backupMarkdown() {
        Path backup = Paths.get("target/" + this.markdownPath.getFileName() + "." + new Date().getTime());
        try {
            if (this.noop) {
                System.out.println("\nnoop backup: " + backup);
                return;
            }
            Files.write(backup, this.markdownContent.getBytes());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public void writePlantuml() {
        this.replacements.keySet()
                         .forEach(key -> {
                             String uml = this.replacements.get(key);
                             String filePath = String.format("%s/%s.puml", this.mediaPath, key);
                             try {
                                 Files.write(Paths.get(filePath), uml.getBytes());
                             } catch (IOException e) {
                                 throw new RuntimeException(e);
                             }
                         });
    }

    public void replaceLinks() {
        String content = this.markdownContent;

        for (String key : this.replacements.keySet()) {
            String uml = this.replacements.get(key);
            String link = String.format("![uml](%s/%s.png)", this.mediaPath, key);
            content = content.replace("```plantuml\n" + uml + "```", link);
        }

        if (this.noop) {
            System.out.println("\nnoop replaceLink: \n" + content);
            return;
        }
        try {
            Files.write(this.markdownPath, content.getBytes());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public Map<String, String> getReplacements() {
        return this.replacements;
    }

    public String getMarkdownContent() {
        return this.markdownContent;
    }

}
