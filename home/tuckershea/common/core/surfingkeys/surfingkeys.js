// sources
// https://gist.githubusercontent.com/kohane27/7e6a1553039d52e7c4c0e5a9573cb046
// https://gist.github.com/emraher/2c071182ce0f04f3c69f6680de335029

// ╭──────────────────────────────────────────────────────────────────────────────╮
// │  Compatibility Prefix                                                        │
// ╰──────────────────────────────────────────────────────────────────────────────╯
const {
  Hints,
  Visual,
  cmap,
  imap,
  iunmap,
  vmap,
  vunmap,
  map,
  unmap,
  removeSearchAlias,
  aceVimMap,
} = api;

// available keys
// unmap("J");
// unmap("K");

// ---- Settings ----
Hints.setCharacters("asdfgyuiopqwertnmzxcvb");

settings.defaultSearchEngine = "d";
settings.hintAlign = "left";
settings.focusAfterClosed = "last";
settings.modeAfterYank = "Normal";
settings.startToShowEmoji = 2;

// omnibar
settings.omnibarPosition = "bottom";
settings.tabsThreshold = 0;
settings.omnibarMaxResults = 20;
// settings.focusFirstCandidate = true;

// j/k scrolls step
settings.scrollStepSize = 240;

unmap("[[");
unmap("]]");
unmap(";m");
unmap(";fs");
unmap(";di");
unmap("O");
unmap("af");
unmap("C");
unmap("<Ctrl-h>");
unmap("<Ctrl-j>");
unmap("I");
unmap("gi");

// ╭──────────────────────────────────────────────────────────────────────────────╮
// │  Scroll Page / Element                                                       │
// ╰──────────────────────────────────────────────────────────────────────────────╯
map("<Ctrl-b>", "U");
unmap("U");

map("<Ctrl-f>", "A");
unmap("A");

map("<Ctrl-u>", "e");
unmap("e");

map("<Ctrl-d>", "d");
unmap("d");

unmap("u");

unmap("0");
unmap("$");
unmap(";w");
unmap("w");

// ╭──────────────────────────────────────────────────────────────────────────────╮
// │  Tabs                                                                        │
// ╰──────────────────────────────────────────────────────────────────────────────╯
unmap("yT");
unmap("gxt");
unmap("gxT");
unmap(";gt");
unmap(";gw");
unmap("W");
unmap("on");

// close current tab
map("q", "x");
unmap("x");

// open closed tab
map("Q", "X");
unmap("X");

// switch tab
map("h", "E");
unmap("E");
map("l", "R");
unmap("R");

// ╭──────────────────────────────────────────────────────────────────────────────╮
// │  Page Navigation                                                             │
// ╰──────────────────────────────────────────────────────────────────────────────╯
unmap("r");
unmap("gu");
unmap("g?");
unmap("g#");
unmap(";u");
unmap("<Ctrl-6>");

// edit current URL with vim and reload
map("gU", ";U");
unmap(";U");

// go page history previous/forward
map("H", "S");
unmap("S");
map("L", "D");
unmap("D");

// ╭──────────────────────────────────────────────────────────────────────────────╮
// │  Search selected with                                                        │
// ╰──────────────────────────────────────────────────────────────────────────────╯
unmap("sg");
unmap("sd");
unmap("ss");
unmap("sy");
unmap("sb");
unmap("se");
unmap("sw");
unmap("sh");

// ╭──────────────────────────────────────────────────────────────────────────────╮
// │  Clipboard                                                                   │
// ╰──────────────────────────────────────────────────────────────────────────────╯
// yank text
map("yy", "yv");
unmap("yv");

// yank multiple text
map("yY", "ymv");
unmap("ymv");

// yank link
map("yf", "ya");
unmap("ya");

unmap("yma");
unmap("ymc");
unmap("cq");
unmap("yc");
unmap("yc");
unmap("yq");
unmap("ys");
unmap("yj");
unmap("yh");
unmap("yf");
unmap("yp");
unmap("yd");
unmap(";pp");
unmap(";pj");
unmap(";pf");

// ╭──────────────────────────────────────────────────────────────────────────────╮
// │  omnibar                                                                     │
// ╰──────────────────────────────────────────────────────────────────────────────╯
// omnibar for opened tabs
// map("t", "T");
map("<Ctrl-g>", "T");
unmap("T");

// unmap("og"); // google
// unmap("od"); // ddg
unmap("ab");
unmap("om");
unmap("ob");
unmap("oe");
unmap("ow");
unmap("os");
unmap("ox");
unmap("oy");

// ╭──────────────────────────────────────────────────────────────────────────────╮
// │  Visual Mode                                                                 │
// ╰──────────────────────────────────────────────────────────────────────────────╯
vunmap("t");
vunmap("q");

