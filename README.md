# website
WIP: the new plutojl.org website



# Overview

This is the source code for the Pluto.jl website! It uses a site generation system inspired by [https://www.11ty.dev/](https://www.11ty.dev/), but there are only three template systems:
- **`.jlhtml` files** are rendered by [HypertextLiteral.jl](https://github.com/JuliaPluto/HypertextLiteral.jl)
- **`.jlmd` files** are rendered by [MarkdownLiteral.jl](https://github.com/JuliaPluto/MarkdownLiteral.jl)
- **`.jl` files** are rendered by [PlutoSliderServer.jl](https://github.com/JuliaPluto/PlutoSliderServer.jl)

The `/src/` folder is scanned for files, and all files are turned into HTML pages. 

Paths correspond to URLs. For example, `src/docs/install.jlmd` will become available at `plutojl.org/docs/install/`. For files called *"index"*, the URL will point to its parent, e.g. `src/docs/index.jlmd` becomes `plutojl.org/docs/`. Remember that changing URLs is very bad! You can't share Pluto with your friends if the links break.

> **To add something to our website, just create a new file!** Fons will be super happy to figure out the technical bits.

You can generate & preview the website locally (more on this later), and we have a github action generating the website when we push to `main`. The result (in the `dist` branch) is deployed with netlify.

# Content

## Literal templates
We use *Julia* as our templating system! Because we use HypertextLiteral and MarkdownLiteral, you can write regular Markdown files and HTML files, but you can also include `$(interpolation)` to spice up your documents! For example:

```markdown
# Hey there!

This is some *text*. Here is a very big number: $(1 + 1).
```

Besides small inline values, you can also write big code blocks, with `$(begin ... end)`, and you can output HTML. Take a look at some of our files to learn more!

## Pluto notebooks

Pluto notebooks will be rendered to HTML and included in the page. What you see is what you get!

We are not running a slider server currently, but we will probably add it in the future!

Notebook outputs are **cached** (for a long time) by the file hash. This means that a notebook file will only ever run once, which makes it much faster to work on the website. If you need to re-run your notebook, add a space somewhere in the code :)

## `.css`, `.html`, `.gif`, etc

Web assets go through the system unchanged.

# Front matter

Like many SSG systems, we use [*front matter*](https://www.11ty.dev/docs/data-frontmatter/) to add metadata to pages. In `.jlmd` files, this is done with a front matter block, e.g.:
```markdown
---
title: "🌼 How to install"
description: "Instructions to install Pluto.jl"
tags: ["docs", "introduction"]
layout: "md.jlmd"
---

# Let's install Pluto

here is how you do it
```

Every page **should probably** include:
- *`title`*: Will be used in the sidebar, on Google, in the window header, and on social media.
- *`description`*: Will be used on hover, on Google, and on social media.
- *`tags`*: List of *tags* that are used to create collections out of pages. Our sidebar uses collections to know which pages to list. (more details in `sidebar data.jl`)
- *`layout`*: The name of a layout file in `src/_includes`. For basic Markdown or HTML, you probably want `md.jlmd`. For Pluto, you should use `layout.jlhtml`.

## How to write front matter
For `.jlmd` files, see the example above. 

For `.jl` notebooks, use the [Frontmatter GUI](https://github.com/fonsp/Pluto.jl/pull/2104) built into Pluto.

For `.jlhtml`, we still need to figure something out 😄.

# Running locally

You need to do two things:
1. Open Pluto and run the `PlutoPages.jl` notebook. The first run can take some time, as it builds up the notebook outputs cache. Leave it running.
2. Install Deno, go to the `_site` folder (will be created), and run:
    ```
    deno run --allow-net --allow-read https://deno.land/std@0.129.0/http/file_server.ts .
    ```
3. Go to the URL given by Deno. 
4. Whenever you edit a file, PlutoPages will automatically regenerate! Refresh your browser tab. If it does not pick up the change, find the cell defining `allfiles`, and run it manually.

This workflow is recommended for writing static content, styles, and for site maintenance. But for writing Pluto notebooks, it's best to prepare the notebook first, and then run the site (because it re-runs the entire notebook on any change).

# PlutoPages.jl?

I think our site generation system is pretty neat! But the hope is to add our new tricks into Franklin.jl, instead of publishing PlutoPages.jl as a separate thing. We'll see!


