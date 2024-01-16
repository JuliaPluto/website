### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# ╔═╡ 7b69f72e-b489-11ee-170e-09164d49c53e
import Pkg

# ╔═╡ eb1476da-363f-4ddd-a10b-8e6b5e177045
Pkg.activate()

# ╔═╡ 8b669928-eb0d-47b6-bea3-da46e98291d3
using PlutoDependencyExplorer

# ╔═╡ 488a0b76-0d9e-46cc-8db0-f7e072e846f5
md"""
# PlutoDependencyExplorer.jl
"""

# ╔═╡ f10e5aee-a5da-45aa-89d6-8e47835ceffd
Docs.Binding(PlutoDependencyExplorer, :PlutoDependencyExplorer)

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

# ╔═╡ effa9b86-f78f-47a7-898b-308a12c6fee7
import PlutoUI

# ╔═╡ 23847d62-8f24-433d-b526-86c2fc353d72
PlutoUI.TableOfContents(include_definitions=true)

# ╔═╡ d917d940-3de5-4f0a-a83e-33c0522b2c83
html"""
<style>
@import url('https://fonts.googleapis.com/css2?family=Jaldi:wght@400;700&display=swap');

pluto-output {
	font-family: 'Jaldi', sans-serif;
	overflow-y: hidden;
}

html {
	font-size: 20px;
}

pluto-output h1, pluto-output h2, pluto-output h3, pluto-output h4, pluto-output h5, pluto-output h6 {
font-family: Jaldi, sans-serif;
	line-height: 1;
}

pluto-output .pluto-docs-binding h1 {
	font-size: 1.4em;
}

pluto-output h1 {
	margin-block-start: 2.5em !important;
}

pluto-output .pluto-docs-binding h2 {
    font-size: 1.3em;
}
pluto-output .pluto-docs-binding h3,
pluto-output .pluto-docs-binding h4,
pluto-output .pluto-docs-binding h5,
pluto-output .pluto-docs-binding h6
{
    font-size: 1.1em;
}
</style>
"""

# ╔═╡ 8dac5863-86e0-483c-bce2-f396c698ddb3
pkgversion(PlutoDependencyExplorer)

# ╔═╡ Cell order:
# ╟─23847d62-8f24-433d-b526-86c2fc353d72
# ╠═7b69f72e-b489-11ee-170e-09164d49c53e
# ╠═eb1476da-363f-4ddd-a10b-8e6b5e177045
# ╟─488a0b76-0d9e-46cc-8db0-f7e072e846f5
# ╠═8b669928-eb0d-47b6-bea3-da46e98291d3
# ╟─f10e5aee-a5da-45aa-89d6-8e47835ceffd
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
# ╟─effa9b86-f78f-47a7-898b-308a12c6fee7
# ╟─d917d940-3de5-4f0a-a83e-33c0522b2c83
# ╠═8dac5863-86e0-483c-bce2-f396c698ddb3
