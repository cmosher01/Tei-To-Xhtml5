#!/bin/sh -ex

me="$(readlink -f "$0")"
here="$(dirname "$me")"

cd "$here"
./gradlew build
tar xf build/distributions/tei-to-xhtml5-*.tar
cd examples
../tei-to-xhtml5-*/bin/tei-to-xhtml5 --css >style.css
../tei-to-xhtml5-*/bin/tei-to-xhtml5 <sandes_henry_of_sonning_will_1569.tei.xml >sandes_henry_of_sonning_will_1569.xhtml
