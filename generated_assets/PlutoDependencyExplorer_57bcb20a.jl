### A Pluto.jl notebook ###
# v0.20.3

#> [frontmatter]
#> image = "https://media.giphy.com/media/242BaXJnCfe7hOVrsE/giphy.gif"
#> title = "PlutoDependencyExplorer.jl – documentation"
#> date = "2024-01-21"
#> license = "Unlicense"
#> description = "Given a list of cell codes, PlutoDependencyExplorer can tell you in which order these cells should run. Used internally by Pluto.jl."
#> tags = ["docs", "PlutoDependencyExplorer", "internals", "reactivity", "ExpressionExplorer", "advanced"]
#> layout = "docsnotebook.jlmd"
#> 
#>     [[frontmatter.author]]
#>     name = "Pluto.jl"
#>     url = "https://github.com/JuliaPluto"

using Markdown
using InteractiveUtils

# ╔═╡ 8b669928-eb0d-47b6-bea3-da46e98291d3
using PlutoDependencyExplorer

# ╔═╡ effa9b86-f78f-47a7-898b-308a12c6fee7
using PlutoUI; TableOfContents(; include_definitions=true)

# ╔═╡ 488a0b76-0d9e-46cc-8db0-f7e072e846f5
md"""
# PlutoDependencyExplorer.jl
"""

# ╔═╡ f10e5aee-a5da-45aa-89d6-8e47835ceffd
Docs.Binding(PlutoDependencyExplorer, :PlutoDependencyExplorer)

# ╔═╡ d917d940-3de5-4f0a-a83e-33c0522b2c83


# ╔═╡ cf44eaae-7868-464a-8d17-5a5335977a3c
md"""
# Basic example

Let's define our "notebook", which is just a list of cells:
"""

# ╔═╡ deff4ae6-85a7-4003-bef0-6c895eb5ddad
const PDE = PlutoDependencyExplorer;

# ╔═╡ 43f09b34-6851-46bc-ba47-8616183ef054
struct SimpleCell <: PDE.AbstractCell
	code
end

# ╔═╡ caad3b3d-7baf-4f74-afd0-06e2d2bd37f1
notebook = SimpleCell.([
	"x + y"
	"x = 1"
	"y = x + 2"
])

# ╔═╡ a5040b27-93e1-4a74-b824-a46712da4cf8


# ╔═╡ adab7609-9cc6-4092-883a-2df1cba9750e
md"""
Next, we want to calculate its **toplogy**, this is the *dependency graph* of the notebook: all links between cells.
"""

# ╔═╡ 35afd395-c10c-49bb-a4ce-7aa7c6409e9c
empty_topology = PDE.NotebookTopology{SimpleCell}()

# ╔═╡ 897a6be7-5457-40d9-ab30-0728a3d83034
topology = PDE.updated_topology(
	empty_topology,
	notebook, notebook;

	get_code_str = c -> c.code,
	get_code_expr = c -> Meta.parse(c.code),
)

# ╔═╡ 7f69ca21-b730-4664-bbcb-2338e7768c9d
md"""
!!! info
	When reading this notebook, you can click on the data structures in the cells above to expand their tree viewer!
"""

# ╔═╡ 9304d391-3bbe-4541-8e7c-69beb1e26940


# ╔═╡ 0ad13f55-6dd7-41a4-9e51-12fc1bc7ffc7
md"""
Now that we have the topology, we can **order** cells in the topology.
"""

# ╔═╡ b5d906da-3545-480f-bee3-bc8159e2f34a
order = PDE.topological_order(topology)

# ╔═╡ 586959a5-aac3-4539-aff6-e83ea627cbe9
md"""
The result contains an ordered list of the notebook cells:
"""

# ╔═╡ 54697fad-80ed-40be-b1fb-1ade3b6305b1
order.runnable

# ╔═╡ 3dd967ae-313b-4078-88fa-9a939ff8a82b


# ╔═╡ 32bef912-9b8a-47c9-add1-fa29242e3a93
md"""
You can also ask PlutoDependencyExplorer which cells should run if one cell re-runs. This is a recursive search. For example, if I re-run the cell that defines `y`:
"""

# ╔═╡ 3b83907d-d3ee-4283-9a39-d25db889cd6e
notebook[3]

# ╔═╡ 20e47c9c-dda9-47fe-beb4-f708a1223869
PDE.topological_order(topology, [notebook[3]]).runnable

# ╔═╡ cd507fd5-b852-45b5-b12e-b67244a1c10f


# ╔═╡ da1b2edc-4925-40de-a876-400026c03069
md"""
By the way, you can also ask PlutoDependencyExplorer which cell defines `y`:
"""

# ╔═╡ b9080c59-8232-4f1b-8ae5-2fed9a20f9e6
PDE.where_assigned(topology, Set([:y]))

