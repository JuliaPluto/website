### A Pluto.jl notebook ###
# v0.20.3

#> [frontmatter]
#> title = "⚙️ Configuring Pluto"
#> date = "2024-04-22"
#> tags = ["docs", "introduction"]
#> description = "How to change settings of the Pluto.jl Julia notebook"
#> layout = "layout.jlhtml"
#> license = "MIT"
#> 
#>     [[frontmatter.author]]
#>     name = "Pluto.jl"
#>     url = "https://github.com/JuliaPluto"

using Markdown
using InteractiveUtils

# ╔═╡ 95afe010-00bf-11ef-3957-7bb8594e7a83
begin
	import Pkg
	pde = joinpath(pwd(), "..", "..", "..", "pluto-deployment-environment")
	if isdir(pde)
		Pkg.activate(pde, io=devnull)
		Pkg.instantiate(io=devnull)
	else
		@warn "Notebook launched outside of plutojl.org website repository... Installing Pluto from registry."
		Pkg.activate(temp=true)
		Pkg.add(["Pluto", "PlutoUI"])
	end
	import Pluto, PlutoUI
	using HypertextLiteral
end

# ╔═╡ 5a7dc99c-4229-4c7d-8464-8a57d9fcb517
PlutoUI.TableOfContents(include_definitions=true)

# ╔═╡ efda32af-e2e8-4793-b553-9c73706ea659
md"""
# Configuring Pluto
In Pluto's design, we always try our best to make choices that work best for our audience, rather than adding more settings. We do this to make Pluto less intimidating to use for newcomers, and to avoid situations where issues are caused by a "wrong configuration".

However, there are some settings intended for **system administrators** (e.g. running a Pluto server for your students), and for **advanced Julia users**. 

These settings are mostly about the "backend" (everything you don't see). We intentionally don't have settings for the "frontend" (the GUI interface where you type code and see results). Such settings are usually more difficult to implement and maintain. In some cases, we also want to create a homogenous experience: a notebook should look the same on different computers.

## The best configuration
We thought long and hard to find the best default configuration. To get the best Pluto experience, **don't change these settings**.

## A custom experience
You can achieve a lot of customisability by writing special code! Take a look at [PlutoLinks.jl](https://github.com/JuliaPluto/PlutoLinks.jl), [PlutoHooks.jl](https://github.com/JuliaPluto/PlutoLinks.jl) and [AbstractPlutoDingetjes.jl](https://plutojl.org/en/docs/abstractplutodingetjes/). You can also use CSS (e.g. with [HypertextLiteral.jl](https://github.com/JuliaPluto/HypertextLiteral.jl)) to customise the look of a notebook.
"""

# ╔═╡ a0da0b14-566e-4adc-bf23-702699e02c72
md"""
# How to use settings

## Option 1: `Pluto.run(; kwargs...)`

The easiest way to configure Pluto is by providing keyword arguments to `Pluto.run`. For example, to configure the port used to run Pluto:

```julia
Pluto.run(port=1235)
```
"""

# ╔═╡ 6606f0f0-e42d-4eef-bf57-fa02f165851d
md"""
## Option 2: `Pluto.ServerSession`

You can also create a session first, configure it, and then run a server on that session.

```julia
session = Pluto.ServerSession()

session.options.server.auto_reload_from_file = true
session.options.server.optimize = 0

Pluto.run(session)
```
"""

# ╔═╡ cde195ce-fe33-48a7-9567-b4dc614a2e6f


# ╔═╡ bdee1b97-ee4b-4c5a-9207-fc4110fde5e2
@htl """
<ul>
$(map(categories) do c
	@htl "<li><a href=$(string("#", c))>$c</a></li>"
end)
</ul>
"""

# ╔═╡ 05a02bbb-3307-4e85-a090-d5e29e1a476a
begin
	categories = [
	:CompilerOptions,
	:ServerOptions,
	:SecurityOptions,
	:EvaluationOptions,
]
end;

# ╔═╡ 5378d3f6-8090-4461-b503-6cbab0eeebca
md"""
# Configuration options
Pluto's settings are divided into $(length(categories)) categories:
"""

# ╔═╡ a3b6dcaa-4e72-4e14-8046-e4f924ab71cc
Docs.Binding(Pluto.Configuration, categories[1])

# ╔═╡ a14926c8-01a9-43b9-abb4-c89da30a1091
Docs.Binding(Pluto.Configuration, categories[2])

# ╔═╡ c329cbad-4e62-45dc-b7a5-078d29dac386
Docs.Binding(Pluto.Configuration, categories[3])

# ╔═╡ 73055c07-db51-4669-8832-3879636a7801
Docs.Binding(Pluto.Configuration, categories[4])

# ╔═╡ Cell order:
# ╟─efda32af-e2e8-4793-b553-9c73706ea659
# ╟─5a7dc99c-4229-4c7d-8464-8a57d9fcb517
# ╟─a0da0b14-566e-4adc-bf23-702699e02c72
# ╟─6606f0f0-e42d-4eef-bf57-fa02f165851d
# ╟─cde195ce-fe33-48a7-9567-b4dc614a2e6f
# ╟─5378d3f6-8090-4461-b503-6cbab0eeebca
# ╟─bdee1b97-ee4b-4c5a-9207-fc4110fde5e2
# ╟─a3b6dcaa-4e72-4e14-8046-e4f924ab71cc
# ╟─a14926c8-01a9-43b9-abb4-c89da30a1091
# ╟─c329cbad-4e62-45dc-b7a5-078d29dac386
# ╟─73055c07-db51-4669-8832-3879636a7801
# ╟─95afe010-00bf-11ef-3957-7bb8594e7a83
# ╟─05a02bbb-3307-4e85-a090-d5e29e1a476a
