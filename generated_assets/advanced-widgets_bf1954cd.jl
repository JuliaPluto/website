### A Pluto.jl notebook ###
# v1.0.0

#> [frontmatter]
#> image = "https://github.com/fonsp/Pluto.jl/assets/6933510/0a27e62f-6ef1-4f13-b47c-2a2cefa8850a"
#> order = "0"
#> title = "Advanced widgets – overview"
#> date = "2024-04-22"
#> tags = ["docs", "advanced", "widgets", "AbstractPlutoDingetjes", "JavaScript"]
#> description = "Pluto provides a framework for advanced input and display widgets."
#> layout = "layout.jlhtml"
#> license = "Unlicense"
#> 
#>     [[frontmatter.author]]
#>     name = "Pluto.jl"
#>     url = "https://github.com/JuliaPluto"

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ d2e3a7f6-52a8-43bb-9edf-be13aecaff21
begin
	import Pkg
	pde = joinpath(pwd(), "..", "..", "..", "pluto-deployment-environment")
	if isdir(pde)
		Pkg.activate(pde, io=devnull)
		Pkg.instantiate(io=devnull)
	else
		@warn "Notebook launched outside of plutojl.org website repository... Installing packages from registry."
		Pkg.activate(temp=true)
		Pkg.add(["HypertextLiteral", "AbstractPlutoDingetjes", "PlutoUI"])
	end
	import AbstractPlutoDingetjes
	using HypertextLiteral, PlutoUI

	Text("Packages loaded")
end

# ╔═╡ 1913bd73-41fb-437a-9505-4e0f24d62ac6
md"""
# Developing advanced widgets for Pluto

Pluto has a number of advanced features for developers who want to create complex widgets for Pluto. Let's define some categories:
- **Custom inputs**: widgets that are used with `@bind`, like a slider or a map location picker.
- **Custom outputs**: for visualising results, like a plot or a map with labels.

Pluto provides lots of API that lets you write your own widgets, using a high level of integration into the Pluto engine. You can easily add Pluto-specific widgets to an existing package (without adding a Pluto dependency), or write a new package. [PlutoUI.jl](https://featured.plutojl.org/basic/plutoui.jl) is also built using this API.

**A quick list of things that our API offers**: You can use [HypertextLiteral.jl](https://github.com/JuliaPluto/HypertextLiteral.jl) (or similar) to create dynamic HTML output that reacts to data. We have a [JavaScript execution engine](https://plutojl.org/en/docs/javascript-api/), and you can [send large amounts of data](https://plutojl.org/en/docs/abstractplutodingetjes/#published_to_js) (like `Vector{Float64}`) directly to your visualization with minimal overhead. You can also [send _functions_](https://plutojl.org/en/docs/abstractplutodingetjes/#with_js_link), which can be called dynamically from JavaScript. Pluto's display system can be [embedded](https://plutojl.org/en/docs/abstractplutodingetjes/#@embed) inside of your app, and you can [manipulate Preact's Virtual DOM](https://plutojl.org/en/docs/abstractplutodingetjes/#ReactDOMElement) from Julia.
"""

# ╔═╡ daddd959-7aa1-44b2-b40b-8e8407863b48
md"""
!!! warning "This is an advanced guide"
	This document explains **how to make new widgets** for Pluto. 
	
	Are you looking for information on **getting started with interactivity in Pluto**, and how to use `@bind`? Then take a look at [the `@bind` documentation](../bind/) instead.
"""

# ╔═╡ 80020cac-56d9-4a5b-9959-e61c7042d900
TableOfContents(include_definitions=true)