# ╔═╡ 5440ec16-083b-4a23-865f-c99d0e716676
md"""
# Core concepts

Let's dig deeper into the **Basic example** above. The first thing we did was define our own subtype of `PlutoDependencyExplorer.AbstractCell`.
"""

# ╔═╡ cfe5728b-5416-44e1-81c0-4a63f5fdc982
Docs.Binding(PDE, :AbstractCell)

# ╔═╡ 4a9828af-e839-4b41-96c4-3ec34748d4d0
md"""
Next, we calculated the notebook's **topology**, which stored as a `NotebookTopology`.
"""

# ╔═╡ a93ce8ff-9f5a-4b58-88d1-27d798e4f1db
Docs.Binding(PDE, :NotebookTopology)

# ╔═╡ eeceb6c0-7a92-4b0c-a105-2716c196c2d9
md"""
We calculated the topology by first creating an empty one, and then updating it with all the cells in our notebook. `NotebookTopology`s are always created by updating a previous one. This is done with `updated_topology`:
"""

# ╔═╡ a17b427c-be13-437d-82fa-5eb00c95fac4
Docs.Binding(PDE, :updated_topology)

# ╔═╡ 16b20435-ec40-465d-919f-6d0d0eae4a7d
md"""
!!! info
	For the initial topology calculation in our example, we passed `notebook` as `notebook_cells`, but also as `updated_cells`. 
	This tells `updated_topology` that **all** cells are new.
"""

# ╔═╡ dda21910-8cb8-48b4-be8b-d3978c159b2c
md"""
When the notebook is changed later, you can use `updated_topology` to calculate a new topology, which will use the old topology as a cache for cells that were not updated.
"""

# ╔═╡ 613ae3f9-27d7-4a59-aea8-391d02b02671
md"""
# More API

The following API is public, and covered by our semver vesrion numbering. These functions are used by Pluto (and can be used by other packages), but might not be fully documented. 

We currently [don't have the capacity](https://opencollective.com/julialang/projects/juliapluto) to document everything, but you can always take a look at Pluto's source for an example of how these functions are used, or you can contact us.
"""

# ╔═╡ 90a7affb-e383-4853-9ab4-19539332c9d8
md"## More basics"

# ╔═╡ c5df652c-652e-483a-b87b-11de3f6d1b03
Docs.Binding(PDE, :where_assigned)

# ╔═╡ e702f13f-6c89-44ab-a26b-51e143279d84
Docs.Binding(PDE, :where_referenced)

# ╔═╡ 0290512e-9884-4ad4-b531-d944166bd051
Docs.Binding(PDE, :all_cells)

# ╔═╡ 739f2660-e966-4037-b78c-8707388b871c
md"## Disabled & resolved"

# ╔═╡ c3518b4b-17f9-473f-b63d-6e226f4b5579
Docs.Binding(PDE, :is_disabled)

# ╔═╡ 907c252b-cd28-44f9-963a-9ea69db507f0
Docs.Binding(PDE, :is_resolved)

# ╔═╡ 045eab27-a686-475a-b8a7-2c4d9cb44431
Docs.Binding(PDE, :set_unresolved)

# ╔═╡ c562b1fb-6a5f-4185-9455-e157d68673ba
md"## Misc"

# ╔═╡ 3f5174da-bd58-4e8c-8c11-af89949b8047
Docs.Binding(PDE, :exclude_roots)

# ╔═╡ 91ce91b8-cb98-4031-b758-fb19fa0054be
Docs.Binding(PDE, :is_soft_edge)

# ╔═╡ 9c66981d-7949-4071-a34a-992d8ea7931a


# ╔═╡ a83a5a3d-10e8-422b-8778-606e4883cae3
md"""
PlutoDependencyExplorer defines an additional method for `ExpressionExplorer.external_package_names`:
"""

# ╔═╡ a5fa2170-54e7-4e5c-a3e9-1daa310d998f
Docs.Binding(PDE.ExpressionExplorer, :external_package_names)

# ╔═╡ 65948f8d-fe2d-4ba2-9188-792a246d82b0
md"## Cell precedence heuristic"

# ╔═╡ 2434b1b1-3b41-4897-9dd4-442bfd73fb64
Docs.Binding(PDE, :cell_precedence_heuristic)

# ╔═╡ 1a0103d9-d211-4c14-aaa0-fc3e2e0e8a9b
Docs.Binding(PDE, :DEFAULT_PRECEDENCE_HEURISTIC)

# ╔═╡ b8c9a356-8916-4c04-b40b-dfcb4345e8ed
md"""
## Reactivity error types

These types are possible value types of the `TopologicalOrder.errable` field.
"""

# ╔═╡ 98891ab1-bb76-4b02-927f-1ea07c0f6d31
Docs.Binding(PDE, :ReactivityError)

