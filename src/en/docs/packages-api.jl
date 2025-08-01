### A Pluto.jl notebook ###
# v0.20.4

#> [frontmatter]
#> order = "3"
#> title = "Package API"
#> date = "2024-11-27"
#> tags = ["docs", "reproducibility"]
#> description = "Modify notebook package environments outside of Pluto."
#> license = "MIT"
#> layout = "layout.jlhtml"
#> 
#>     [[frontmatter.author]]
#>     name = "Pluto.jl"
#>     url = "https://github.com/JuliaPluto"

using Markdown
using InteractiveUtils

# ╔═╡ 0c25b6f0-049c-4f13-ba7c-95f7b6bc026a
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

# ╔═╡ d7eb33c5-f967-4c57-9bf8-4f7f14e3b8df
md"""
# Notebook package API

This article describes how to work with the package environment that is embedded in the notebook file. Pluto has some utility functions to let you use Pkg (and the Pkg REPL) to make changes to the embedded environment.

This is only useful for **advanced users**, who need more control over:
- Package sources (e.g. unregistered packages from github)
- Package version updates
- Compatibility bounds

**Before reading this**, learn more about the [built-in package manager](../packages/).
"""

# ╔═╡ b8895531-f0bc-4fb5-802f-53578f815df9
PlutoUI.TableOfContents(include_definitions=true)

# ╔═╡ 247d4ce2-a19e-11ef-0e80-43396382aaec
md"""
# Embedded environment?

Notebooks that use Pluto's built-in package manager have **embedded Project.toml and Manifest.toml files**. [Learn more about these files.](https://pkgdocs.julialang.org/v1/toml-files/) That means that these files are stored inside the `.jl` notebook file, as special strings at the bottom of the file.

For example, take a look at this [`.jl` notebook file](https://github.com/JuliaPluto/featured/blob/v5/language/Structure%20and%20language.jl). Notice how the bottom of the file contains this special code:

```julia
(...more...)

# 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = ""\"
[deps]
Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
Compose = "a81c6b42-2e10-5240-aca2-a61377ecd94b"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Unicode = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[compat]
Colors = "~0.12.8"
Compose = "~0.9.4"
PlutoTeachingTools = "~0.2.15"
PlutoUI = "~0.7.48"
""\"

# 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = "\""
# This file is machine-generated - editing it directly is not advised

[[AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
(...more...)
```

This is the embedded Project.toml and Manifest.toml, which together define the package environment of the notebook. 

"""

# ╔═╡ ba29e8b2-507c-4171-ad59-255b882334bb


# ╔═╡ 14a808ad-c1f8-4590-9acb-c82656fcd497


# ╔═╡ bec7d585-e345-4199-9262-982cc6537fe2
Docs.Binding(Pluto.Configuration, categories[4])

# ╔═╡ Cell order:
# ╟─d7eb33c5-f967-4c57-9bf8-4f7f14e3b8df
# ╟─b8895531-f0bc-4fb5-802f-53578f815df9
# ╟─247d4ce2-a19e-11ef-0e80-43396382aaec
# ╟─ba29e8b2-507c-4171-ad59-255b882334bb
# ╠═14a808ad-c1f8-4590-9acb-c82656fcd497
# ╠═bec7d585-e345-4199-9262-982cc6537fe2
# ╠═0c25b6f0-049c-4f13-ba7c-95f7b6bc026a
