### A Pluto.jl notebook ###
# v0.20.25

#> [frontmatter]
#> image = "https://media.giphy.com/media/l3vRfDn9ca5PVkHv2/giphy.gif"
#> title = "AbstractPlutoDingetjes.jl – develop enhanced Pluto widgets"
#> layout = "layout.jlhtml"
#> tags = ["docs", "widgets", "AbstractPlutoDingetjes", "advanced"]
#> date = "2023-11-21"
#> description = "AbstractPlutoDingetjes allows you to write more advanced widgets to be used inside Pluto.jl."
#> license = "Unlicense"
#> 
#>     [[frontmatter.author]]
#>     name = "Pluto.jl"
#>     url = "https://github.com/JuliaPluto"

using Markdown
using InteractiveUtils

# ╔═╡ bf40b702-48a5-4a99-957a-72ad391aa9d5
using AbstractPlutoDingetjes

# ╔═╡ 85161a3c-274b-4c90-a9ef-ec86e3e2c59a
md"""
# AbstractPlutoDingetjes.jl

If you want to design widgets to be used inside Pluto.jl (like PlutoUI components, a plotting package, etc), AbstractPlutoDingetjes lets you hook into more advanced Pluto features. 

This package works best in combination with [HypertextLiteral.jl](https://github.com/JuliaPluto/HypertextLiteral.jl). If you don't know about HypertextLiteral.jl yet, you should check out the [overview of Pluto widgets](https://plutojl.org/en/docs/advanced-widgets/) first.
"""

# ╔═╡ 16877f32-8879-11ee-0554-01ef8951f596
Docs.Binding(AbstractPlutoDingetjes, :AbstractPlutoDingetjes)

# ╔═╡ d6b36872-77de-4a87-acbf-e1725ca15d27


# ╔═╡ 13a37a8e-023a-45da-8364-fd69ff76285b
md"""
![](https://media.giphy.com/media/l3vRfDn9ca5PVkHv2/giphy.gif)
"""

# ╔═╡ 39680ebf-8cca-4c64-80aa-afdb261344e7
md"""
# AbstractPlutoDingetjes.Bonds
"""

# ╔═╡ a0acd455-b1d2-4580-9607-119ec882315f
Docs.Binding(AbstractPlutoDingetjes.Bonds, :initial_value)

# ╔═╡ c3e83475-6ab0-4aa8-9a57-c2f25772cc75
Docs.Binding(AbstractPlutoDingetjes.Bonds, :transform_value)

# ╔═╡ 3d52b554-7b27-4eed-b1b2-6d100b3bcf93
Docs.Binding(AbstractPlutoDingetjes.Bonds, :possible_values)

# ╔═╡ 61cd5974-24c4-44d7-b82e-bce729688842
Docs.Binding(AbstractPlutoDingetjes.Bonds, :NotGiven)

# ╔═╡ 834eb09f-b583-4eed-899e-aaae4fcc8b4e
Docs.Binding(AbstractPlutoDingetjes.Bonds, :InfinitePossibilities)

# ╔═╡ 6ec4c9b6-e3e2-4f0a-911f-49484a489ec6
Docs.Binding(AbstractPlutoDingetjes.Bonds, :validate_value)

# ╔═╡ fe840c59-2f58-4b8c-9429-7ce33c242bf6
md"""
# AbstractPlutoDingetjes.Display
"""

# ╔═╡ c97231c8-d465-48a2-90ec-f94a2895a83a
Docs.Binding(AbstractPlutoDingetjes.Display, :published_to_js)

# ╔═╡ 0a9ff8c7-b5f8-4ea5-8a45-a1cb2071abba
Docs.Binding(AbstractPlutoDingetjes.Display, :with_js_link)

# ╔═╡ 2068fd25-d1e9-4b34-b761-dc73780338db
Docs.Binding(AbstractPlutoDingetjes.Display, Symbol("@embed"))

# ╔═╡ 78ebc89b-c9ed-4b13-b2c3-605e880cf842
Docs.Binding(AbstractPlutoDingetjes.Display, Symbol("@auto_id"))

