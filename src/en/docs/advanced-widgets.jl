### A Pluto.jl notebook ###
# v0.19.41

#> [frontmatter]
#> title = "Advanced widgets – overview"
#> date = "2024-04-22"
#> tags = ["docs", "advanced", "widgets", "AbstractPlutoDingetjes", "JavaScript"]
#> description = "Pluto provides a framework for advances input and display widgets."
#> layout = "docsnotebook.jlmd"
#> license = "Unlicense"
#> 
#>     [[frontmatter.author]]
#>     name = "Pluto.jl"
#>     url = "https://github.com/JuliaPluto"

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ a17a8282-05f6-469d-9579-63029db89f79
using HypertextLiteral

# ╔═╡ 810b3d50-00e0-11ef-034d-73dc15b2f8bd
using PlutoUI

# ╔═╡ 1913bd73-41fb-437a-9505-4e0f24d62ac6
md"""
# Developing advanced widgets for Pluto

Pluto has a number of advanced features for developers who want to create complex widgets for Pluto. Let's define some categories:
- **Custom input** for `@bind`
- **Custom output** for visualising results

"""

# ╔═╡ 41fd552d-35bd-4be6-b103-116f4bcd4998
md"""

# Custom input
PlutoUI.jl provides some basic inputs, like sliders, textfields and more. But you can also make your own specialised widget! For example, you could make a
- [map location picker](https://github.com/lukavdplas/PlutoMapPicker.jl), showing a map, and giving back the clicked coordinate with `@bind`.
  ![screenshot](https://github.com/lukavdplas/PlutoMapPicker.jl/raw/main/screenshot.png)
- [chemical equation builder](https://youtu.be/lNbU5jNp67s?t=1546), giving back a Catalyst `ReactionSystem` with `@bind`.
  ![screenshot](https://github.com/fonsp/Pluto.jl/assets/6933510/0a27e62f-6ef1-4f13-b47c-2a2cefa8850a)
- widget composed with Markdown and PlutoUI, giving back 4 values in a tuple with `@bind`.
  ![screenshot](https://user-images.githubusercontent.com/6933510/145588612-14824654-5c73-45f8-983c-8913c7101a78.png)
 
"""

# ╔═╡ 782f4475-3e54-4916-8e7a-616a14dc9cc8
md"""

## Julia only: Composing widgets
Some widgets can be written as a combination of existing inputs, and static content like text, styles, layout and images. For this, you can use:
- [`PlutoUI.combine`](#combine)
- [`PlutoUI.Experimental.transformed_value`](#transformed_value)

In some cases, you might just want to "wrap" and existing widget in static content:
- [`PlutoUI.Experimental.wrapped`](#wrapped)
"""

# ╔═╡ b9926b7f-989f-47ed-8ab6-703d6ced1f21
Docs.Binding(PlutoUI, :combine)

# ╔═╡ 31cd3e04-48dd-40c2-8a29-78e7a0e8652b
Docs.Binding(PlutoUI.Experimental, :transformed_value)

# ╔═╡ 43eb1935-7eb7-40bc-9d8f-4c7e7e6d8f49
Docs.Binding(PlutoUI.Experimental, :wrapped)

# ╔═╡ eaa26f32-00c8-4c36-a8ee-3ff11e184e35
md"""
## Custom inputs with JavaScript

The Pluto developers 💖💖💖 love JavaScript! And Pluto also provides a first-class framework for writing widgets using JavaScript.

### Preliminary: writing JavaScript
Before reading further, make sure that you understand the basics of writing JavaScript inside Pluto, and that you know how to debug the web using the DevTools of your favourite browser. Take a look at the [featured notebooks](https://featured.plutojl.org/) about "Pluto and the Web" to learn more.

### Preliminary: `type-show-@htl`
Here is the core recipe to use when writing your own widgets:
1. Define a type
2. Define a `Base.show` method for HTML
3. Use `HypertextLiteral.@htl` to write your widget, using the `io` from `show`.

This should be the minimal template for every widget that you write.

```julia
import HypertextLiteral: @htl

begin
	struct MyCoolSlider
	    min::Real
	    max::Real
	end
	
	function Base.show(io::IO, m::MIME"text/html", d::MyCoolSlider)
	    show(io, m, @htl(
	        "\""
	        <input type=range min=$(d.min) max=$(d.max)>
	        ""\"
	    ))
	end
end
```

```julia
# use it like so
@bind value MyCoolSlider(5, 10)
```

Let's see it in action:
"""

# ╔═╡ 594b490b-0b06-46c5-9da0-059480f208f1
import HypertextLiteral: @htl