vmap("v", "zv");

// ╭──────────────────────────────────────────────────────────────────────────────╮
// │  proxy                                                                       │
// ╰──────────────────────────────────────────────────────────────────────────────╯
unmap("spa");
unmap("spb");
unmap("spc");
unmap("spd");
unmap("sps");
unmap("cp");
unmap(";cp");
unmap(";ap");

// ╭──────────────────────────────────────────────────────────────────────────────╮
// │  Misc                                                                        │
// ╰──────────────────────────────────────────────────────────────────────────────╯

unmap(";t");
// unmap("si");
// unmap("ga");
// unmap("gc");
// unmap("gn");
// unmap("gr");

// ╭──────────────────────────────────────────────────────────────────────────────╮
// │  Settings                                                                    │
// ╰──────────────────────────────────────────────────────────────────────────────╯
unmap(";pm");
unmap(";e");

// ╭──────────────────────────────────────────────────────────────────────────────╮
// │  Chrome URLs                                                                 │
// ╰──────────────────────────────────────────────────────────────────────────────╯
unmap("gs");
unmap(";j");

// ╭──────────────────────────────────────────────────────────────────────────────╮
// │  Insert Mode                                                                 │
// ╰──────────────────────────────────────────────────────────────────────────────╯
// disable emoji
// iunmap(":");
iunmap("Alt-b");
iunmap("Alt-f");
iunmap("Alt-w");
iunmap("Alt-d");

// ---- Search Engines -----
// removeSearchAlias("d", "s");
// removeSearchAlias("g", "s");
removeSearchAlias("b", "s");
removeSearchAlias("h", "s");
removeSearchAlias("w", "s");
removeSearchAlias("y", "s");
removeSearchAlias("s", "s");

api.addSearchAlias('p', 'Nix Packages', 'https://search.nixos.org/packages?channel=24.05&from=0&size=50&sort=relevance&type=packages&query=', 'p', 'https://search.nixos.org/packages?channel=24.05&from=0&size=50&sort=relevance&type=packages&query=', function(response) {
    var res = JSON.parse(response.text);
    return res.map(function(r){
        return r.phrase;
    });
});

api.addSearchAlias('o', 'NixOS Options', 'https://search.nixos.org/options?channel=24.05&size=50&sort=relevance&type=packages&query=', 'o', 'https://search.nixos.org/options?channel=24.05&size=50&sort=relevance&type=packages&query=', function(response) {
    var res = JSON.parse(response.text);
    return res.map(function(r){
        return r.phrase;
    });
});

// ╭──────────────────────────────────────────────────────────────────────────────╮
// │  Theme (adopted from: https://github.com/Foldex/surfingkeys-config)          │
// ╰──────────────────────────────────────────────────────────────────────────────╯

// Nord
// Hints.style(
//   "border: solid 2px #4C566A; color:#A3BE8C; background: initial; background-color: #3B4252;"
// );
// Hints.style(
//   "border: solid 2px #4C566A !important; padding: 1px !important; color: #E5E9F0 !important; background: #3B4252 !important;",
//   "text"
// );
// Visual.style("marks", "background-color: #A3BE8C99;");
// Visual.style("cursor", "background-color: #88C0D0;");

// Doom One
Hints.style(
  "border: solid 2px #282C34; color:#EBCB8B; background: initial; background-color: #2E3440;"
);
Hints.style(
  "border: solid 2px #282C34 !important; padding: 1px !important; color: #51AFEF !important; background: #2E3440 !important;",
  "text"
);
Visual.style("marks", "background-color: #98be6599;");
Visual.style("cursor", "background-color: #51AFEF;");