# ╔═╡ 30d6dbca-d39b-4497-9d97-8bc3a5971d13
Docs.Binding(PDE, :CyclicReferenceError)

# ╔═╡ 4047011b-992d-4437-8c67-0d53008d179d
Docs.Binding(PDE, :MultipleDefinitionsError)

# ╔═╡ 8aa8f7aa-6011-4627-9c40-bd0b3942fe0e
md"""
## Data structures

We defined immutable versions of some core data structures.
"""

# ╔═╡ 9d0327e7-f310-4a15-9d17-8d3ff1d8ddb8
Docs.Binding(PDE, :ImmutableDefaultDict)

# ╔═╡ 3c301788-5db1-4cee-95a2-448b485bfd40
Docs.Binding(PDE, :ImmutableSet)

# ╔═╡ 8dafb454-3e55-4b6d-8308-084cdf4c310b
Docs.Binding(PDE, :ImmutableVector)

# ╔═╡ 962a5248-5d6b-498a-acb7-a4ceca635442
Docs.Binding(PDE, :setdiffkeys)

# ╔═╡ 06d072ba-eacb-4877-ae1c-dbeec398e903
Docs.Binding(PDE, :delete_unsafe!)

# ╔═╡ da454fae-83d6-4d2d-b55a-2cb20e69c16c
md"""
# ExpressionExplorerExtras

These are some things that are too Pluto-specific to go into ExpressionExplorer.jl, but are available through PDE as public API in the submodule `ExpressionExplorerExtras`.
"""

# ╔═╡ 4c1caf5d-fbce-41e6-a05b-4680aa761ff2
const EEE =  PlutoDependencyExplorer.ExpressionExplorerExtras

# ╔═╡ b65da603-0eff-41e4-90a3-92b279e7eed9
Docs.Binding(EEE, :ExpressionExplorerExtras)

# ╔═╡ 3a898761-9ab6-455e-9136-05f2bf11ad78
Docs.Binding(EEE, :can_be_function_wrapped)

# ╔═╡ a87a5eef-39cb-404f-b5fa-c2e8c71e0365
Docs.Binding(EEE, :can_macroexpand)

# ╔═╡ 1e600928-bdb9-4a23-a4f6-fa95b27dc1a2
Docs.Binding(EEE, :can_macroexpand_no_bind)

# ╔═╡ e63bfb17-1114-4c15-859a-c7bd647569b1
Docs.Binding(EEE, :collect_implicit_usings)

# ╔═╡ 1c53a35f-45ff-46a7-90f5-8dab7bf6cc0b
Docs.Binding(EEE, :maybe_macroexpand_pluto)

# ╔═╡ c96381eb-ca8d-498e-bfa4-06a107b1a24a
Docs.Binding(EEE, :pretransform_pluto)