# ╔═╡ c748e045-5bff-47ac-ac2c-5aa9d3e7f304
begin
	struct MyCoolSlider
	    min::Real
	    max::Real
	end

	function Base.show(io::IO, m::MIME"text/html", d::MyCoolSlider)
	    show(io, m, @htl(
	        """
	        <input type=range min=$(d.min) max=$(d.max)>
	        """
	    ))
	end
end

# ╔═╡ ed0dbaa0-5388-412f-9809-4765f5044726


# ╔═╡ f7490e24-abeb-4adf-89ec-544dee678d78
@bind value MyCoolSlider(5, 10)

# ╔═╡ 09b29454-50f9-4eb4-b984-6bf8f10c6324
value

# ╔═╡ fe1b49f0-77f8-40a5-bbef-1f4a0aa4837d
md"""
It works! Pluto renders you widget (by calling the `Base.show` method, and displaying that in the page), it then finds the first element (`<input ...>`). Pluto adds an event listener to the `"input"` event, and when fired (or when first rendered), Pluto takes the `.value` property, sends it to Julia, and it becomes your bound variable.
"""

# ╔═╡ 54ecd81d-01eb-45ac-9d2c-dc26393ea091
md"""
### Core concepts: `currentScript`, `value`, input event

The widget above (`MyCoolSlider`) works because the `input` element fires an `"input"` event when moved, and it has a `.value` property. This is true for [all the built-in `<input ...>` elements](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input).

Now... when writing your own inputs, you need to fake it! Set the `.value` property from JavaScript, and fire an `"input"` event. To select the element, `currentScript` is special API added by Pluto, it refers to the `<script>` element that your code is written in.

In the example below, our custom input element is a wrapper `<div>`, and we use JavaScript to select it with `currentScript.parentElement`, to set its `value` and to fire the `"input"` event. 👉 **Can you find this in the code?**
"""

# ╔═╡ a7d134fb-59fc-4275-b69a-ed441afa8278
begin
	struct RectangleDrawing
	end

	function Base.show(io::IO, m::MIME"text/html", rd::RectangleDrawing)
		Base.show(io, m, @htl(
		"""
		<div>
		
		<canvas width="200" height="200" style="position: relative"></canvas>
		
		<script>
		// 🐸 `currentScript` is the current script tag - we use it to select elements 🐸 //
		const div = currentScript.parentElement
		const canvas = div.querySelector("canvas")
		const ctx = canvas.getContext("2d")
		
		var startX = 80
		var startY = 40
		
		function onmove(e){
			// 🐸 We send the value back to Julia 🐸 //
			div.value = [e.layerX - startX, e.layerY - startY]
			div.dispatchEvent(new CustomEvent("input"))
		
			ctx.fillStyle = '#ffecec'
			ctx.fillRect(0, 0, 200, 200)
			ctx.fillStyle = '#3f3d6d'
			ctx.fillRect(startX, startY, ...div.value)
		}
		
		canvas.onpointerdown = e => {
			startX = e.layerX
			startY = e.layerY
			canvas.onpointermove = onmove
		}
		
		canvas.onpointerup = e => {
			canvas.onpointermove = null
		}
		
		// Fire a fake pointermoveevent to show something
		onmove({layerX: 130, layerY: 160})
		
		</script>
		</div>
		"""))
	end
end

# ╔═╡ 1eee3553-2b09-4611-9728-69a8f38a5dd1
md"""
Try dragging a rectangle in the box below:
"""

# ╔═╡ f4cc5757-0b32-42db-b0df-83030c9f7886
@bind dims RectangleDrawing()

# ╔═╡ 4da66c70-7d35-4a2f-a405-7b76555c0284
dims

# ╔═╡ 5148ee5f-7348-4189-a285-5586bf5a4ccf
area = abs(prod(dims))

# ╔═╡ 64b4a5a2-8708-40c7-8812-591c9e550d43


# ╔═╡ 547f90c5-f8de-4a1c-9b9e-25bf8c78161e
md"""
# Custom output

Pluto can be used as a framework to have high-quality widgets powered by JavaScript, displaying data and calculations from Julia. By creating a **Custom output**, you can wrap your JavaScript-powered widget into a Julia function, such as `plot(data)`.

Techniques used to power Custom Outputs can also be used in **Custom Inputs**! A Custom Input is just a Custom Output with added `@bind` support.
"""

# ╔═╡ e733647f-5af9-462c-9bb6-ef4282a04f6c
md"""
## Core principle: a visualiser function with `@htl`

TODO
"""

# ╔═╡ b6b9a299-0d70-430c-8bf5-d10014261f27
md"""
## Julia only: Layout

TODO. See `PlutoUI.ExperimentalLayout`
"""

