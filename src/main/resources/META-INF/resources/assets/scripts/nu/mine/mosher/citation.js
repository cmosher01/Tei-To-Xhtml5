function copyToClipboard(t) {
    function listener(e) {
        e.clipboardData.setData("text/plain", t);
        e.preventDefault();
    }
    document.addEventListener("copy", listener);
    document.execCommand("copy");
    document.removeEventListener("copy", listener);

    alert("Citation copied to clipboard.");
};

function ns(p) {
    if (p === "xhtml") {
        return "http://www.w3.org/1999/xhtml";
    }
    return "";
}

function doCopy() {
    var e = document.evaluate("./xhtml:header[1]/xhtml:div[@tei='sourceDesc']", document.body, ns, XPathResult.ANY_TYPE, null);
    e = e.iterateNext();
    var t = e.innerText;
    t = t.replace(/[\n\r]/g, "");
    if (t.length == 0) {
        var d = new Date();
        d = d.toISOString();
        d = d.substring(0,10);
        t = "\u201C"+document.title+"\u201D ("+document.location+" : accessed "+d+").";
    }
    copyToClipboard(t);
}

function ready() {
    document.getElementById("urn:uuid:2329b6e3-7951-40c0-9855-976a2f6baa94").onclick = doCopy;
}

document.addEventListener("DOMContentLoaded", ready);
