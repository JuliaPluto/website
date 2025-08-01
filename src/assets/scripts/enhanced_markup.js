const containers = document.querySelectorAll("pluto-output.pages-markdown div.raw-html-wrapper")

requestAnimationFrame(() => {
    window.__pluto_setup_mathjax?.()
    containers.forEach((container) => {
        window.__pluto_apply_enhanced_markup_features(container, null)
    })
})
