### A Pluto.jl notebook ###
# v0.20.23

#> [frontmatter]
#> order = "4"
#> title = "🧮 LaTeX"
#> date = "2025-08-01"
#> tags = ["docs", "writing", "latex", "markdown"]
#> description = "How to use LaTeX in Pluto"
#> layout = "layout.jlhtml"

using Markdown
using InteractiveUtils

# ╔═╡ 633cfe44-6ed5-11f0-2eee-e72949879521
md"""
# LaTeX in Pluto

Pluto has built-in support for LaTeX math equations. You use can use LaTeX inside [Markdown](../markdown/) blocks. There are two ways to write LaTeX, we recommend the following method:

## Inline math
To write a math equation **inline**, use the double backticks around the equation:
"""

# ╔═╡ 78ba3c95-e7a0-4374-bc5b-c44be72fdb62


# ╔═╡ bb6672b7-34b4-4838-853c-f186134f98e8
md"""
Here is an inline equation: ``\frac{1}{2 \pi}``.
"""

# ╔═╡ 8399e685-e323-4795-ac54-029c4dc2ae28
md"""
## Block math
To write a large **block equation**, use triple backticks with `math` (this is a code block with `math` as the language):
"""

# ╔═╡ 5a011a33-e97f-490e-b6a2-c7ea6e4091f8
md"""
## Finding LaTeX Syntax
If you don't know the LaTeX syntax for a symbol, you can use the Live Docs to look it up: just type the Unicode character and see its LaTeX equivalent.

You can also use this to find the name of emojis!
"""

# ╔═╡ 1d5a3bb3-ee22-4c7c-b66e-8950ed471942

md"""

![Example of Reverse Search for Integral Symbol](https://github.com/JuliaPluto/website/blob/6cad65a4b0f3969b758c8b80c40623ea8dc04429/src/assets/img/live-docs-latex-search.png?raw=true)

"""

# ╔═╡ f615f40c-8ced-408d-8f64-23198b350e27
md"""
Here is a block equation:

```math
\frac{1}{2 \pi}
```
"""

# ╔═╡ e777296b-b176-4bd8-8eee-6324f89121f1
md"""
# Old syntax
Julia Markdown also has another way to write LaTeX, using the `$` dollar sign. However, because it can conflict with [string interpolation](https://docs.julialang.org/en/v1/manual/strings/#string-interpolation) in confusing ways, we recommend using the backtick method described above instead.
"""

# ╔═╡ 2a155246-c9b5-4bd4-9550-a0c9290c2859
md"""
## Inline math _(⚠️ old syntax)_
Here is how to write inline math with `$`.
"""

# ╔═╡ 5a18f513-09ba-4cae-bd9e-86162372fa72


# ╔═╡ 6e86cef0-316a-497b-b2c9-e22d7efea7e7
md"""
Here is an inline equation: $\frac{1}{2 \pi}$.
"""

# ╔═╡ 797f5ba9-c706-444a-8aa7-989b664ef5b9
md"""
## Block math _(⚠️ old syntax)_
Here is how to write block math with `$`. The syntax is the same, but Markdown uses block math if the math equation is the only content of a line.

"""

# ╔═╡ 44121ee2-8467-4147-89b0-1aa7689d0ba9


# ╔═╡ c835f6c9-920a-4285-b0f7-bf93aab6b94c
md"""
Here is a block equation:

$\frac{1}{2 \pi}$
"""

# ╔═╡ 4963558c-fe1f-4d11-a164-a45d78984497
md"""
!!! tip
	Instead of using the old `$` syntax, we recommend using backticks instead. See the section above.
"""

# ╔═╡ 921f29fa-2262-4b02-a471-3a315d539cc4
md"""
# Emojis in Pluto

Pluto has built-in support for Emojis. You use can them inside [Markdown](../markdown/) blocks. To find the emoji or symbol you need, start with `\` and type the name of the emoji, some suggestions will be made, so you can find the correct emoji for you.
"""

# ╔═╡ 8547c10a-ec25-4022-933d-ea727b0b848f
md"""

![Example of Emoji Auto-fill](https://github.com/JuliaPluto/website/blob/ce4f61d72a6fc804ae00dd73ea7c382dbfc78e09/src/assets/img/dog-emoji.png?raw=true)

"""

# ╔═╡ 73683cce-c6b8-499a-b14c-6680d0399117
md"You can only use emojis to define some variables! "

# ╔═╡ 380f641e-60c1-4cf2-ae2b-a39aacba2066
begin
	🐶 = 1
	🐱 = 1
	🏠 = 🐶 + 3 * 🐱
end;

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.5"
manifest_format = "2.0"
project_hash = "71853c6197a6a7f222db0f1978c7cb232b87c5ee"

[deps]
"""

# ╔═╡ Cell order:
# ╟─633cfe44-6ed5-11f0-2eee-e72949879521
# ╟─78ba3c95-e7a0-4374-bc5b-c44be72fdb62
# ╠═bb6672b7-34b4-4838-853c-f186134f98e8
# ╟─8399e685-e323-4795-ac54-029c4dc2ae28
# ╟─5a011a33-e97f-490e-b6a2-c7ea6e4091f8
# ╟─1d5a3bb3-ee22-4c7c-b66e-8950ed471942
# ╠═f615f40c-8ced-408d-8f64-23198b350e27
# ╟─e777296b-b176-4bd8-8eee-6324f89121f1
# ╟─2a155246-c9b5-4bd4-9550-a0c9290c2859
# ╟─5a18f513-09ba-4cae-bd9e-86162372fa72
# ╠═6e86cef0-316a-497b-b2c9-e22d7efea7e7
# ╟─797f5ba9-c706-444a-8aa7-989b664ef5b9
# ╟─44121ee2-8467-4147-89b0-1aa7689d0ba9
# ╠═c835f6c9-920a-4285-b0f7-bf93aab6b94c
# ╟─4963558c-fe1f-4d11-a164-a45d78984497
# ╟─921f29fa-2262-4b02-a471-3a315d539cc4
# ╟─8547c10a-ec25-4022-933d-ea727b0b848f
# ╟─73683cce-c6b8-499a-b14c-6680d0399117
# ╠═380f641e-60c1-4cf2-ae2b-a39aacba2066
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
