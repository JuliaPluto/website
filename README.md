# website
WIP: the new plutojl.org website



# Overview

This is the source code for the Pluto.jl website! It uses [PlutoPages.jl](https://github.com/JuliaPluto/PlutoPages.jl), a site generation system inspired by [https://www.11ty.dev/](https://www.11ty.dev/). Take a look at PlutoPages to learn more about how this repo works!

> **To add something to our website, just create a new file!** Fons will be super happy to figure out the technical bits.

You can generate & preview the website locally (more on this later), and we have a github action generating the website when we push to `main`. The result (in the `dist` branch) is deployed with netlify.

# Running locally

## Developing *content, styles, etc.*

Open this repository in VS Code, and install the recommended extensions.

To start running the development server, open the VS Code *command palette* (press `Cmd+Shift+P`), and search for **`Tasks: Run Task`**, then **`PlutoPages: run development server`**. The first run can take some time, as it builds up the notebook outputs cache. Leave it running.

This will start two things in parallel: the PlutoPages.jl notebook (which generates the website), and a static file server (with Deno_jll). It will open two tabs in your browser: one is the generation dashboard (PlutoPages), the other is the current site preview (Deno_jll).
 
Whenever you edit a file, PlutoPages will automatically regenerate! Refresh your browser tab. If it does not pick up the change, go to the generation dashboard and click the "Read input files again" button.

This workflow is recommended for writing static content, styles, and for site maintenance. But for writing Pluto notebooks, it's best to prepare the notebook first, and then run the site (because it re-runs the entire notebook on any change).

