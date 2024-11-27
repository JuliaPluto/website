### A Pluto.jl notebook ###
# v0.19.42

#> [frontmatter]
#> image = "https://github.com/fonsp/Pluto.jl/assets/6933510/0a27e62f-6ef1-4f13-b47c-2a2cefa8850a"
#> order = "0"
#> title = "Advanced widgets – overview"
#> date = "2024-04-22"
#> tags = ["docs", "advanced", "widgets", "AbstractPlutoDingetjes", "JavaScript"]
#> description = "Pluto provides a framework for advances input and display widgets."
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
- **Custom inputs**: widgets that are used with `@bind`, like a slider or a map location picker.
- **Custom outputs**: for visualising results, like a plot or a map with labels.

"""

# ╔═╡ 80020cac-56d9-4a5b-9959-e61c7042d900
TableOfContents(include_definitions=true)

# ╔═╡ 41fd552d-35bd-4be6-b103-116f4bcd4998
md"""

# Custom input
PlutoUI.jl provides some basic inputs, like sliders, textfields and more. But you can also make your own specialised widget! For example, you could make a
- [map location picker](https://github.com/lukavdplas/PlutoMapPicker.jl), showing a map, and giving back the clicked coordinate with `@bind`.
  ![screenshot](https://github.com/lukavdplas/PlutoMapPicker.jl/raw/main/screenshot.png)
- [chemical equation builder](https://youtu.be/lNbU5jNp67s?t=1546), giving back a `Catalyst.ReactionSystem` with `@bind`.
  ![screenshot](https://github.com/fonsp/Pluto.jl/assets/6933510/0a27e62f-6ef1-4f13-b47c-2a2cefa8850a)
- widget composed with Markdown and PlutoUI, giving back 4 values in a tuple with `@bind`.
  ![screenshot](https://user-images.githubusercontent.com/6933510/145588612-14824654-5c73-45f8-983c-8913c7101a78.png)
 
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
	md"# Layout demo!"      Text("")
	Text("I'm on the left") Dict(:a => 1, :b => [2,3])
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

# ╔═╡ 86c77330-d553-4e04-8e7e-38de72626bba
md"""
### Embeddable output

Pluto has a multimedia object viewer, which is used to display the result of a cell's output. Depending on the _type_ of the resulting object, the richest possible viewer is used. This includes:
- an interactive structure viewer for arrays, tables, dictionaries and more: 
  $(embed_display([1,2,(a=3, b=4)]))
- an `<img>` tag with optimized data transfer for images: $(embed_display(demo_img))
- raw HTML for HTML-showable objects: $(embed_display(demo_html))

Normally, you get this object viewer for the _output_ of a cell. However, as demonstrated in the list above, you can also **embed Pluto's object viewer in your own HTML**. To do so, Pluto provides a function:
```julia
embed_display(x)
```

#### Example

As an example, here is how you display two arrays side-by-side:

```julia
@htl("\""

<div style="display: flex;">
$(embed_display(rand(4)))
$(embed_display(rand(4)))
</div>

"\"")
```

Currently, you use this function with `PlutoRunner.embed_display` or just `embed_display`. In the future, this will be `AbstractPlutoDingetjes.Display.embed_display`, please comment [this PR](https://github.com/JuliaPluto/AbstractPlutoDingetjes.jl/pull/9) if you want it!

You can [learn more](https://github.com/fonsp/Pluto.jl/pull/1126) about how this feature works, or how to use it inside packages.
"""

# ╔═╡ e5a05101-a023-40ad-9bef-c6c8d18eb719
import AbstractPlutoDingetjes

# ╔═╡ 0fff3ea7-74a5-4bd5-a205-db21b23a2601
Docs.Binding(AbstractPlutoDingetjes.Display, :published_to_js)

# ╔═╡ 2320e06c-56f8-47ac-b532-a85ae2cbe3f5
Docs.Binding(AbstractPlutoDingetjes.Display, :with_js_link)

# ╔═╡ 08293d88-66ff-433b-bd74-d53279235c88
Docs.Binding(AbstractPlutoDingetjes, :is_inside_pluto)

# ╔═╡ 3775fb8c-ec06-4482-9b0e-a4c1aa32afb7
Docs.Binding(AbstractPlutoDingetjes, :is_supported_by_display)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
AbstractPlutoDingetjes = "6e696c72-6542-2067-7265-42206c756150"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
AbstractPlutoDingetjes = "~1.3.2"
HypertextLiteral = "~0.9.5"
PlutoUI = "~0.7.59"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.0"
manifest_format = "2.0"
project_hash = "7965676cd23ebed3ba799477cbe6198412888fe8"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

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
git-tree-sha1 = "ab55ee1510ad2af0ff674dbcced5e94921f867a9"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.59"

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
# ╠═e733647f-5af9-462c-9bb6-ef4282a04f6c
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
# ╟─ae310b31-92d4-49ce-bff8-5f51fea6afc8
# ╟─86c77330-d553-4e04-8e7e-38de72626bba
# ╟─965e17ea-cc2c-4072-82c4-94f259ce9224
# ╟─35085d64-c324-43d6-a316-0edbf4a97bf1
# ╟─7cea0a79-d139-4ed4-a0e5-ea1aae4c219e
# ╠═a17a8282-05f6-469d-9579-63029db89f79
# ╠═e5a05101-a023-40ad-9bef-c6c8d18eb719
# ╠═810b3d50-00e0-11ef-034d-73dc15b2f8bd
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
