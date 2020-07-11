/*
    Tei-To-Xhtml5

    Copyright © 2017–2020, by Christopher Alan Mosher, Shelton, Connecticut, USA, cmosher01@gmail.com .

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/
package nu.mine.mosher.xml;

import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import java.io.*;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.stream.*;

public class TeiToXhtml5 {
    public static void transform(final BufferedInputStream inTei, final BufferedOutputStream outXhtml5) throws IOException, TransformerException, ParserConfigurationException, SAXException {
        final XsltPipeline pipeline = new XsltPipeline();

        pipeline.dom(inTei);
        pipeline.xslt(lib("xslt/tei-copyOf.xslt"));
        pipeline.xslt(lib("xslt/tei-facs.xslt"));
        pipeline.xslt(lib("xslt/tei-norm-text.xslt"));
        pipeline.xslt(lib("xslt/tei-xhtml-specific.xslt"));
        pipeline.xslt(lib("xslt/tei-xhtml-general.xslt"));
        pipeline.xslt(lib("xslt/tei-xhtml-page.xslt"));
        pipeline.serialize(outXhtml5);
    }

    public static String getCss() throws IOException {
        try (final BufferedReader css =
                 new BufferedReader(
                     new InputStreamReader(
                         TeiToXhtml5.class.getResourceAsStream("lib/css/tei.css"),
                         StandardCharsets.UTF_8))) {
            return css.lines().collect(Collectors.joining("\n"));
        }
    }

    public static void main(final String... args) throws IOException, TransformerException, ParserConfigurationException, SAXException {
        final List<String> ra = Arrays.stream(args).collect(Collectors.toUnmodifiableList());
        if (ra.contains("--help")) {
            System.out.println("usage: tei-to-xhtml5 <input.tei >output.xhtml5");
            System.out.println("       tei-to-xhtml5 --css >style.css");
        } else if (ra.contains("--css")) {
            System.out.println(getCss());
        } else {
            try (final BufferedInputStream in = new BufferedInputStream(new FileInputStream(FileDescriptor.in));
                 final BufferedOutputStream out = new BufferedOutputStream(new FileOutputStream(FileDescriptor.out))) {
                transform(in, out);
            }
        }
        System.out.flush();
    }

    private static URL lib(final String path) {
        return TeiToXhtml5.class.getResource("lib/" + path);
    }
}