# ╔═╡ 41fd552d-35bd-4be6-b103-116f4bcd4998
md"""

# Custom input
PlutoUI.jl provides some basic inputs, like sliders, textfields and more. But you can also make your own specialised widget! For example, you could make:


![screenshot of a map location picker](https://github.com/lukavdplas/PlutoMapPicker.jl/raw/main/screenshot.png)

A [map location picker](https://github.com/lukavdplas/PlutoMapPicker.jl), showing a map, and giving back the clicked coordinate with `@bind`.

![screenshot of a chemical equation builder](https://github.com/JuliaPluto/Pluto.jl/assets/6933510/0a27e62f-6ef1-4f13-b47c-2a2cefa8850a)

A [chemical equation builder](https://youtu.be/lNbU5jNp67s?t=1546), giving back a `Catalyst.ReactionSystem` with `@bind`.


![screenshot of a composed widget](https://user-images.githubusercontent.com/6933510/145588612-14824654-5c73-45f8-983c-8913c7101a78.png)

A widget composed with Markdown and PlutoUI, giving back 4 values in a tuple with `@bind`.
 
"""

# ╔═╡ 782f4475-3e54-4916-8e7a-616a14dc9cc8
md"""

## No JavaScript: Composing widgets
Some widgets can be written as a combination of existing inputs, and static content like text, styles, layout and images. This means that you can make simple widgets using only Julia and HTML or Markdown, without JavaScript. For this, you can use:
- [`PlutoUI.combine`](#combine)
- [`PlutoUI.Experimental.transformed_value`](#transformed_value)

In some cases, you might just want to "wrap" and existing widget in static content:
- [`PlutoUI.Experimental.wrapped`](#wrapped)

Widgets created with these methods can be published in a package!
"""

# ╔═╡ eaa26f32-00c8-4c36-a8ee-3ff11e184e35
md"""
## Custom inputs with JavaScript

The Pluto developers 💖💖💖 love JavaScript! And Pluto also provides a first-class framework for writing widgets using JavaScript.

### Preliminary: writing JavaScript
Before reading further, make sure that you understand the basics of writing JavaScript inside Pluto, and that you know how to debug the web using the DevTools of your favourite browser. To learn more, take a look at the [featured notebooks](https://featured.plutojl.org/) about "Pluto and the Web", and read the [documentation about our JavaScript API](https://plutojl.org/en/docs/javascript-api/).

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
It works! Pluto renders your widget (by calling the `Base.show` method, and displaying that in the page), it then finds the first element (`<input ...>`). Pluto adds an event listener to the `"input"` event, and when fired (or when first rendered), Pluto takes the `.value` property, sends it to Julia, and it becomes your bound variable.
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

# ╔═╡ 64b4a5a2-8708-40c7-8812-591c9e550d43


# ╔═╡ 547f90c5-f8de-4a1c-9b9e-25bf8c78161e
md"""
# Custom output

Pluto can be used as a framework to have high-quality widgets powered by JavaScript, displaying data and calculations from Julia. By creating a **Custom output**, you can wrap your JavaScript-powered widget into a Julia function, such as `plot(data)`.

Techniques used to power Custom Outputs can also be used in **Custom Inputs**! A Custom Input is just a Custom Output with added `@bind` support.

"""

# ╔═╡ e733647f-5af9-462c-9bb6-ef4282a04f6c
md"""
## Core principle: a visualiser function

TODO
"""

# ╔═╡ b6b9a299-0d70-430c-8bf5-d10014261f27
md"""
## Julia only: Layout

You can use `PlutoUI.ExperimentalLayout` to display objects in columns, grids, and more. This lets you put plots next to sliders, text and more.

"""

# ╔═╡ 0359ccba-8b57-47a7-a9a3-5d61419479f1
PlutoUI.ExperimentalLayout.grid([
	md"#### Layout demo!"      Text("")
	Text("I'm on the left")    Dict(:a => 1, :b => [2,3])
])

# ╔═╡ 119e9c4e-c695-4268-8ec6-b5a6f8d6f877
md"""
### Combining bonds and outputs
When you want to put a bond and an output in **the same cell** (like a slider next to a plot), you need to take special care. You need to **define the bond in a separate cell**, like so:
"""

# ╔═╡ 113b4f64-0c43-4c65-a0f1-e7a82de3fbed
bond = @bind val Slider(1:20)

# ╔═╡ b368f749-fbc6-4c44-a0ec-611a7506a0a5
PlutoUI.ExperimentalLayout.hbox([
	bond,
	collect(1:val)
])

# ╔═╡ 0cfe6b47-429f-49ff-bab7-e1662dd7805c
md"""
### Special features
Using `PlutoUI.ExperimentalLayout` has some special advantages over using `@htl` or another HMTL-based method to create layout: Pluto treats each item as its own display. So a 2x2 `grid` will act like 4 individual Pluto cells arranged in a grid.

