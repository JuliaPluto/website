# Pluto.jl — Comprehensive Feature List
# _Written by 🤖_
> Compiled from all merged pull requests (PRs #20–#3484) on the JuliaPluto/Pluto.jl repository.
> Goal: provide a reference for documentation coverage analysis.


> # HOW TO USE THIS:
> When a feature is documented, or if it does not need documentation, you can remove it from the list.


---

## 2. Package Management (Built-in Pkg)

- **Guided Project.toml editor** — A UI for editing the notebook's `Project.toml` with compat entries. (#3218)
- **Auto-fix corrupted manifests** — When a notebook's manifest is broken, Pluto tries strategies to automatically fix it. (#2294, #2298)
- **GracefulPkg.jl integration** — Uses GracefulPkg.jl for safer, more user-friendly Pkg error handling. (#3185)
- **Show Pkg logs in Process Status tab** — Pkg operation logs are visible in the dedicated Process Status panel. (#2498)

---

## 3. Editor / Code Editing
- **Unicode symbol autocomplete** — Tab-complete `\alpha` → `α`, `\:smile:` → emoji. (#153, #1485, #2876)
- **Latex reverse search in Live Docs** — Type a Unicode character and see its LaTeX equivalent. (#2476)
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
- **Plotly support** — Plotly.js plots rendered correctly in Pluto. (#213)
- **LaTeXString support** — `LaTeXString` objects are rendered with MathJax. (#381, #1164)
- **MathJax 3 for math rendering** — MathJax 3 renders LaTeX math in Markdown and outputs. (#1947, #2165, #2803)
---


## 8. HTML Export & Static Notebooks

- **"View code" button in static export** — A button in the static HTML allows reading hidden/folded code. (#3313)

---

## 10. Main Menu / Welcome Screen
- **Recents list** — Recently opened notebooks are shown on the main menu. (#37)
- **Recents: shortest unambiguous path** — Recent notebooks are shown with the shortest unambiguous path. (#693)
- **Paste/drop `.jl` files to open** — You can paste or drop a `.jl` file onto the welcome screen to open it. (#1015)
- **Open notebooks without browser** — `Pluto.run(notebook="path.jl")` opens a notebook without launching a browser. (#1324)
- **Open multiple notebooks at start** — Multiple notebooks can be passed to `Pluto.run()` to open on startup. (#1324)
---

## 11. Notebook Files & Format
- **Auto-save on run** — The notebook file is saved every time a cell is run. (#37)
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

- **`extra_instrumentation_lines` / HTML injection** — Option to inject HTML at the top of the notebook for custom deployments. (#1683)
- **Hide banner in CI** — Pluto detects the `CI` environment variable and suppresses the startup banner. (#1868)
- **Display banner from `__init__`** — The banner is shown at load time, not during precompilation. (#2628)
- **Separate notebook boot environment** — The notebook's boot environment is separate from the server environment to avoid conflicts. (#1556)
- **Session event API** — `SessionActions` API for programmatically opening, closing, and managing notebooks. (#1644)
- **State file export endpoint** — `/statefile?id=<session-id>` exports the notebook state as a MessagePack binary. (#1118)
- **RelocatableFolders for sysimage support** — Pluto can be bundled into a system image. (#1853)
- **`cpu_target` option for Malt worker** — Pass `--cpu-target` to the notebook Julia process. (#3362)
- **Server start event** — An event fires with the server's web address after startup. (#1882)
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

## 18. Dark Mode & Themes

- **Dark mode** — Pluto has a built-in dark mode that can be toggled. (#1661)
- **CSS variable-based theming** — Colors are defined using CSS variables for easy theme customization. (#1661)
- **Syntax highlighting colors update** — Colors defined with `oklch`, improved command/type/string highlighting. (#3017)

---

## 19. Fonts & Typography

- **JuliaMono font** — JuliaMono is the default monospace font, with full Julia unicode character support. (#364, #1286, #3223, #3450)

## 21. Process Status Tab

- **Process Status tab** — A panel showing what is currently loading, running, or compiling. (#2399, #2376)
- **Task failures shown in red** — Failed tasks in the Status tab are highlighted in red. (#2858)
- **Show Pkg logs in Process Status** — Pkg operation logs appear in the Status tab. (#2498)
- **Binder progress in Status tab** — Binder launch steps are shown in the Status tab. (#2523)
- **Notification when all cells complete** — After a long run, a browser notification can be sent when done. (#2531)


*This list was compiled from 1,013 merged pull requests on the JuliaPluto/Pluto.jl repository (PRs #20–#3484).*
