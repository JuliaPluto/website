### A Pluto.jl notebook ###
# v0.20.13

#> [frontmatter]
#> order = "4"
#> title = "𝚺 LaTeX"
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

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.10"
manifest_format = "2.0"
project_hash = "da39a3ee5e6b4b0d3255bfef95601890afd80709"

[deps]
"""

# ╔═╡ Cell order:
# ╟─633cfe44-6ed5-11f0-2eee-e72949879521
# ╟─78ba3c95-e7a0-4374-bc5b-c44be72fdb62
# ╠═bb6672b7-34b4-4838-853c-f186134f98e8
# ╟─8399e685-e323-4795-ac54-029c4dc2ae28
# ╟─5a011a33-e97f-490e-b6a2-c7ea6e4091f8
# ╠═f615f40c-8ced-408d-8f64-23198b350e27
# ╟─e777296b-b176-4bd8-8eee-6324f89121f1
# ╟─2a155246-c9b5-4bd4-9550-a0c9290c2859
# ╟─5a18f513-09ba-4cae-bd9e-86162372fa72
# ╠═6e86cef0-316a-497b-b2c9-e22d7efea7e7
# ╟─797f5ba9-c706-444a-8aa7-989b664ef5b9
# ╟─44121ee2-8467-4147-89b0-1aa7689d0ba9
# ╠═c835f6c9-920a-4285-b0f7-bf93aab6b94c
# ╟─4963558c-fe1f-4d11-a164-a45d78984497
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
