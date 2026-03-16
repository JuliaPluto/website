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

## 4. Cell Features
- **Add/delete cells** — Cells can be added and deleted via the UI or keyboard shortcuts. (#37)
- **Fold/hide cells** — Cell code can be folded (hidden) while keeping the output visible. (#484)
- **Run button per cell** — Each cell has a run button, and shows its last execution time. (#37)
- **Copy output button** — Context menu item to copy cell output to clipboard. (#2160)
- **Cell context menu** — Right-click a cell to get a context menu with actions. (#2759)
---

## 5. @bind and Interactivity
- **`@bind` with date/time inputs** — Works with `<input type=date>`, `<input type=range>`, etc. (#453)
- **Bond-defining-bond support** — A bond's value can depend on another bond (for PlutoSliderServer). (#3158)
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
- **Open multiple notebooks at start** — Multiple notebooks can be passed to `Pluto.run()` to open on startup. (#1324)
---

## 11. Notebook Files & Format
- **Auto-save on run** — The notebook file is saved every time a cell is run. (#37)
- **Option to disable writing to file** — `disable_writing_notebook_file` option prevents Pluto from saving changes to disk. (#1047, #1717)
- **Cell order is explicit** — The notebook file includes an explicit `Cell order:` section. (#37)
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
- **Token in Binder URL** — On Binder, the token is embedded in the URL so it can be shared. (#429)
- **`open_url` / data URLs** — Pluto can open notebooks from URLs or data URLs directly. (#1670)
- **GitHub raw link support** — Opening a GitHub raw link opens the notebook directly. (#493)
- **PlutoSliderServer support** — Pluto supports PlutoSliderServer.jl for hosting interactive static notebooks. (#988, #1703, #2014)
- **Slider server POST request** — Notebooks can be configured to force POST requests to the slider server. (#2362)
- **`slider_server_url` in export JSON** — The slider server URL can be specified in the `pluto_export.json` file. (#2667)
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

---

## 19. Fonts & Typography

- **JuliaMono font** — JuliaMono is the default monospace font, with full Julia unicode character support. (#364, #1286, #3223, #3450)

*This list was compiled from 1,013 merged pull requests on the JuliaPluto/Pluto.jl repository (PRs #20–#3484).*
