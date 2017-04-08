package de.livingfire;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.stream.Stream;

public class Main {

    public static void main(String[] args) {
        Path mediaPath = getMediaPath(args);
        boolean noop = isNoop(args);

        getMarkdownPaths(args).forEach(markdownPath -> {
            PlantumlConverter converter = new PlantumlConverter(markdownPath, mediaPath, noop);
            converter.init();
            converter.backupMarkdown();
            converter.writePlantuml();
            converter.replaceLinks();
        });
    }

    public static boolean isNoop(String[] args) {
        if ((args != null) && (args.length > 2)) {
            return "noop".equals(args[2]);
        }
        return false;
    }

    public static Path getMediaPath(String[] args) {
        if ((args == null) || (args.length < 2)) {
            throw new RuntimeException("illegal parameter media path");
        }
        Path mediaPath = Paths.get(args[1]);
        if (!mediaPath.toFile()
                      .isDirectory()) {
            throw new RuntimeException("unable to find path: " + mediaPath);
        }
        return mediaPath;
    }

    public static Stream<Path> getMarkdownPaths(String[] args) {
        if ((args == null) || (args.length < 1)) {
            throw new RuntimeException("illegal parameter markdown path");
        }
        Path markdownRootPath = Paths.get(args[0]);
        if (!markdownRootPath.toFile()
                             .isDirectory()) {
            throw new RuntimeException("unable to find path: " + markdownRootPath);
        }
        try {
            return Files.list(markdownRootPath)
                        .filter(path -> path.toString()
                                            .matches("^.+\\.md$"));
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
}