// -----------------------------------------------------------------------------------------------------------------------
// // Surfingkeys: https://github.com/brookhong/Surfingkeys#properties-list
// // Dracula Theme: https://github.com/dracula/dracula-theme#color-palette
// -----------------------------------------------------------------------------------------------------------------------
// Map Keys
// -----------------------------------------------------------------------------------------------------------------------
// Change default search engine
//settings.defaultSearchEngine = "w";
// -----------------------------------------------------------------------------------------------------------------------
// Change hints styles
// -----------------------------------------------------------------------------------------------------------------------
api.Hints.characters = "asdfgqwertvbn";
api.Hints.style('border: solid 1px #ff79c6; color:#44475a; background: #f1fa8c; background-color: #f1fa8c; font-size: 10pt; font-family: "JetbrainsMono Nerd Font"');
api.Hints.style('border: solid 8px #ff79c6;padding: 1px;background: #f1fa8c; font-family: "JetbrainsMono Nerd Font"', "text");// -----------------------------------------------------------------------------------------------------------------------
// text-transform: lowercase;
// -----------------------------------------------------------------------------------------------------------------------
// Change search marks and cursor
// -----------------------------------------------------------------------------------------------------------------------
api.Visual.style('marks', 'background-color: #f1fa8c;');
api.Visual.style('cursor', 'background-color: #6272a4; color: #f8f8f2');
// -----------------------------------------------------------------------------------------------------------------------
// Change theme
// // Change fonts
// // Change colors
// -----------------------------------------------------------------------------------------------------------------------
settings.theme = `
.sk_theme input {
    font-family: "Jetbrains Mono";
}
.sk_theme .url {
    font-size: 8px;
}
#sk_omnibarSearchResult li div.url {
    font-weight: normal;
}
.sk_theme .omnibar_timestamp {
    font-size: 9px;
    font-weight: bold;
}
#sk_omnibarSearchArea input {
    font-size: 10px;
}
.sk_theme .omnibar_visitcount {
    font-size: 9px;
    font-weight: bold;
}
body {
    font-family: "Jetbrains Mono", Consolas, "Liberation Mono", Menlo, Courier, monospace;
    font-size: 10px;
}
kbd {
    font: 11px "Jetbrains Mono", Consolas, "Liberation Mono", Menlo, Courier, monospace;
}
#sk_omnibarSearchArea .prompt, #sk_omnibarSearchArea .resultPage {
    font-size: 10px;
}
.sk_theme {
    background: #282a36;
    color: #f8f8f2;
}
.sk_theme tbody {
    color: #ff5555;
}
.sk_theme input {
    color: #ffb86c;
}
.sk_theme .url {
    color: #6272a4;
}
#sk_omnibarSearchResult>ul>li {
    background: #282a36;
}
#sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #282a36;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #282a36;
}
.sk_theme .annotation {
    color: #6272a4;
}
.sk_theme .focused {
    background: #44475a !important;
}
.sk_theme kbd {
    background: #f8f8f2;
    color: #44475a;
}
.sk_theme .frame {
    background: #8178DE9E;
}
.sk_theme .omnibar_highlight {
    color: #8be9fd;
}
.sk_theme .omnibar_folder {
    color: #ff79c6;
}
.sk_theme .omnibar_timestamp {
    color: #bd93f9;
}
.sk_theme .omnibar_visitcount {
    color: #f1fa8c;
}

.sk_theme .prompt, .sk_theme .resultPage {
    color: #50fa7b;
}
.sk_theme .feature_name {
    color: #ff5555;
}
.sk_omnibar_middle #sk_omnibarSearchArea {
    border-bottom: 1px solid #282a36;
}
#sk_status {
    border: 1px solid #282a36;
}
#sk_richKeystroke {
    background: #282a36;
    box-shadow: 0px 2px 10px rgba(40, 42, 54, 0.8);
}
#sk_richKeystroke kbd>.candidates {
    color: #ff5555;
}
#sk_keystroke {
    background-color: #282a36;
    color: #f8f8f2;
}
kbd {
    border: solid 1px #f8f8f2;
    border-bottom-color: #f8f8f2;
    box-shadow: inset 0 -1px 0 #f8f8f2;
}
#sk_frame {
    border: 4px solid #ff5555;
    background: #8178DE9E;
    box-shadow: 0px 0px 10px #DA3C0DCC;
}
#sk_banner {
    border: 1px solid #8be9fd;
    background: rgb(139, 233, 253);
}
div.sk_tabs_bg {
    background: #f8f8f2;
}
div.sk_tab {
    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#6272a4), color-stop(100%,#44475a));
}
div.sk_tab_title {
    color: #f8f8f2;
}
div.sk_tab_url {
    color: #8be9fd;
}
div.sk_tab_hint {
    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#f1fa8c), color-stop(100%,#ffb86c));
    color: #282a36;
    border: solid 1px #282a36;
}
#sk_bubble {
    border: 1px solid #f8f8f2;
    color: #282a36;
    background-color: #f8f8f2;
}
#sk_bubble * {
    color: #282a36 !important;
}
div.sk_arrow[dir=down]>div:nth-of-type(1) {
    border-top: 12px solid #f8f8f2;
}
div.sk_arrow[dir=up]>div:nth-of-type(1) {
    border-bottom: 12px solid #f8f8f2;
}
div.sk_arrow[dir=down]>div:nth-of-type(2) {
    border-top: 10px solid #f8f8f2;
}
div.sk_arrow[dir=up]>div:nth-of-type(2) {
    border-bottom: 10px solid #f8f8f2;
}
#sk_omnibar {
    width: 100%;
    left: 0%;
}
}`;