# ╔═╡ 8dac5863-86e0-483c-bce2-f396c698ddb3
pkgversion(PlutoDependencyExplorer)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoDependencyExplorer = "72656b73-756c-7461-726b-72656b6b696b"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.55"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.1"
manifest_format = "2.0"
project_hash = "97efbe0c60bca9e5fb1b5fa378e498b4a3ad6231"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.ExpressionExplorer]]
git-tree-sha1 = "7005f1493c18afb2fa3bdf06e02b16a9fde5d16d"
uuid = "21656369-7473-754a-2065-74616d696c43"
version = "1.1.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

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
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.PlutoDependencyExplorer]]
deps = ["ExpressionExplorer", "InteractiveUtils", "Markdown"]
git-tree-sha1 = "e0864c15334d2c4bac8137ce3359f1174565e719"
uuid = "72656b73-756c-7461-726b-72656b6b696b"
version = "1.2.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "eba4810d5e6a01f612b948c9fa94f905b49087b0"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.60"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.Tricks]]
git-tree-sha1 = "7822b97e99a1672bfb1b49b668a6d46d58d8cbcb"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.9"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

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
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─488a0b76-0d9e-46cc-8db0-f7e072e846f5
# ╠═8b669928-eb0d-47b6-bea3-da46e98291d3
# ╟─f10e5aee-a5da-45aa-89d6-8e47835ceffd
# ╟─effa9b86-f78f-47a7-898b-308a12c6fee7
# ╟─d917d940-3de5-4f0a-a83e-33c0522b2c83
# ╟─cf44eaae-7868-464a-8d17-5a5335977a3c
# ╠═deff4ae6-85a7-4003-bef0-6c895eb5ddad
# ╠═43f09b34-6851-46bc-ba47-8616183ef054
# ╠═caad3b3d-7baf-4f74-afd0-06e2d2bd37f1
# ╟─a5040b27-93e1-4a74-b824-a46712da4cf8
# ╟─adab7609-9cc6-4092-883a-2df1cba9750e
# ╠═35afd395-c10c-49bb-a4ce-7aa7c6409e9c
# ╠═897a6be7-5457-40d9-ab30-0728a3d83034
# ╟─7f69ca21-b730-4664-bbcb-2338e7768c9d
# ╟─9304d391-3bbe-4541-8e7c-69beb1e26940
# ╟─0ad13f55-6dd7-41a4-9e51-12fc1bc7ffc7
# ╠═b5d906da-3545-480f-bee3-bc8159e2f34a
# ╟─586959a5-aac3-4539-aff6-e83ea627cbe9
# ╠═54697fad-80ed-40be-b1fb-1ade3b6305b1
# ╟─3dd967ae-313b-4078-88fa-9a939ff8a82b
# ╟─32bef912-9b8a-47c9-add1-fa29242e3a93
# ╠═3b83907d-d3ee-4283-9a39-d25db889cd6e
# ╠═20e47c9c-dda9-47fe-beb4-f708a1223869
# ╟─cd507fd5-b852-45b5-b12e-b67244a1c10f
# ╟─da1b2edc-4925-40de-a876-400026c03069
# ╠═b9080c59-8232-4f1b-8ae5-2fed9a20f9e6
# ╟─5440ec16-083b-4a23-865f-c99d0e716676
# ╟─cfe5728b-5416-44e1-81c0-4a63f5fdc982
# ╟─4a9828af-e839-4b41-96c4-3ec34748d4d0
# ╟─a93ce8ff-9f5a-4b58-88d1-27d798e4f1db
# ╟─eeceb6c0-7a92-4b0c-a105-2716c196c2d9
# ╟─a17b427c-be13-437d-82fa-5eb00c95fac4
# ╟─16b20435-ec40-465d-919f-6d0d0eae4a7d
# ╟─dda21910-8cb8-48b4-be8b-d3978c159b2c
# ╟─613ae3f9-27d7-4a59-aea8-391d02b02671
# ╟─90a7affb-e383-4853-9ab4-19539332c9d8
# ╟─c5df652c-652e-483a-b87b-11de3f6d1b03
# ╟─e702f13f-6c89-44ab-a26b-51e143279d84
# ╟─0290512e-9884-4ad4-b531-d944166bd051
# ╟─739f2660-e966-4037-b78c-8707388b871c
# ╟─c3518b4b-17f9-473f-b63d-6e226f4b5579
# ╟─907c252b-cd28-44f9-963a-9ea69db507f0
# ╟─045eab27-a686-475a-b8a7-2c4d9cb44431
# ╟─c562b1fb-6a5f-4185-9455-e157d68673ba
# ╟─3f5174da-bd58-4e8c-8c11-af89949b8047
# ╟─91ce91b8-cb98-4031-b758-fb19fa0054be
# ╟─9c66981d-7949-4071-a34a-992d8ea7931a
# ╟─a83a5a3d-10e8-422b-8778-606e4883cae3
# ╟─a5fa2170-54e7-4e5c-a3e9-1daa310d998f
# ╟─65948f8d-fe2d-4ba2-9188-792a246d82b0
# ╟─2434b1b1-3b41-4897-9dd4-442bfd73fb64
# ╟─1a0103d9-d211-4c14-aaa0-fc3e2e0e8a9b
# ╟─b8c9a356-8916-4c04-b40b-dfcb4345e8ed
# ╟─98891ab1-bb76-4b02-927f-1ea07c0f6d31
# ╟─30d6dbca-d39b-4497-9d97-8bc3a5971d13
# ╟─4047011b-992d-4437-8c67-0d53008d179d
# ╟─8aa8f7aa-6011-4627-9c40-bd0b3942fe0e
# ╟─9d0327e7-f310-4a15-9d17-8d3ff1d8ddb8
# ╟─3c301788-5db1-4cee-95a2-448b485bfd40
# ╟─8dafb454-3e55-4b6d-8308-084cdf4c310b
# ╟─962a5248-5d6b-498a-acb7-a4ceca635442
# ╟─06d072ba-eacb-4877-ae1c-dbeec398e903
# ╟─da454fae-83d6-4d2d-b55a-2cb20e69c16c
# ╟─4c1caf5d-fbce-41e6-a05b-4680aa761ff2
# ╟─b65da603-0eff-41e4-90a3-92b279e7eed9
# ╟─3a898761-9ab6-455e-9136-05f2bf11ad78
# ╟─a87a5eef-39cb-404f-b5fa-c2e8c71e0365
# ╟─1e600928-bdb9-4a23-a4f6-fa95b27dc1a2
# ╟─e63bfb17-1114-4c15-859a-c7bd647569b1
# ╟─1c53a35f-45ff-46a7-90f5-8dab7bf6cc0b
# ╟─c96381eb-ca8d-498e-bfa4-06a107b1a24a
# ╠═8dac5863-86e0-483c-bce2-f396c698ddb3
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