# ╔═╡ 26c855cf-1f8c-4d5f-93ae-b58a48afa33c
Docs.Binding(AbstractPlutoDingetjes.Display, :ReactDOMElement)

# ╔═╡ b540e440-4ae6-46ec-ae20-2350d933e51e
md"""
# Extras
"""

# ╔═╡ 86f57e1a-745e-4fac-a662-89231d57e4a4
Docs.Binding(AbstractPlutoDingetjes, :is_supported_by_display)

# ╔═╡ be0e729c-a1c3-44e8-bf7b-2655bc4f472f
Docs.Binding(AbstractPlutoDingetjes, :is_inside_pluto)

# ╔═╡ 0f7c4a26-e65d-47f9-b8be-47e6ff6fa2a7
import PlutoUI

# ╔═╡ 5b3d4dfa-f93a-4854-950f-6b93f6ff42fe
PlutoUI.TableOfContents(include_definitions=true)

# ╔═╡ 35d21862-b193-4450-9a08-490d77b3722e
pkgversion(AbstractPlutoDingetjes)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
AbstractPlutoDingetjes = "6e696c72-6542-2067-7265-42206c756150"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
AbstractPlutoDingetjes = "~1.4.0"
PlutoUI = "~0.7.80"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.11"
manifest_format = "2.0"
project_hash = "1465c9bffc00abc007d2a99a4c4af74300d0b79e"

[[deps.AbstractPlutoDingetjes]]
git-tree-sha1 = "6c3913f4e9bdf6ba3c08041a446fb1332716cbc2"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.4.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

    [deps.ColorTypes.weakdeps]
    StyledStrings = "f489334b-da3d-4c2e-b8f0-e476e12c162b"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "d1a86724f81bcd184a38fd284ce183ec067d71a0"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "1.0.0"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "0ee181ec08df7d7c911901ea38baf16f755114dc"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "1.0.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.1010+0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2025.12.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+5"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "fbc875044d82c113a9dee6fc14e16cf01fd48872"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.80"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "311349fd1c93a31f783f977a71e8b062a57d4101"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.13"

[[deps.URIs]]
git-tree-sha1 = "bef26fb046d031353ef97a82e3fdb6afe7f21b1a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.6.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"
"""

# ╔═╡ Cell order:
# ╟─85161a3c-274b-4c90-a9ef-ec86e3e2c59a
# ╟─5b3d4dfa-f93a-4854-950f-6b93f6ff42fe
# ╠═bf40b702-48a5-4a99-957a-72ad391aa9d5
# ╟─16877f32-8879-11ee-0554-01ef8951f596
# ╟─d6b36872-77de-4a87-acbf-e1725ca15d27
# ╟─13a37a8e-023a-45da-8364-fd69ff76285b
# ╟─39680ebf-8cca-4c64-80aa-afdb261344e7
# ╟─a0acd455-b1d2-4580-9607-119ec882315f
# ╟─c3e83475-6ab0-4aa8-9a57-c2f25772cc75
# ╟─3d52b554-7b27-4eed-b1b2-6d100b3bcf93
# ╟─61cd5974-24c4-44d7-b82e-bce729688842
# ╟─834eb09f-b583-4eed-899e-aaae4fcc8b4e
# ╟─6ec4c9b6-e3e2-4f0a-911f-49484a489ec6
# ╟─fe840c59-2f58-4b8c-9429-7ce33c242bf6
# ╟─c97231c8-d465-48a2-90ec-f94a2895a83a
# ╟─0a9ff8c7-b5f8-4ea5-8a45-a1cb2071abba
# ╟─2068fd25-d1e9-4b34-b761-dc73780338db
# ╟─78ebc89b-c9ed-4b13-b2c3-605e880cf842
# ╟─26c855cf-1f8c-4d5f-93ae-b58a48afa33c
# ╟─b540e440-4ae6-46ec-ae20-2350d933e51e
# ╟─86f57e1a-745e-4fac-a662-89231d57e4a4
# ╟─be0e729c-a1c3-44e8-bf7b-2655bc4f472f
# ╟─0f7c4a26-e65d-47f9-b8be-47e6ff6fa2a7
# ╠═35d21862-b193-4450-9a08-490d77b3722e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
