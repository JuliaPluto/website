const codeBlocks = document.querySelectorAll("pluto-output.pages-markdown pre code")

codeBlocks.forEach((code_element) => {
    code_element.classList.forEach((className) => {
        if (className.startsWith("language-") && !className.endsWith("undefined")) {
            // Remove "language-"
            let language = className.substring(9)
            language = language.toLowerCase()
            language = language === "jl" ? "julia" : language

            if (code_element.children.length === 0) {
                if (language === "htmlmixed") {
                    code_element.classList.remove("language-htmlmixed")
                    code_element.classList.add("language-html")
                }
                hljs.highlightElement(code_element)
            }
        }
    })
})
