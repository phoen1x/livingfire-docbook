package de.livingfire;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import java.util.stream.Collectors;

import org.junit.Test;

public class MainTest {

    @Test
    public void testMain() throws Exception {
        String[] args = { "src/test/resources", "target", "noop" };
        Main.main(args);
    }

    @Test
    public void testGetMarkdownPaths() throws Exception {
        String[] args1 = null;
        assertThatThrownBy(() -> {
            Main.getMarkdownPaths(args1);
        }).isInstanceOf(RuntimeException.class)
          .hasMessageContaining("illegal parameter markdown path");

        String[] args2 = { "no/directory/here" };
        assertThatThrownBy(() -> {
            Main.getMarkdownPaths(args2);
        }).isInstanceOf(RuntimeException.class)
          .hasMessageContaining("unable to find path: no/directory/here");

        String[] args3 = { "src/test/resources" };
        String foundElements = Main.getMarkdownPaths(args3)
                                   .map(path -> path.toString())
                                   .collect(Collectors.joining());
        assertThat(foundElements).isEqualTo("src/test/resources/plantuml.md");
    }

    @Test
    public void testIsNoop() throws Exception {
        String[] args1 = null;
        boolean actual = Main.isNoop(args1);
        assertThat(actual).isEqualTo(false);

        String[] args2 = { "" };
        actual = Main.isNoop(args2);
        assertThat(actual).isEqualTo(false);

        String[] args3 = { "", "" };
        actual = Main.isNoop(args3);
        assertThat(actual).isEqualTo(false);

        String[] args4 = { "", "", "" };
        actual = Main.isNoop(args4);
        assertThat(actual).isEqualTo(false);

        String[] args5 = { "", "", "noop" };
        actual = Main.isNoop(args5);
        assertThat(actual).isEqualTo(true);

        String[] args6 = { "", "", "noop", "" };
        actual = Main.isNoop(args6);
        assertThat(actual).isEqualTo(true);
    }

    @Test
    public void testGetMediaPath() throws Exception {
        String[] args1 = null;
        assertThatThrownBy(() -> {
            Main.getMediaPath(args1);
        }).isInstanceOf(RuntimeException.class)
          .hasMessageContaining("illegal parameter media path");

        String[] args2 = { "" };
        assertThatThrownBy(() -> {
            Main.getMediaPath(args2);
        }).isInstanceOf(RuntimeException.class)
          .hasMessageContaining("illegal parameter media path");

        String[] args3 = { "", "no/path" };
        assertThatThrownBy(() -> {
            Main.getMediaPath(args3);
        }).isInstanceOf(RuntimeException.class)
          .hasMessageContaining("unable to find path: no/path");

        String[] args4 = { "", "target" };
        assertThat(Main.getMediaPath(args4)
                       .toFile()
                       .isDirectory()).isEqualTo(true);

    }

}
