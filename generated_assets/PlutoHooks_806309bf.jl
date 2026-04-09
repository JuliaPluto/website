### A Pluto.jl notebook ###
# v0.20.23

using Markdown
using InteractiveUtils

# ╔═╡ 9c8b8c7c-05bd-11f1-bde1-5302de07152b
using PlutoHooks

# ╔═╡ bf5f78c3-d29f-4218-a963-6d94f55fa9e2
Markdown.parse(read(joinpath(pkgdir(PlutoHooks), "README.md"), String))

# ╔═╡ 9bd0c8eb-ecf4-424f-a507-5face6e192b0
md"A fuller overview can be found under: [https://juliapluto.github.io/PlutoHooks.jl/src/notebook.html](A fuller overview can be found under: `https://juliapluto.github.io/PlutoHooks.jl/src/notebook.html`)"

# ╔═╡ 9e93194f-4e08-44f3-9aff-6a18f7ef48ca
md"""
# Docstrings
"""

# ╔═╡ 5e415434-71a5-4642-a0e3-d2299b263ba2
Docs.Binding(PlutoHooks, Symbol("@use_deps"))

# ╔═╡ aa3f1c57-8a50-44f4-be93-665c5c2d0c3d
Docs.Binding(PlutoHooks, Symbol("@use_effect"))

# ╔═╡ 82c06fd7-f531-4130-89fd-f141d6f2492b
Docs.Binding(PlutoHooks, Symbol("@use_memo"))

# ╔═╡ af07648e-6d5d-4833-958b-fba2479fc7b2
Docs.Binding(PlutoHooks, Symbol("@use_state"))

# ╔═╡ e7739a9d-988d-4fdf-a693-f52de3b8b4bd
Docs.Binding(PlutoHooks, Symbol("@use_ref"))

# ╔═╡ 6219f6af-cb4d-4476-bbd7-8a6f1b46414d
Docs.Binding(PlutoHooks, Symbol("@use_is_pluto_cell"))

# ╔═╡ 9b54cd0d-ef35-4c82-b460-27fb3772e888
Docs.Binding(PlutoHooks, Symbol("@skip_as_script"))

# ╔═╡ a5c61ba5-0401-4427-9086-53af9ef5df94
Docs.Binding(PlutoHooks, Symbol("@only_as_script"))

# ╔═╡ 5449d62d-54e4-459a-ad4b-f00388aa923f
pkgversion(PlutoHooks)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoHooks = "0ff47ea0-7a50-410d-8455-4348d5de0774"

[compat]
PlutoHooks = "~0.1.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.5"
manifest_format = "2.0"
project_hash = "3264ce90cd39281c6868327ed317b09f52d0dc0e"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.PlutoHooks]]
deps = ["InteractiveUtils", "Markdown", "UUIDs"]
git-tree-sha1 = "844a829c8dc9fd0fe62eced22bc2d0dfd66a3f51"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0774"
version = "0.1.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"
"""

# ╔═╡ Cell order:
# ╠═9c8b8c7c-05bd-11f1-bde1-5302de07152b
# ╟─bf5f78c3-d29f-4218-a963-6d94f55fa9e2
# ╟─9bd0c8eb-ecf4-424f-a507-5face6e192b0
# ╟─9e93194f-4e08-44f3-9aff-6a18f7ef48ca
# ╟─5e415434-71a5-4642-a0e3-d2299b263ba2
# ╟─aa3f1c57-8a50-44f4-be93-665c5c2d0c3d
# ╟─82c06fd7-f531-4130-89fd-f141d6f2492b
# ╟─af07648e-6d5d-4833-958b-fba2479fc7b2
# ╟─e7739a9d-988d-4fdf-a693-f52de3b8b4bd
# ╟─6219f6af-cb4d-4476-bbd7-8a6f1b46414d
# ╟─9b54cd0d-ef35-4c82-b460-27fb3772e888
# ╟─a5c61ba5-0401-4427-9086-53af9ef5df94
# ╠═5449d62d-54e4-459a-ad4b-f00388aa923f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