In particular, if some of the items in a layout change, then only those items will be re-rendered. Items that stayed the same will be unaffected. For bonds, this means that they will not re-render and get reset to their initial value. When using HTML and JavaScript, this means that if your `Base.show` method returns exactly the same value, the re-render will not be trigger, and `<script>`s don't execute again.
"""

# ╔═╡ b6486d89-e91a-4fbd-96c0-b3cbf7a3e266
md"""
## HTML: HypertextLiteral and alternatives

You can achieve the best results when using HTML, CSS and JavaScript to power your widgets. This gives you full control over appearance and behaviour.

To use HTML inside a `Base.show` function, we highly recommend `@htl` from [HypertextLiteral.jl](https://github.com/JuliaPluto/HypertextLiteral.jl), a package developed in collaboration with the Pluto developers, but also useful outside of Pluto. It's a small dependency, and it gives optimal performance.

Another option is [HyperScript.jl](https://github.com/JuliaWeb/Hyperscript.jl), which provides a "Julia API to HTML", whereas HypertextLiteral is closer to HTML itself. You could also use no package, and use `write(io, "<div ...")` calls to output HTML without a package. For small widgets this will work well, but we would recommend starting with HypertextLiteral give more flexibility later, with little cost.
"""

# ╔═╡ e1086b5a-d99f-4df5-9e8b-0c41eba192f6
function emoji_list(xs::Vector{<:Integer})
	@htl("""
	<ol>
		$((
			@htl "<li>$(repeat("🌸",x))</li>"
		for x in xs))
	</ol>
	""")
end

# ╔═╡ eb229878-e216-4ae4-adaa-45911038522c
emoji_list([5,10,3,2,1])

# ╔═╡ 8baaf3e3-3854-44d8-827b-8853f5512e1f
html"""
<a href="https://github.com/JuliaPluto/HypertextLiteral.jl" class="arrow">Learn more: HypertextLiteral.jl</a>
"""

# ╔═╡ ff138461-4ce0-4c2c-b5c4-e90d8f53759a
md"""
## JavaScript API

`<script>` tags included in HTML output will be executed by Pluto, and you can use this to make interactive and dynamic widgets! In your code, you will mostly be using **Web APIs** (your code runs directly in the browser), like DOM manipulation. Use [javascript.info](https://javascript.info) or [MDN](https://developer.mozilla.org/) to learn more about Web APIs. You can also import JavaScript libraries and frameworks and use them in your widget.

We think the Web APIs and modern JavaScript are very powerful, and you should be able to do anything you want! However, we decided to add a **small amount of extra functionality** to make it easier to write code specifically for Pluto outputs.
"""

# ╔═╡ d36015bc-b8dc-458c-b5df-011accb09d12
html"""
<a href="https://plutojl.org/en/docs/javascript-api/" class="arrow">Learn more: JavaScript API</a>
"""

# ╔═╡ 0fcf5330-b9b6-4ebc-819d-c8860353a61d
md"""
## `AbstractPlutoDingetjes.jl`

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

# ╔═╡ bfded80a-6758-4260-b0d7-5601e5d22e14
md"""
Use `AbstractPlutoDingetjes.Display.with_js_link` when you want to make on-demand requests to Julia from your JavaScript code.
"""

# ╔═╡ e759af43-02c4-4408-8a48-bfc9adf4cfb7
md"""
If you create a widget with HTML/JS for multiple environments (VS Code, Jupyter, Documenter, Franklin, Bonito, Genie, etc), it can be useful to check whether the widget is being displayed in Pluto or not.

We recommend performing this check inside the `Base.show(io::IO, m::MIME"text/html", ...)` method, using like `is_inside_pluto(io::IO)` to check for Pluto, or `is_supported_by_display` to check for a specific Pluto feature.
"""

# ╔═╡ ae310b31-92d4-49ce-bff8-5f51fea6afc8
html"""
<a href="https://plutojl.org/en/docs/abstractplutodingetjes/" class="arrow">Find more in the AbstractPlutoDingetjes docs</a>
"""

# ╔═╡ 6ea4e81c-4afc-4414-8d03-daccdbe054c4
HiddenDocs(mod, name) = details(
	@htl("Show docstring for <code>$name</code>"), 
	@htl """
	<div class="pluto-docs-binding">
	<span id="$(name)">$(name)</span>
	$(Base.Docs.doc(Base.Docs.Binding(mod, name)))
	</div>
	""")

# ╔═╡ b9926b7f-989f-47ed-8ab6-703d6ced1f21
HiddenDocs(PlutoUI, :combine)

# ╔═╡ 31cd3e04-48dd-40c2-8a29-78e7a0e8652b
HiddenDocs(PlutoUI.Experimental, :transformed_value)

# ╔═╡ 43eb1935-7eb7-40bc-9d8f-4c7e7e6d8f49
HiddenDocs(PlutoUI.Experimental, :wrapped)

# ╔═╡ 0fff3ea7-74a5-4bd5-a205-db21b23a2601
HiddenDocs(AbstractPlutoDingetjes.Display, :published_to_js)

# ╔═╡ 2320e06c-56f8-47ac-b532-a85ae2cbe3f5
HiddenDocs(AbstractPlutoDingetjes.Display, :with_js_link)

# ╔═╡ 08293d88-66ff-433b-bd74-d53279235c88
HiddenDocs(AbstractPlutoDingetjes, :is_inside_pluto)

# ╔═╡ 3775fb8c-ec06-4482-9b0e-a4c1aa32afb7
HiddenDocs(AbstractPlutoDingetjes, :is_supported_by_display)

# ╔═╡ 404872d6-675e-4ac7-be0f-5e0dce836bfa
HiddenDocs(AbstractPlutoDingetjes.Display, Symbol("@embed"))

# ╔═╡ 965e17ea-cc2c-4072-82c4-94f259ce9224
md"""
# Distributing widgets

Once you created a cool widget, the most user-friendly way to distribute it is to **publish it in a package**. You can create a new package with your widget, or you can add it to an existing package.

## Dependencies
When distributing a widget in a package (ExampleWidget.jl), you do not need to add Pluto.jl as a dependency to your Project.toml. You just need to add the packages that you used. This could be: HypertextLiteral.jl or AbstractPlutoDingetjes.jl. If you used `combine` or another PlutoUI feature, you add PlutoUI.jl as a dependency.

HypertextLiteral.jl and especially AbstractPlutoDingetjes.jl are very small dependencies and will not add any noticeable lag to your package installation.

## Code in notebook or Julia file?
When prototyping your widget, you probably want to work fully inside a notebook. _(Tip: when editing the notebook, copy the `localhost` URL and open it in a second window. That way you can see the code and widget side-by-side.)_ Once you're done, you have two options for moving it to a package.

First, you could store your notebook file directly in the package source code. Use the "Disable in File" feature to disable cells where you test your widget.

![](https://github.com/JuliaPluto/AbstractPlutoDingetjes.jl/assets/6933510/f96980ff-83ce-4b15-8897-dc3e3b1ba72e)

Second, you could move your code to a classic `.jl` file. Then you could use Revise.jl (or `@revise` from [PlutoLinks.jl](https://github.com/JuliaPluto/PlutoLinks.jl)) to test it in a notebook while developing the widget. This option might be nicer if your widget has a lot of JavaScript code.

## Publishing small packages?
If you just created one cool widget, you might think: "I want to publish this, but it's too small for a package!".

Here is a little political message from fons: do it anyways! Life is too short to not publish small packages! If you made something fun or valuable, you totally deserve to publish it and share it with others. 💛 It's really valuable for others, and a cool experience for you!

Publishing a widget in a small package is really valuable:
- Others can **use it by simply typing `import ExampleWidget` in a notebook**. Without publishing it on General, users need to download scripts, copy code, ... This creates lots of hard-to-reproduce notebooks!
- Once it's on the registry, it's **easier for people to discover**! Especially if the name starts with `Pluto`, like PlutoMapPicker.jl. People searching for your widget can find it online, because registered package show up on juliahub.com and more.
- It's easy to get feedback, bug reports and contributions from users. And you can easily make patches and release them to your users. Or maybe it was right from the start, and you don't need this!
"""

# ╔═╡ 35085d64-c324-43d6-a316-0edbf4a97bf1
demo_img = let
	url = "https://user-images.githubusercontent.com/6933510/116753174-fa40ab80-aa06-11eb-94d7-88f4171970b2.jpeg"
	data = read(download(url))
	PlutoUI.Show(MIME"image/jpg"(), data)
end

# ╔═╡ 7cea0a79-d139-4ed4-a0e5-ea1aae4c219e
demo_html = @htl("<b style='font-family: cursive;'>Hello!</b>")

# ╔═╡ Cell order:
# ╟─1913bd73-41fb-437a-9505-4e0f24d62ac6
# ╟─daddd959-7aa1-44b2-b40b-8e8407863b48
# ╟─80020cac-56d9-4a5b-9959-e61c7042d900
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
# ╟─1eee3553-2b09-4611-9728-69a8f38a5dd1
# ╠═f4cc5757-0b32-42db-b0df-83030c9f7886
# ╠═4da66c70-7d35-4a2f-a405-7b76555c0284
# ╟─64b4a5a2-8708-40c7-8812-591c9e550d43
# ╟─547f90c5-f8de-4a1c-9b9e-25bf8c78161e
# ╟─e733647f-5af9-462c-9bb6-ef4282a04f6c
# ╟─b6b9a299-0d70-430c-8bf5-d10014261f27
# ╠═0359ccba-8b57-47a7-a9a3-5d61419479f1
# ╟─119e9c4e-c695-4268-8ec6-b5a6f8d6f877
# ╠═113b4f64-0c43-4c65-a0f1-e7a82de3fbed
# ╠═b368f749-fbc6-4c44-a0ec-611a7506a0a5
# ╟─0cfe6b47-429f-49ff-bab7-e1662dd7805c
# ╟─b6486d89-e91a-4fbd-96c0-b3cbf7a3e266
# ╠═e1086b5a-d99f-4df5-9e8b-0c41eba192f6
# ╠═eb229878-e216-4ae4-adaa-45911038522c
# ╟─8baaf3e3-3854-44d8-827b-8853f5512e1f
# ╟─ff138461-4ce0-4c2c-b5c4-e90d8f53759a
# ╟─d36015bc-b8dc-458c-b5df-011accb09d12
# ╟─0fcf5330-b9b6-4ebc-819d-c8860353a61d
# ╟─0fff3ea7-74a5-4bd5-a205-db21b23a2601
# ╟─bfded80a-6758-4260-b0d7-5601e5d22e14
# ╟─2320e06c-56f8-47ac-b532-a85ae2cbe3f5
# ╟─e759af43-02c4-4408-8a48-bfc9adf4cfb7
# ╟─08293d88-66ff-433b-bd74-d53279235c88
# ╟─3775fb8c-ec06-4482-9b0e-a4c1aa32afb7
# ╟─404872d6-675e-4ac7-be0f-5e0dce836bfa
# ╟─ae310b31-92d4-49ce-bff8-5f51fea6afc8
# ╟─6ea4e81c-4afc-4414-8d03-daccdbe054c4
# ╟─965e17ea-cc2c-4072-82c4-94f259ce9224
# ╟─35085d64-c324-43d6-a316-0edbf4a97bf1
# ╟─7cea0a79-d139-4ed4-a0e5-ea1aae4c219e
# ╟─d2e3a7f6-52a8-43bb-9edf-be13aecaff21
