# Pluto.jl — Comprehensive Feature List
# _Written by 🤖_
> Compiled from all merged pull requests (PRs #20–#3484) on the JuliaPluto/Pluto.jl repository.
> Goal: provide a reference for documentation coverage analysis.


> # HOW TO USE THIS:
> When a feature is documented, or if it does not need documentation, you can remove it from the list.


---

## 1. Reactivity & Execution Model
- **Cyclic dependency detection** — Pluto detects and reports cyclic cell dependencies. (#37)
- **Soft interrupt (all platforms)** — Clicking the stop button interrupts running cells on all OS, including Windows (via Malt.jl). (#932, #2659, #2767)
- **Cell queued state indicator** — Cells show a "queued" state while waiting to run. (#349)
- **Broken process detection & restart offer** — If the notebook process crashes, Pluto detects it and offers to restart. (#948)
---

## 2. Package Management (Built-in Pkg)

- **Guided Project.toml editor** — A UI for editing the notebook's `Project.toml` with compat entries. (#3218)
- **Auto-fix corrupted manifests** — When a notebook's manifest is broken, Pluto tries strategies to automatically fix it. (#2294, #2298)
- **GracefulPkg.jl integration** — Uses GracefulPkg.jl for safer, more user-friendly Pkg error handling. (#3185)
- **Show Pkg logs in Process Status tab** — Pkg operation logs are visible in the dedicated Process Status panel. (#2498)

---

## 3. Editor / Code Editing

- **CodeMirror 6 editor** — The code editor uses CodeMirror 6 with full Julia syntax support. (#1159, #2107)
- **Julia syntax highlighting** — Julia code is highlighted using a custom Lezer-based Julia grammar. (#1830, #2980)
- **Mixed language highlighting** — Syntax highlighting inside `html"..."`, `md"..."`, and JavaScript/Python/SQL strings. (#1533, #1855)
- **Line numbers** — Code cells show line numbers in the gutter. (#1835)
- **Line wrapping** — Optional line wrapping for long lines, tab-aware. (#1876, #2899)
- **Rectangular selection** — Hold Alt/Option to make rectangular (column) selections. (#1545)
- **Multi-cursor editing** — Support for multiple cursors with Tab key. (#3066)
- **Autocomplete** — Context-aware completion for Julia identifiers, methods, keywords. (#606, #689)
- **Fuzzy autocomplete** — Completions use fuzzy matching for more forgiving search. (#689, #3207)
- **Autocomplete on type (default on Mac)** — Completions appear automatically as you type without pressing Tab. (#2389, #2942)
- **Local variable autocomplete** — Autocompletion includes local variables in scope. (#1925, #3151)
- **Globals from other cells in autocomplete** — Unsubmitted definitions from other cells appear in autocomplete. (#3056)
- **Keyword argument completions** — Keyword arguments are shown in autocomplete with boosted priority. (#2863)
- **Path autocomplete** — File paths are completed in string literals. (#1749, #2949)
- **Dict key autocomplete** — Dictionary keys are suggested in bracket completions. (#1749)
- **Package name autocomplete** — Typing `import Plu` completes to package names from the full package list. (#3245)
- **Unicode symbol autocomplete** — Tab-complete `\alpha` → `α`, `\:smile:` → emoji. (#153, #1485, #2876)
- **Unicode preview in autocomplete** — The rendered Unicode symbol is shown in the completion popup. (#2285)
- **Multichar superscript/subscript autocomplete** — Autocomplete for multi-character LaTeX-like superscripts/subscripts. (#3271)
- **Autocomplete in strings and comments with Tab** — Tab still triggers autocomplete inside strings and comments. (#2892)
- **Latex reverse search in Live Docs** — Type a Unicode character and see its LaTeX equivalent. (#2476)
- **Autocomplete 15x faster** — Major performance improvement for autocomplete response times. (#2857)
- **Keyword completion from Julia stdlib** — Julia keywords appear in autocomplete. (#2877)
- **`public` over `exported` in autocomplete** — Autocomplete uses the `public` keyword (Julia 1.11+) for ranking. (#3058)
- **Jump to definition** — `Ctrl+Click` (or `Cmd+Click`) on a variable jumps to the cell where it's defined. (#1144)
- **Jump to definition for cyclic/multiple-def errors** — Error messages for cyclic dependencies include links to the defining cells. (#1154)
- **Live Docs** — A panel shows documentation for the identifier under the cursor, updated live. (#547, #1471)
- **Live Docs tabs** — Live Docs is part of a tabbed panel (also containing Process Status). (#2376)
- **Live Docs: query suggestions** — Suggestions appear in the search box when the docs panel is open. (#2282)
- **Live Docs: keyword docs** — Built-in Julia keywords (like `for`, `if`) show documentation. (#2361)
- **Live Docs: pop out into picture-in-picture** — On Chrome, the Live Docs tab can be popped out into a floating picture-in-picture window. (#3053)
- **Ctrl+/ to comment/uncomment lines** — Toggles line comments, matching line indentation. (#469)
- **Ctrl+M to toggle Markdown mode** — Shortcut to quickly switch a cell to Markdown. (#390)
- **Shift+Enter to run selected cells** — Keyboard shortcut to run currently selected cells. (#602)
- **Alt+Arrow to move cells** — Move cells up/down with keyboard shortcut. (#2760)
- **Keyboard shortcut for folding cell** — Platform-appropriate shortcuts to fold/unfold cells (`⌥⌘[` on Mac, `Ctrl+Shift+[` on Windows/Linux). (#2922)
- **Keyboard shortcuts displayed in tooltips** — Tooltips on buttons show keyboard shortcuts. (#2638)
- **Wrapping selection in brackets** — Pressing `(`, `[`, `{` when text is selected wraps selection in brackets. (#757)
- **Holding arrow keys stops at cell boundaries** — Navigation respects cell boundaries when holding arrow keys. (#1748)
- **CodeMirror lazy loading** — CodeMirror instances are created lazily as cells scroll into view, for faster page load. (#2885)
- **Spellcheck toggle** — Hidden function `PLUTO_TOGGLE_CM_SPELLCHECK` enables spellchecking in code cells. (#2788)
- **Constant variable coloring** — `const` assigned variables are highlighted with a distinct color. (#2733)
- **JuliaSyntax.jl integration** — Uses JuliaSyntax.jl for more accurate parsing and error messages. (#2526)
- **Syntax error diagnostics** — Syntax errors are shown as inline diagnostics in the editor. (#2820)

---

## 4. Cell Features

- **Add/delete cells** — Cells can be added and deleted via the UI or keyboard shortcuts. (#37)
- **Fold/hide cells** — Cell code can be folded (hidden) while keeping the output visible. (#484)
- **Run button per cell** — Each cell has a run button, and shows its last execution time. (#37)
- **Copy output button** — Context menu item to copy cell output to clipboard. (#2160)
- **Cell context menu** — Right-click a cell to get a context menu with actions. (#2759)
---

## 5. @bind and Interactivity

- **`@bind` macro** — Bind Julia variables to HTML input elements for interactive notebooks. (#86)
- **Reactive `@bind`** — Changing a bound input re-runs all dependent cells. (#86)
- **`@bind` with date/time inputs** — Works with `<input type=date>`, `<input type=range>`, etc. (#453)
- **Bond value sent as Uint8Array** — File inputs send data as efficient binary arrays. (#439)
- **Interactive `@bind` in static preview** — Static HTML exports allow interactive `@bind` widgets when connected to a PlutoSliderServer. (#988)
- **Greyed-out bonds in static HTML** — Bonds in static HTML without a slider server are visually greyed out with an explanation. (#2047)
- **Slider server running status** — Cells that are updated by a PlutoSliderServer appear in a "running" state. (#2601)
- **Skip intermediate bond values** — When rapidly moving a slider, intermediate values are skipped for performance. (#1892, #2992)
- **Send queued bond changes when notebook is idle** — Bond updates are batched and sent when no cells are running. (#1898)
- **Bond-defining-bond support** — A bond's value can depend on another bond (for PlutoSliderServer). (#3158)
- **`possible_bond_values`** — API for widgets to declare their possible values (used by PlutoSliderServer). (#1600, #1703, #1763)
- **AbstractPlutoDingetjes.jl integration** — Package for widget authors to declare initial values, transformations, and more. (#1612)
- **`publish_to_js` / Julia→JS data API** — API to pass Julia data to JavaScript in cell output. (#1124, #1719, #1721, #2608)
- **`publish_to_js` in logs** — `publish_to_js` works inside log messages. (#2607)
- **`with_js_link`** — JavaScript API to request calculations and data from Julia dynamically (lazy loading). (#2726, #2780)

---

## 6. Output Display & Rendering

- **Rich output display** — Cells show the richest available MIME type (HTML, SVG, PNG, text). (#37)
- **Tree viewer** — Structs, dicts, arrays, and other objects are shown in an interactive expandable tree view. (#635, #804, #1094)
- **Tree viewer: lazy load more items** — Large collections show a "More" button to load additional items. (#638, #2792)
- **Tree viewer: compact types** — Type information in the tree viewer is shown compactly. (#1094)
- **Tree viewer: keyboard navigation** — The tree viewer can be navigated with the keyboard. (#2996)
- **Tree viewer: limit `<pre>` size** — Long `<pre>` elements inside collapsed tree nodes are truncated. (#2451)
- **Interactive table viewer** — DataFrames and any `Tables.jl`-compatible table are shown in a scrollable, interactive table. (#646)
- **Table sticky headers** — The column names and types row is sticky while scrolling. (#672, #729)
- **Tables.jl display improvements** — Fixed display for `Vector{Dict}`, `KeyedArray`, `DimensionalData.DimVector`, etc. (#2438, #3075, #3406)
- **`embed_display` / embeddable viewer** — Pluto's object viewer can be embedded inside custom HTML output. (#1126, #1776)
- **`DivElement` / `Div` component** — A Julia struct that renders as an HTML div with embedded output. (#1513, #1605, #1805)
- **MsgPack for binary data** — Binary data (images, etc.) is transferred using MsgPack for speed. (#285, #2331)
- **Plotly support** — Plotly.js plots rendered correctly in Pluto. (#213)
- **GR/Plots.jl: SVG vs PNG auto-selection** — GR backend uses SVG for small plots, PNG for large; respects `:fmt` setting. (#1090, #2266)
- **LaTeXString support** — `LaTeXString` objects are rendered with MathJax. (#381, #1164)
- **LaTeXString in logs** — Logging a `LaTeXString` renders it with math. (#2894)
- **MathJax 3 for math rendering** — MathJax 3 renders LaTeX math in Markdown and outputs. (#1947, #2165, #2803)
- **Lazy MathJax loading** — MathJax is loaded lazily to improve page load time. (#1947)
- **SVG display fix** — SVG outputs are correctly displayed in cells. (#261)
- **ImageShow.jl compatibility** — Disables ImageShow.jl's HTML show method to avoid conflicts with Pluto's display. (#2108)
- **fallback to `text/plain`** — If rich display fails, Pluto falls back to text/plain output. (#2109)
- **ANSI colored output for stdout** — Captured stdout with ANSI color codes is rendered in color. (#2148, #3222, #3225)
- **MIMEs.jl for MIME type handling** — Uses MIMEs.jl for MIME type resolution. (#2004)
- **Rich MIME override** — Downstream packages can override which MIME type is used for output. (#2299)
- **Stack traces: code preview and design** — Stack traces show a code preview, URLs, and are truncated for readability. (#2813)
- **Stack traces: package name shown** — The package that threw an error is identified in the stack trace header. (#3041)
- **Stack traces: hidden by default** — Stack traces are collapsed by default to make errors less intimidating. (#3267)
- **Stack traces: motivational words** — A small chance of showing an encouraging message above error output. (#3040)
- **Stack traces: bracket-matched type shortening** — Long type signatures in stack traces are shortened using bracket matching. (#3045)
- **Stack traces: color from Julia** — Julia can write color to the error message output. (#3046)
- **Improved UndefVarError** — Better error message for undefined variable errors. (#3392)
- **Hide UndefVarError for upstream errors** — If a cell errored because of an upstream cell's error, the UndefVarError is hidden. (#2057)
- **Error message title** — Error messages show a title ("Error message from PackageName"). (#3041)
- **`<details>` / `<summary>` CSS** — Built-in CSS styles for `<details>` and `<summary>` HTML elements. (#2814)
- **`open external links in new tab`** — External links in cell output open in a new browser tab. (#1916)
- **Display improvements for `Set` type** — Set data is shown using the tree viewer. (#926)
- **Disable data viewer for some types** — `Symbolics.Arr` and similar types can opt out of the tree viewer. (#1299)
- **Disabling struct display** — `PlutoRunner.use_tree_viewer_for_struct` can disable tree viewer per type. (#2493)
- **32-bit system support** — Display and math work correctly on 32-bit systems (e.g., Raspberry Pi). (#740)

---

## 7. Logging

- **Julia Logging integration** — `@info`, `@warn`, `@error`, `@debug` messages appear in notebook cell output. (#437)
- **Logs relayed to browser console** — Log messages also appear in the browser developer console. (#496)
- **Log level display** — Different log levels are styled differently. (#498)
- **Vertical log layout** — Logs are displayed vertically below cell output. (#2297)
- **Logs from async cells at source** — Log messages from async code appear under the correct cell. (#2115)
- **Scoped loggers per cell** — Each cell has its own logger context for correct attribution. (#2249)
- **`maxlog` keyword support** — The `maxlog` keyword in `@info` is respected to limit repeated log messages. (#1877, #1911, #2493)
- **ProgressLogging support** — `ProgressLogging.@progress` shows progress bars in the notebook. (#2222, #2966)
- **Custom progress bar names** — Custom names for progress bars from `@progress` are shown. (#2966)
- **Show `stdout` and `stderr` in notebook** — Print statements go to a terminal-style output popup instead of the terminal. (#1957)
- **Stdout popup generalized** — Popup system generalized to support multiple popup types. (#1956)
- **Stdout logging scoped per notebook** — Log channels are scoped to individual notebooks. (#2027)
- **`yield()` around logger redirect** — Fixed a bug where logs got stuck by adding yields. (#2026)
- **Log message format for exceptions** — Exception and backtrace in logs are formatted like errors. (#1962)
- **Fallback for errors in logging** — If logging itself throws, the error is handled gracefully. (#3013)
- **Fix logging with ProgressLogging v1.6** — Compat fix for the latest ProgressLogging. (#3440)

---

## 8. HTML Export & Static Notebooks

- **"View code" button in static export** — A button in the static HTML allows reading hidden/folded code. (#3313)

---

## 10. Main Menu / Welcome Screen

- **Main menu / welcome screen** — The Pluto start page where you can open, create, or browse notebooks. (#37)
- **Featured notebooks** — The main menu showcases curated notebooks from the Pluto community. (#2048, #2666, #2927)
- **Featured notebooks: SliderServer integration** — Featured notebooks use a PlutoSliderServer for interactive previews. (#2666)
- **Recents list** — Recently opened notebooks are shown on the main menu. (#37)
- **Recents: shortest unambiguous path** — Recent notebooks are shown with the shortest unambiguous path. (#693)
- **Recents: forget stale entries** — A button removes stale/non-existent notebooks from the recents list. (#3268)
- **Loading screen on navigation** — A loading indicator appears when navigating away from the main menu. (#2292)
- **File picker autocomplete** — The file path input on the welcome screen autocompletes file paths. (#2037, #3217, #3347)
- **Fuzzy autocomplete in file picker** — The file picker uses fuzzy matching for completions. (#3217)
- **"Open" button disabled when nothing typed** — The "Open" button is disabled until a path is entered. (#2020)
- **Paste/drop `.jl` files to open** — You can paste or drop a `.jl` file onto the welcome screen to open it. (#1015)
- **Open notebooks without browser** — `Pluto.run(notebook="path.jl")` opens a notebook without launching a browser. (#1324)
- **Open multiple notebooks at start** — Multiple notebooks can be passed to `Pluto.run()` to open on startup. (#1324)
- **`as_sample` URL parameter** — A notebook can be opened as a read-only sample by adding `?as_sample=yes` to the URL. (#828)
- **Featured notebook sources configurable** — The source of featured notebooks is a configurable frontend parameter. (#2412)
- **Multiple authors in featured card** — Featured notebook cards show "and others" for multiple authors. (#2723)

---

## 11. Notebook Files & Format

- **`.jl` notebook file format** — Pluto notebooks are plain Julia files, valid Julia scripts. (#37)
- **Auto-save on run** — The notebook file is saved every time a cell is run. (#37)
- **Default save location** — Notebooks are saved in `~/.julia/pluto_notebooks` by default. (#475)
- **Auto-reload from file** — Pluto watches the notebook file for external changes and reloads automatically. (#1029, #1555)
- **Improved auto-reload** — Smarter timing avoids triggering reload from Pluto's own saves. (#1555)
- **Don't save on bond changes** — Notebook file is not rewritten when bonds change (only on cell runs). (#2402)
- **Option to disable writing to file** — `disable_writing_notebook_file` option prevents Pluto from saving changes to disk. (#1047, #1717)
- **Don't overwrite file on save error** — If a save fails, the existing file is preserved. (#976)
- **Cell order is explicit** — The notebook file includes an explicit `Cell order:` section. (#37)
- **Recover cells missing from cell order** — Cells in the file but not in cell order are recovered on load. (#1772)
- **More stable file parsing when cell order is missing** — Notebook loading is more resilient to missing cell order sections. (#3285)
- **Compare metadata when reloading** — Notebook comparison considers cell metadata when checking for changes. (#2291)
- **Update disabled cell dependency before saving** — Indirect dependencies of disabled cells are computed before saving. (#2239)
- **Notebook metadata** — A `metadata` field in the notebook structure stores notebook-wide settings. (#2016)
- **`skip_as_script` cells** — Cells can be marked to be skipped when the notebook file is used as a Julia script. (#2018, #2178, #2191)
- **End-of-file line break** — Notebook files always end with a newline. (#1578)
- **Remove trailing/leading quotes from path** — Paths pasted with surrounding quotes are cleaned up. (#1640)
- **JuliaFormatter ignore `@bind`** — JuliaFormatter is configured to not reformat `@bind` macros. (#3072)
- **`Pluto.is_single_expression` API** — Julia function to check if a string contains a single expression (as Pluto requires per cell). (#3134)
- **Pluto Recording format** — A special file format for recording notebook sessions as interactive replays. (#1623)

---

## 12. JavaScript / HTML API for Notebooks

- **JavaScript in cells** — Cells can output raw HTML with `<script>` tags that execute JavaScript. (#582)
- **`document.currentScript`** — Scripts in cells have access to `document.currentScript` for self-reference. (#1765)
- **`this` persistence** — JavaScript `this` inside `<script>` tags persists across re-runs, enabling stateful JS. (#582)
- **ObservableHQ stdlib** — The Observable HQ standard library (`DOM`, `html`, `svg`, `FileAttachment`, etc.) is available in cell JavaScript. (#582)
- **Lodash available in userland JS** — The Lodash library (`_`) is available in user JavaScript. (#3253)
- **`@htl` for HTML interpolation** — HypertextLiteral.jl's `@htl` macro for safe HTML interpolation. (#582)
- **Pluto object viewer as embeddable element** — `<pluto-display>` element embeds Pluto's output viewer inside custom HTML. (#1126)
- **`invalidation` promise** — A promise that resolves when a cell is about to re-run, for cleanup. (#582)
- **`pluto_get_message_log()`** — Debug function in JS console to get the 100 most recent server messages. (#2926)
- **JS API for `getInputValue` / `setInputValue`** — Functions to get/set bond input values programmatically. (#1755)
- **JS API for cell metadata** — Experimental API to get/set cell metadata from JavaScript. (#2612)
- **JS API for notebook metadata** — JavaScript API to read/write notebook-level metadata. (#2612)
- **`highlight.js` exposed on window** — `hljs` is attached to `window`, allowing custom language registration. (#2244)
- **Session event listeners (frontend extension API)** — External environments can listen to Pluto lifecycle events from the frontend. (#1742)
- **Server event listeners API** — Backend event listener interface for integration by hosting environments. (#1782, #1871)
- **`pluto_server_url` page parameter** — A URL parameter to explicitly tell the frontend where the WebSocket server is. (#2570)
- **`<pluto-editor>` web component** — The Pluto editor is a web component (`<pluto-editor>`) that can be embedded in a page. (#1976)
- **`pluto-editor` embeddable inside Pluto** — The `<pluto-editor>` component can be embedded inside another Pluto notebook. (#3169)

---

## 13. Collaboration & Sharing

- **Secret token for access control** — Pluto generates a secret token to prevent unauthorized access on multi-user computers. (#529)
- **Secret printed to console if page accessed without it** — If you access Pluto without the secret, the server prints it to the console. (#2322)
- **Prevent secret leaking to cross-origins** — The `Referrer-Policy` is set to prevent leaking the secret to CDN/third-party requests. (#722)
- **Binder integration** — Notebooks include a "run on Binder" button for one-click cloud execution. (#811, #429)
- **Token in Binder URL** — On Binder, the token is embedded in the URL so it can be shared. (#429)
- **Binder progress and logs** — Binder launch progress and logs are shown in the Process Status tab. (#2523)
- **`open_url` / data URLs** — Pluto can open notebooks from URLs or data URLs directly. (#1670)
- **GitHub raw link support** — Opening a GitHub raw link opens the notebook directly. (#493)
- **PlutoSliderServer support** — Pluto supports PlutoSliderServer.jl for hosting interactive static notebooks. (#988, #1703, #2014)
- **Slider server POST request** — Notebooks can be configured to force POST requests to the slider server. (#2362)
- **`slider_server_url` in export JSON** — The slider server URL can be specified in the `pluto_export.json` file. (#2667)
- **Bond names API** — A function exposes the list of bond variable names for SliderServer. (#2379)
- **Upload to pluto.land** — A button in the export menu uploads the notebook directly to https://pluto.land. (#3360)

---

## 14. Server Configuration & API

- **`Pluto.run()` entry point** — Start the Pluto server with `Pluto.run()`. (#37)
- **`Pluto.run!()` non-blocking API** — Non-blocking version that returns a server reference. (#2643)
- **Automatic port selection** — Pluto finds an available port automatically if the default is taken. (#266)
- **Custom port hint** — You can set a custom starting port for automatic port selection. (#2173)
- **Custom host** — `Pluto.run(host="0.0.0.0")` to bind to a specific interface. (#310)
- **Custom base URL** — `Pluto.run(base_url="/custom/path/")` for reverse proxy setups. (#2227)
- **Auto-launch browser** — Pluto opens the browser automatically when started. (#190)
- **WSL path support** — Pluto handles Windows Subsystem for Linux path conversions. (#520, #2085, #2219)
- **IPv6 address support** — IPv6 host addresses are printed with square brackets. (#608)
- **Configuration system** — Pluto uses Configurations.jl for structured configuration options. (#367, #1117)
- **Compiler options** — Configure Julia compiler flags (threads, heap size, optimization level, sysimage, etc.) for the notebook process. (#2455, #2456, #2774, #3362)
- **`JULIA_NUM_THREADS` support** — Pluto respects and passes `JULIA_NUM_THREADS` including `auto`. (#616, #990, #1814, #2263)
- **`workspace_custom_startup_expr`** — Option to run custom Julia code when the notebook workspace starts. (#2654)
- **`capture_stdout` option** — Option to enable/disable stdout capture. (#2022)
- **`dismiss_motivational_quotes` option** — Option to disable the motivational words on error messages. (#3197)
- **`extra_instrumentation_lines` / HTML injection** — Option to inject HTML at the top of the notebook for custom deployments. (#1683)
- **Hide banner in CI** — Pluto detects the `CI` environment variable and suppresses the startup banner. (#1868)
- **Display banner from `__init__`** — The banner is shown at load time, not during precompilation. (#2628)
- **Separate notebook boot environment** — The notebook's boot environment is separate from the server environment to avoid conflicts. (#1556)
- **Session event API** — `SessionActions` API for programmatically opening, closing, and managing notebooks. (#1644)
- **`POST /notebookupload` with custom filename** — The notebook upload endpoint accepts a custom filename parameter. (#2051)
- **State file export endpoint** — `/statefile?id=<session-id>` exports the notebook state as a MessagePack binary. (#1118)
- **Pluto inside Pluto** — Run a Pluto server inside a Pluto notebook. (#1192)
- **Desktop app support** — Changes to support the PlutoDesktop Electron app, including filesystem API integration. (#2177, #2651)
- **RelocatableFolders for sysimage support** — Pluto can be bundled into a system image. (#1853)
- **`cpu_target` option for Malt worker** — Pass `--cpu-target` to the notebook Julia process. (#3362)
- **Server start event** — An event fires with the server's web address after startup. (#1882)
- **Warn when using future Julia versions** — Pluto warns if the Julia version is newer than supported. (#3113, #3205)
- **Warn when Julia version is before 1.10** — Users on old Julia versions get a deprecation warning. (#3049)
- **`LOAD_PATH` preserved** — The original `LOAD_PATH` is preserved in the notebook process. (#2748)

---

## 15. Performance

- **Malt.jl process management** — Replaced Distributed.jl with Malt.jl for faster, cleaner process management. (#2240)
- **Run process start and Pkg init in parallel** — These two startup tasks run concurrently, saving ~10 seconds. (#2406)
- **Precompile with `PrecompileTools.jl`** — Uses `PrecompileTools.@precompile_all_calls` for better precompilation. (#2441, #2534)
- **Precompile statements for SessionActions** — Precompile directives reduce time-to-first-X for opening notebooks. (#1934, #1977)
- **`Base.Experimental.@max_methods 1`** — Reduces method invalidations for faster compilation. (#2068)
- **Fix method invalidations around `Base.convert`** — 750+ method invalidations eliminated. (#2300)
- **State diffing performance** — Lazy dictionaries and immutable comparison for faster notebook state diffing. (#2072, #2073)
- **`@bind` 5x speedup** — Caching in `update_dependency_cache!` makes bond updates 5x faster. (#2080)
- **Autocomplete 15x faster** — Latex/emoji completions done client-side in JS. (#2857, #2876)
- **Large notebook speedups** — Fixed cache miss in `notebook_to_js`, LRU cache for topology, skipping unneeded updates. (#2973, #2974, #2976, #3164, #3165)
- **State update throttle rework** — Background status sync is throttled more intelligently. (#2979, #2981)
- **Delete stale connections** — Disconnected clients are cleaned up to avoid performance degradation. (#2977)
- **Faster PlutoRunner process init** — Loader optimization speeds up workspace creation. (#3402)
- **`deep_enough_copy` optimization** — Uses `@generated` for faster notebook state copying. (#2974)
- **CSS animation performance** — Replaced CSS `top/left` animations with `translateY` for GPU compositing. (#634, #912, #1945)
- **Don't render loading bar animation when idle** — Avoids unnecessary repaints. (#3239)
- **CodeMirror lazy loading** — Code editors are created lazily as cells scroll into view. (#2885)
- **Reduce overspecializations** — Reduced type specializations in PlutoRunner for smaller compilation footprint. (#2062)
- **Preload statefile in static HTML** — Avoids double download of the statefile on page load. (#2887)

---

## 16. Accessibility & Keyboard Navigation

- **Tab-friendly export menu** — The export menu uses `<dialog>` for proper keyboard accessibility. (#2750)
- **Tab-friendly Pkg popup** — The Pkg popup supports keyboard navigation. (#2752)
- **Tab-friendly cell context menu** — The cell context menu supports keyboard navigation. (#2759)
- **Tab trap help message** — When the Tab key is trapped in a code cell, a help message explains how to escape. (#2746)
- **Tab indexing improvements** — The "add cell" button appears only once in the tab order. (#2744)
- **Screen reader support** — When cell output changes, a screen reader announcement is made. (#2757)
- **Progress bar hidden from screen readers** — The top progress bar is hidden from screen reader users. (#2758)
- **ARIA improvements** — Various ARIA attributes added for better accessibility. (#2766)
- **Touch display button visibility** — All buttons are always visible on touch/coarse-pointer devices. (#378, #2745)
- **Touch: pointer vs any-pointer CSS** — Uses `pointer:coarse` instead of `any-pointer:coarse` for better detection. (#2631)

---

## 17. Internationalization (i18n)

- **UI translation system** — Pluto's UI text can be translated to different languages. (#3307)
- **Auto-detect user language** — The UI language is automatically detected from the browser's language settings. (#3327)
- **Dutch translation** — Dutch (Nederlands) UI translation. (#3311, #3335)
- **German translation** — German (Deutsch) UI translation. (#3325, #3334, #3417)
- **Norwegian translation** — Norwegian (Bokmål) UI translation. (#3329, #3417)
- **French translation** — French (Français) UI translation. (#3333, #3464)
- **Greek translation** — Greek (Ελληνικά) UI translation. (#3308, #3331, #3353)
- **Polish translation** — Polish (Polski) UI translation. (#3324)
- **Finnish translation** — Finnish (Suomi) UI translation. (#3337)
- **Czech translation** — Czech (Čeština) UI translation. (#3461)
- **Danish translation** — Danish (Dansk) UI translation. (#3422)
- **Spanish translation** — Spanish (Español) UI translation. (#3418)
- **Italian translation** — Italian (Italiano) UI translation. (#3363)
- **Simplified Chinese translation** — Simplified Chinese (中文) UI translation. (#3379)
- **Japanese translation** — Japanese (日本語) UI translation. (#3341)
- **Portuguese (PT-pt) translation** — Portuguese from Portugal UI translation. (#3352)
- **Farsi/RTL support** — Initial right-to-left layout support for Farsi. (#3350)
- **Removed i18next dependency** — The i18next library was replaced with a minimal custom implementation. (#3428)
- **Machine translatability improvements** — `lang` and `translate` HTML attributes improved for machine translation. (#3328)
- **`lang` attribute set dynamically** — The `<html lang="">` attribute reflects the UI language. (#3330)

---

## 18. Dark Mode & Themes

- **Dark mode** — Pluto has a built-in dark mode that can be toggled. (#1661)
- **CSS variable-based theming** — Colors are defined using CSS variables for easy theme customization. (#1661)
- **Syntax highlighting colors update** — Colors defined with `oklch`, improved command/type/string highlighting. (#3017)

---

## 19. Fonts & Typography

- **JuliaMono font** — JuliaMono is the default monospace font, with full Julia unicode character support. (#364, #1286, #3223, #3450)
- **Alegreya Sans for body text** — Alegreya Sans is used for Markdown body text with proper sizing. (#2896)
- **Font size rework** — Alegreya Sans font size rescaled for better consistency with fallback fonts. (#2896)
- **Ligatures support** — Font ligatures are enabled correctly. (#590)
- **Remove Woff v1 imports** — Unused Woff v1 font files removed from bundle to save 1MB. (#3458)

---

## 20. Sample Notebooks

- **Sample notebooks included** — Pluto ships with several built-in sample notebooks. (#144, #272, #639)
- **"Getting started" sample** — A beginner-friendly introduction notebook. (#272)
- **"Basic mathematics" sample** — A math-focused sample notebook. (#639)
- **"Tower of Hanoi" sample** — An interactive animation sample. (#737, #909)
- **"Plots" sample** — A notebook demonstrating plotting in Julia. (#1903)
- **"JavaScript API" sample notebook** — Documents Pluto's JavaScript API with examples. (#1184, #1228, #1761, #1762)
- **Offline Markdown sample** — A Markdown demo notebook that works without internet. (#2690)
- **Featured notebooks from plutojl.org/docs** — Featured notebook list includes docs notebooks. (#2927)

---

## 21. Process Status Tab

- **Process Status tab** — A panel showing what is currently loading, running, or compiling. (#2399, #2376)
- **Task failures shown in red** — Failed tasks in the Status tab are highlighted in red. (#2858)
- **Show Pkg logs in Process Status** — Pkg operation logs appear in the Status tab. (#2498)
- **Binder progress in Status tab** — Binder launch steps are shown in the Status tab. (#2523)
- **Notification when all cells complete** — After a long run, a browser notification can be sent when done. (#2531)

---

## 22. Security

- **Secret token authentication** — Pluto uses a secret token in the URL/cookie to authenticate requests. (#529)
- **Token in WebSocket connect** — The secret is sent in the WebSocket connection for iframe use cases. (#2164)
- **Auth tests** — Tests for the authentication system. (#1170)
- **SHA256 polyfill for insecure contexts** — SHA256 hashing works in non-HTTPS contexts (for PlutoSliderServer). (#1825)
- **CSP compatibility** — Avoids `eval()` calls that would be blocked by Content Security Policy. (#2566)
- **Alert when WebSocket can't reconnect due to auth** — Users are notified when a stale auth cookie prevents reconnection. (#3385)

---

## 23. AI Features

- **"Fix with AI" button** — A button to automatically fix syntax errors using an AI (Claude/LLM). (#3201, #3261, #3482)
- **AI fix: diff view** — The AI-suggested fix is shown as a diff, with Accept/Reject buttons. (#3261)
- **AI fix disabled when blocked** — The "Fix with AI" button doesn't appear when the AI endpoint is blocked. (#3211)
- **"AI prompt generator" button** — A button that composes a context-aware AI prompt to help users use external LLMs (ChatGPT, Claude, etc.). (#3224)

---

## 24. Testing & Developer Infrastructure

- **End-to-end frontend tests (Puppeteer/Jest)** — Automated browser tests using Puppeteer. (#387, #1922)
- **Frontend tests run on bundle in offline mode** — Tests run against the bundled frontend. (#1737)
- **Frontend tests for JavaScript API** — Tests for the JS API (Observable stdlib, `this` persistence, etc.). (#1184)
- **Firefox, Safari, Chrome cross-browser tests** — Basic tests run on Firefox, Safari, and Chrome. (#2962, #2963)
- **Parcel bundler** — Frontend is bundled with Parcel.js for production. (#1561)
- **Bundle action checks for empty files** — The GitHub Action that creates the bundle checks for empty output files. (#2320)
- **Bundle action runs on PRs** — Bundling is verified on every pull request. (#2415)
- **TypeScript static type checking** — Frontend TypeScript code is type-checked in CI. (#2134)
- **Compilation benchmarks** — Benchmarks track TTFX (time-to-first-X) for key operations. (#1959)
- **SnoopPrecompile / PrecompileTools** — Precompile calls are tracked and maintained. (#2441, #2534)
- **PlutoDependencyExplorer.jl** — The cell topology/dependency logic is factored into a separate package. (#2717, #2777)
- **ExpressionExplorer.jl** — The expression analysis logic is factored into a separate package. (#2698)
- **Malt.jl** — The process management library is a separate package. (#2240)

---

## 25. Miscellaneous / UX Polish

- **"File not found" page** — A friendly page shown when a notebook file doesn't exist. (#149)
- **Automatic reconnect** — Pluto automatically reconnects if the WebSocket connection drops. (#370)
- **Nice error when port fails** — A clear error message when port binding fails (e.g., permissions). (#2103)
- **Horizontal layout for large screens** — On large screens, the notebook is centered; on medium screens, it aligns left with space for embedded elements. (#2903)
- **`<pluto-editor>` fullscreen and embedded layouts** — The editor component supports both fullscreen and embedded modes. (#1976, #2903)
- **WS message log for debugging** — `pluto_get_message_log()` returns recent server messages in the JS console. (#2926)
- **Print secret if accessed without it** — If Pluto is accessed without a secret, it prints the secret URL to the console. (#2322)
- **Em dash instead of hyphen in output** — Hyphens in variable names are displayed as em dashes to avoid confusion with subtraction. (#403)
- **Markdown CSS: quotes and blockquotes** — CSS styles for `<blockquote>` elements in Markdown output. (#140)
- **CSS for code inside Markdown** — Inline code styling in Markdown. (#551)
- **Table CSS improvements** — CSS for table outputs including horizontal overflow fix on Firefox. (#247, #2805)
- **`<details>` scrolling fix** — Opening a `<details>` element no longer causes unexpected scrolling. (#1231)
- **CORS fix: secret not in Referer header** — The auth secret is not sent as a Referer to third-party CDN requests. (#722)
- **`pluto.land` upload** — Share notebooks publicly via pluto.land. (#3360)
- **Notebook file backup on bad git merge** — Cells missing from the cell order due to bad git merges are recovered. (#1772)
- **`Pluto.run()` uses logging** — Startup messages use Julia's logging system for better filtering. (#2042)

---

## Total Feature Count: ~250+ features across 25 categories

*This list was compiled from 1,013 merged pull requests on the JuliaPluto/Pluto.jl repository (PRs #20–#3484).*