# ╔═╡ 0fcf5330-b9b6-4ebc-819d-c8860353a61d
md"""
## `AbstractPlutoDingetjes.Display`

We recommend reading [the docs of `AbstractPlutoDingetjes`](https://plutojl.org/en/docs/abstractplutodingetjes/), containing special API that we offer on top of the Web platform. In particular, I want to highlight two functions for special data needs:

Use `AbstractPlutoDingetjes.Display.published_to_js` when visualising a large amount of data using JavaScript, and just interpolating the data into a `<script>` in an `HypertextLiteral.@htl` expression is not performant enough.

```julia
HypertextLiteral.@htl(""\"
<script>
// the standard way, fast for small amounts of data:
let x = \$(my_vector)

// this is faster for large data
let y = \$(AbstractPlutoDingetjes.Display.published_to_js(my_big_vector))
</script>
"\"")
```

"""

# ╔═╡ 189cfef6-7bfb-4181-8d7a-3086324968f2
md"""
## `AbstractPlutoDingetjes.Display.with_js_link`


Use `AbstractPlutoDingetjes.Display.with_js_link` when you want to make on-demand requests to Julia from your JavaScript code.
"""

# ╔═╡ e5a05101-a023-40ad-9bef-c6c8d18eb719
import AbstractPlutoDingetjes

# ╔═╡ 0fff3ea7-74a5-4bd5-a205-db21b23a2601
Docs.Binding(AbstractPlutoDingetjes.Display, :published_to_js)

# ╔═╡ 2320e06c-56f8-47ac-b532-a85ae2cbe3f5
Docs.Binding(AbstractPlutoDingetjes.Display, :with_js_link)

# ╔═╡ 80020cac-56d9-4a5b-9959-e61c7042d900
TableOfContents(include_definitions=true)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
AbstractPlutoDingetjes = "6e696c72-6542-2067-7265-42206c756150"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
AbstractPlutoDingetjes = "~1.3.1"
HypertextLiteral = "~0.9.5"
PlutoUI = "~0.7.58"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.0"
manifest_format = "2.0"
project_hash = "88e3ec972704b9568612a10fd51d49f28f47cd6f"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "297b6b41b66ac7cbbebb4a740844310db9fd7b8c"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.1"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+1"

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
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

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
git-tree-sha1 = "8b72179abc660bfab5e28472e019392b97d0985c"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.4"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

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
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

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
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+2"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "71a22244e352aa8c5f0f2adde4150f62368a3f2e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.58"

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

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

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

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

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

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

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
version = "5.8.0+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─1913bd73-41fb-437a-9505-4e0f24d62ac6
# ╟─41fd552d-35bd-4be6-b103-116f4bcd4998
# ╟─782f4475-3e54-4916-8e7a-616a14dc9cc8
# ╟─b9926b7f-989f-47ed-8ab6-703d6ced1f21
# ╟─31cd3e04-48dd-40c2-8a29-78e7a0e8652b
# ╟─43eb1935-7eb7-40bc-9d8f-4c7e7e6d8f49
# ╟─eaa26f32-00c8-4c36-a8ee-3ff11e184e35
# ╠═594b490b-0b06-46c5-9da0-059480f208f1
# ╠═c748e045-5bff-47ac-ac2c-5aa9d3e7f304
# ╟─ed0dbaa0-5388-412f-9809-4765f5044726
# ╠═f7490e24-abeb-4adf-89ec-544dee678d78
# ╠═09b29454-50f9-4eb4-b984-6bf8f10c6324
# ╟─fe1b49f0-77f8-40a5-bbef-1f4a0aa4837d
# ╟─54ecd81d-01eb-45ac-9d2c-dc26393ea091
# ╠═a7d134fb-59fc-4275-b69a-ed441afa8278
# ╠═4da66c70-7d35-4a2f-a405-7b76555c0284
# ╠═5148ee5f-7348-4189-a285-5586bf5a4ccf
# ╟─1eee3553-2b09-4611-9728-69a8f38a5dd1
# ╠═f4cc5757-0b32-42db-b0df-83030c9f7886
# ╟─64b4a5a2-8708-40c7-8812-591c9e550d43
# ╟─547f90c5-f8de-4a1c-9b9e-25bf8c78161e
# ╠═e733647f-5af9-462c-9bb6-ef4282a04f6c
# ╠═b6b9a299-0d70-430c-8bf5-d10014261f27
# ╟─0fcf5330-b9b6-4ebc-819d-c8860353a61d
# ╟─0fff3ea7-74a5-4bd5-a205-db21b23a2601
# ╟─189cfef6-7bfb-4181-8d7a-3086324968f2
# ╟─2320e06c-56f8-47ac-b532-a85ae2cbe3f5
# ╠═a17a8282-05f6-469d-9579-63029db89f79
# ╠═e5a05101-a023-40ad-9bef-c6c8d18eb719
# ╟─810b3d50-00e0-11ef-034d-73dc15b2f8bd
# ╟─80020cac-56d9-4a5b-9959-e61c7042d900
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
