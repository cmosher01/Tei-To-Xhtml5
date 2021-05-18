# Tei-To-Xhtml5

Copyright © 2017–2020, by Christopher Alan Mosher, Shelton, Connecticut, USA, cmosher01@gmail.com .

[![License](https://img.shields.io/github/license/cmosher01/Tei-To-Xhtml5.svg)](https://www.gnu.org/licenses/gpl.html)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=CVSSQ2BWDCKQ2)

Generates XHTML5 web pages from TEI formatted documents.

---

Can be used as an API from another Java program, or run from the command line.

Build using JDK 11 or greater. Depends on Xerces and Saxon-HE (latest versions).

```sh
$ java -version
openjdk version "11.0.5" 2019-10-15 LTS
OpenJDK Runtime Environment Corretto-11.0.5.10.1 (build 11.0.5+10-LTS)
OpenJDK 64-Bit Server VM Corretto-11.0.5.10.1 (build 11.0.5+10-LTS, mixed mode)
$ git clone https://github.com/cmosher01/Tei-To-Xhtml5.git
$ cd Tei-To-Xhtml5
$ ./gradlew build
$ tar xf build/distributions/tei-to-xhtml5-1.0.0.tar
$ ./tei-to-xhtml5-1.0.0/bin/tei-to-xhtml5 --help
usage: tei-to-xhtml5 <input.tei >output.xhtml5
       tei-to-xhtml5 --css >style.css
```
