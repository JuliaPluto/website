---
title: "📕 Notebooks online – Pluto.jl notebooks as web pages"
description: "How to turn Pluto.jl Julia notebooks into web pages by hosting them on a website. How to make them interactive with PlutoSliderServer."
tags: ["docs", "publishing", "PlutoSliderServer", "glass", "glassnotebook", "github", "hosting", "web", "export", "html", "netlify"]
order: 2
layout: "md.jlmd"
---

# How to host Pluto.jl notebooks online

When you are done writing your notebook, you can put it on the internet as a website! Notebooks as websites is a core feature of Pluto. This page will explain how you go from a notebook on your computer, say `animals.jl`, to a website like `https://example.com/animals`, where anyone can read your notebook directly, without needing to install Julia or Pluto.

There are many options fitting to different needs. Some are really easy, while others are more complex.

> ### 📎 Pluto file formats
> And good to know: Pluto notebooks are `.jl` files, which only contain the code of your notebook, not the outputs. For example, if your notebook contains `plot(x, y)`, then the resulting PNG image is not stored in the `.jl` file. Other people need to install Pluto to open the file.
> 
> You can also use Pluto to **export** a notebook to a `.html` or `.pdf` file by clicking the <img src="https://cdn.jsdelivr.net/gh/ionic-team/ionicons@5.5.1/src/svg/share-outline.svg" alt="share" width=17px style="filter: var(--image-filters);"> icon. These files **contain outputs**, like the plot image. Other people can open these files directly on their computer, without needing to install Pluto.

## **pluto.land**: Simple sharing
[pluto.land](https://pluto.land) is a new, simple way to share your Pluto notebooks online. Just [export your notebook to HTML](../export-html/), then upload the HTML file to pluto.land. You'll get a unique URL that you can share with anyone!

**Pros:**
- Free
- Awesome
- Super simple to use
- No account required
- Developed and maintained by the Pluto team

**Cons:**
- No updates: to change the notebook, you upload a new HTML file, and you get a new URL

<img src="$(root_url)/assets/img/plutoland screenshot.png" alt="Screenshot of pluto.land showing an upload button" width="1792" height="870">


## GitHub: `static-export-template`
If you have a GitHub account, then this is the easiest option. Go to [github.com/JuliaPluto/static-export-template](https://github.com/JuliaPluto/static-export-template) and follow the easy instructions with screenshots to set up your repository. This sets up a repository with `.jl` notebook files, which are automatically executed, exported and hosted on the cloud. You get a website like `https://username.github.io/my_project` where you can read the notebooks.

**Pros:**
- Free
- Works for multiple notebooks
- Easy notebook updates: changing `.jl` files automatically updates the website

**Cons:**
- Takes 15-30 minutes to set up (but not too hard!)
- You need to use GitHub

<img alt="screenshot of the actions page, showing a currently running workflow" src="$(root_url)/assets/img/GitHub Actions workflow screenshot.png" width="1764" height="816">

## Netlify drop: *"easy for folders"*
If you just have a couple of `.html` files that you exported with Pluto, then you can use [netlify drop](https://app.netlify.com/drop) to put them online as a website. Put all `.html` files in one folder on your computer, and drag the folder into netlify drop. This will give you a website!

> This only works with `.html` files that you exported yourself, not with `.jl` notebook files.

**Pros:**
- Free
- Fast and easy

**Cons:**
- Updating the website with new notebooks requires a bit of care
- You need a Netlify account
- No automatic index page listing all notebooks

<img src="$(root_url)/assets/img/Netlify Drop interface screenshot.png" alt="screenshot of the Netlify Drop interface" width="1338" height="656">

# Deprecated
The options below used to work in the past, but they are no longer supported.

## Glass Notebook *(deprecated)*
If you have a GitHub account, then [glassnotebook.io](https://glassnotebook.io/) is a great option for hosting your notebooks online. Glass can also host notebooks **interactively**: people who visit your website can interact with sliders and buttons instantly! Glass was made specifically for Pluto.jl, so it works great with Julia and Pluto!

**Pros:**
- Free (for static notebooks)
- Ability to host **interactive** notebooks (paid option)
- Easy user interface
- Support from developers if things don't work

**Cons:**
- You need to use GitHub

<img src="$(root_url)/assets/img/Glass Notebook published repos screenshot.png" alt="screenshot of Glass Notebook showing a list of repositories that are published" width="1894" height="1212">
