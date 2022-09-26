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

function doCopy() {
    const e = event || window.event;
    const source = e.target || e.srcElement;
    const idTarget = source.dataset.htmlFor;
    const elemTarget = document.getElementById(idTarget);
    var t = elemTarget.innerText;
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
    const r = document.getElementsByClassName("tei-button-copy");
    for (const i of r) {
        i.onclick = doCopy;
    }
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', ready);
} else {
  ready();
}
