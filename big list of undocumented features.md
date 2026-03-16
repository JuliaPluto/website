# Pluto.jl — Comprehensive Feature List
# _Written by 🤖_
> Compiled from all merged pull requests (PRs #20–#3484) on the JuliaPluto/Pluto.jl repository.
> Goal: provide a reference for documentation coverage analysis.


> # HOW TO USE THIS:
> When a feature is documented, or if it does not need documentation, you can remove it from the list.
---

## 8. HTML Export & Static Notebooks
- **"View code" button in static export** — A button in the static HTML allows reading hidden/folded code. (#3313)

---

## 10. Main Menu / Welcome Screen
- **Recents list** — Recently opened notebooks are shown on the main menu. (#37)
- **Recents: shortest unambiguous path** — Recent notebooks are shown with the shortest unambiguous path. (#693)
- **Open multiple notebooks at start** — Multiple notebooks can be passed to `Pluto.run()` to open on startup. (#1324)
---

## 11. Notebook Files & Format
- **Auto-save on run** — The notebook file is saved every time a cell is run. (#37)
- **Option to disable writing to file** — `disable_writing_notebook_file` option prevents Pluto from saving changes to disk. (#1047, #1717)
- **Notebook metadata** — A `metadata` field in the notebook structure stores notebook-wide settings. (#2016)
- **Pluto Recording format** — A special file format for recording notebook sessions as interactive replays. (#1623)

---

## 13. Collaboration & Sharing
- **Secret token for access control** — Pluto generates a secret token to prevent unauthorized access on multi-user computers. (#529)
- **Token in Binder URL** — On Binder, the token is embedded in the URL so it can be shared. (#429)
- **GitHub raw link support** — Opening a GitHub raw link opens the notebook directly. (#493)
---

## 16. Accessibility & Keyboard Navigation

- **Tab-friendly export menu** — The export menu uses `<dialog>` for proper keyboard accessibility. (#2750)
- **Tab-friendly Pkg popup** — The Pkg popup supports keyboard navigation. (#2752)
- **Tab-friendly cell context menu** — The cell context menu supports keyboard navigation. (#2759)
- **Tab trap help message** — When the Tab key is trapped in a code cell, a help message explains how to escape. (#2746)
---

## 18. Dark Mode & Themes
- **Dark mode** — Pluto has a built-in dark mode that can be toggled. (#1661)
---

*This list was compiled from 1,013 merged pull requests on the JuliaPluto/Pluto.jl repository (PRs #20–#3484).*
