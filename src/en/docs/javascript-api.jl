### A Pluto.jl notebook ###
# v0.20.14

#> [frontmatter]
#> license_url = "https://github.com/JuliaPluto/featured/blob/2a6a9664e5428b37abe4957c1dca0994f4a8b7fd/LICENSES/Unlicense"
#> image = "https://upload.wikimedia.org/wikipedia/commons/9/99/Unofficial_JavaScript_logo_2.svg"
#> order = "3"
#> title = "JavaScript API"
#> tags = ["javascript", "web", "widgets", "advanced", "docs"]
#> license = "Unlicense"
#> description = "Use JavaScript to make your own interactive visualizations!"
#> date = "2024-04-24"
#> layout = "layout.jlhtml"
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

# ╔═╡ 571613a1-6b4b-496d-9a68-aac3f6a83a4b
using HypertextLiteral

# ╔═╡ 6619d10d-d1e0-493d-b854-3deff1cf001f
using PlutoUI

# ╔═╡ 97914842-76d2-11eb-0c48-a7eedca870fb
md"""
# JavaScript API

`<script>` tags included in HTML output will be executed by Pluto, and you can use this to make interactive and dynamic widgets! In your code, you will mostly be using **Web APIs** (your code runs directly in the browser), like DOM manipulation. Use [javascript.info](https://javascript.info) or [MDN](https://developer.mozilla.org/) to learn more about Web APIs. You can also import JavaScript libraries and frameworks and use them in your widget.

We think the Web APIs and modern JavaScript are very powerful, and you should be able to do anything you want! However, we decided to add a **small amount of extra functionality** to make it easier to write code specifically for Pluto outputs.
"""

# ╔═╡ 88120468-a43d-4d58-ac04-9cc7c86ca179
md"""
# Debugging

The HTML, CSS and JavaScript that you write run in the browser, so you should use the [browser's built-in developer tools](https://developer.mozilla.org/en-US/docs/Learn/Common_questions/What_are_browser_developer_tools) to debug your code. 

Check to make sure that you are able to debug JavaScript code:
"""

# ╔═╡ ea4b2da1-4c83-4a1f-8fc3-c71a120e58e1
@htl("""
<script>

console.info("Can you find this message in the console?")

</script>
""")

# ╔═╡ 321b7f2e-542a-43af-bd4d-1264f5438322
md"""
And HTML and CSS:
"""

# ╔═╡ 08bdeaff-5bfb-49ab-b4cc-3a3446c63edc
@htl("""
	<style>
	.cool-class {
		font-size: 1.3rem;
		color: purple;
		background: lightBlue;
		padding: 1rem;
		border-radius: 1rem;
	}
	
	
	</style>
	
	<div class="cool-class">Can you find out which CSS class this is?</div>
	""")

# ╔═╡ abd91e68-121b-46fc-830f-238f38329f0e
html"<span id=currentScript>"

# ╔═╡ 9b6b5da9-8372-4ebf-9c66-ae9fcfc45d47
md"""
# `currentScript` – Selecting elements

When writing the javascript code for a widget, it is common to **select elements inside the widgets** to manipulate them. In the number-of-clicks example above, we selected the `<span>` and `<button>` elements in our code, to trigger the input event, and attach event listeners, respectively.

There are a numbers of ways to do this, and the recommended strategy is to **create a wrapper `<span>`, and use `currentScript.parentElement` to select it**.

### `currentScript`

When Pluto runs the code inside `<script>` tags, it assigns a reference to that script element to a variable called `currentScript`. You can then use properties like `previousElementSibling` or `parentElement` to "navigate to other elements".

Let's look at the "wrapper span strategy" again.

```htmlmixed
@htl("\""

<!-- the wrapper span -->
<span>

	<button id="first">Hello</button>
	<button id="second">Julians!</button>
	
	<script>
		const wrapper_span = currentScript.parentElement
		// we can now use querySelector to select anything we want
		const first_button = wrapper_span.querySelector("button#first")

		console.log(first_button)
	</script>
</span>
"\"")
```
"""

# ╔═╡ f18b98f7-1e0f-4273-896f-8a667d15605b
md"""
#### Why not just select on `document.body`?

In the example above, it would have been easier to just select the button directly, using:
```javascript
// ⛔ do no use:
const first_button = document.body.querySelector("button#first")
```

However, this becomes a problem when **combining using the widget multiple times in the same notebook**, since all selectors will point to the first instance. 

Similarly, try not to search relative to the `<pluto-cell>` or `<pluto-output>` element, because users might want to combine multiple instances of the widget in a single cell.
"""

# ╔═╡ ce78a32b-cde5-411a-ad8e-c52dc6228d00
html"""
<span id=value></span>
<span id=input></span>
<span id=bond></span>
"""

# ╔═╡ 75e1a973-7ef0-4ac5-b3e2-5edb63577927
md"""
# `value` – Custom `@bind` value
**You can use JavaScript to write input widgets** to be used with Pluto's `@bind`. The `input` event can be triggered on any object using

```javascript
obj.value = ...
obj.dispatchEvent(new CustomEvent("input"))
```

For example, here is a button widget that will send the number of times it has been clicked as the bound value:

"""

# ╔═╡ dd589798-81d7-412d-b689-80c75eba3cd8
@bind hello @htl("""
<div>
<button>Click me</button>

<script>
let val = 0
const div = currentScript.parentElement
const button = div.querySelector("button")

button.addEventListener("click", () => {
	// 🐸 Set the value of the div element and trigger an event! 🐸
	div.value = val++
	div.dispatchEvent(new CustomEvent("input"))
})
</script>
</div>
""")

# ╔═╡ 4a446964-104d-425b-8afe-cfd07474a7a2
hello

# ╔═╡ 320c1fa1-44c5-4832-9d17-87a2cfd83d9d
md"""
## Default value: `missing`
When you write `@bind x Widget()` in your notebook, what is the initial value of `x`? By default, the macro `@bind` will set `x` to [**`missing`**](https://docs.julialang.org/en/v1/manual/missing/), which will be the value of `x` while other cells are also running. 

Once all cells completed running, your browser can send the `.value` that it got from JavaScript, and cells that depend on `x` will run again with the value. (These messages were *debounced* while cells were running, see section below.)

This means that simple JavaScript-powered custom `@bind` widgets will trigger two runs when used in a notebook: a first run with value `missing`, and a second run with the first value from JavaScript.

### `AbstractPlutoDingetjes.Bonds.initial_value`
To solve this, you can use [`AbstractPlutoDingetjes.Bonds.initial_value`](https://plutojl.org/en/docs/abstractplutodingetjes/#initial_value) to tell Julia what the first value will be. This will then be used as the first value instead of `missing`. And if the first bond update from JavaScript is exactly the same, then this first bond update will not trigger a reactive run.
"""

# ╔═╡ ada382a5-5375-4c96-95f7-9a8721567fc4
md"""
## Debouncing
Pluto automatically debounces all bonds: while cells are running, no intermediate values are sent. Once all cells completed running, any queued bond updates are sent in one batch, but if the value of the same bond changed multiple times, only the last value is set, and intermediate values are discarded.

This prevents a "queue of updates" that you could get when a bond controls a visualisation that takes a while to run. You could try it below:
"""

# ╔═╡ 7510b8bc-ea4d-43f9-be7c-e9529fe418a9
@bind fun_fast Slider(1:100)

# ╔═╡ ba7b29da-b706-40a1-916b-df9667ba7726
fun_fast

# ╔═╡ eb7525c6-5593-4412-9535-39afab419891


# ╔═╡ 0dae6755-0e76-429a-8e12-15887e8f03c1
@bind fun_slow Slider(1:100)

# ╔═╡ 93dbb350-ef2c-4662-af1f-2b522407c51b
let
	sleep(1)
	fun_slow
end

# ╔═╡ 00fe3318-d05d-4f00-afe6-3191e2b70132
html"<span id=import>"

# ╔═╡ d83d57e2-4787-4b8d-8669-64ed73d79e73
md"""
# `import` – script loading

To use external javascript dependencies, you can load them from a CDN, such as:
- [jsdelivr.com](https://www.jsdelivr.com/)
- [esm.sh](https://esm.sh)

Just like when writing a browser app, there are two ways to import JS dependencies: a `<script>` tag, and the more modern ES6 import. (Technically, this is not API added by Pluto, this will work in any browser context. But we thought it's good to mention here.)

## Loading method 1: ES6 imports

We recommend that you use an [**ES6 import**](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules) if the library supports it. (If it does not, you might be able to still get it using [esm.sh](https://esm.sh)!)


##### Awkward note about syntax

Normally, you can import libraries inside JS using the import syntax:
```javascript
// ⛔ do no use:
import confetti from "https://esm.sh/canvas-confetti@1.4.0"
import { html, render, useEffect } from "https://cdn.jsdelivr.net/npm/htm@3.0.4/preact/standalone.mjs"
```

In Pluto, this is [currently not yet supported](https://github.com/fonsp/Pluto.jl/issues/992), and you need to use a different syntax as workaround:
```javascript
// ✔ use:
const { default: confetti } = await import("https://esm.sh/canvas-confetti@1.4.0")
const { html, render, useEffect } = await import("https://cdn.jsdelivr.net/npm/htm@3.0.4/preact/standalone.mjs")
```
"""

# ╔═╡ 077c95cf-2a1b-459f-830e-c29c11a2c5cc
md"""

## Loading method 2: script tag

`<script src="...">` tags with a `src` attribute set, like this tag to import the d3.js library:

```html
<script src="https://cdn.jsdelivr.net/npm/d3@6.2.0/dist/d3.min.js"></script>
```

will work as expected. The execution of other script tags within the same cell is delayed until a `src` script finished loading, and Pluto will make sure that every source file is only loaded once, even if the same `<script>` is included multiple times in multiple cells.
"""

# ╔═╡ 80511436-e41f-4913-8a30-d9e113cfaf71
md"""
## Pinning versions

When using a CDN almost **never** want to use an unpinned import. Always version your CDN imports!
```js
// ⛔ do no use:
"https://esm.sh/canvas-confetti"
"https://cdn.jsdelivr.net/npm/htm/preact/standalone.mjs"

// ✔ use:
"https://esm.sh/canvas-confetti@1.4.0"
"https://cdn.jsdelivr.net/npm/htm@3.0.4/preact/standalone.mjs"
```
"""

# ╔═╡ bd578b8a-f2dc-4299-8022-770f3323de4a
html"<span id=invalidation>"

# ╔═╡ 71b78f2b-c171-4807-a886-d2dfa5f203a9
md"""
# `invalidation` – cleanup

In a `<script>` you can use the variable **`invalidation`**, which is a [`Promise`](https://javascript.info/promise-basics) that resolves when the display is about to disappear. You can use this to clean up resources.

```html
@htl(""\"
<script>

invalidation.then(() => {
	// cleanup here!
})
</script>
""\")
```

😉 *To ObservableHQ users:* this is the same API as Observable!

"""

# ╔═╡ 311e95cf-ac6b-414b-873e-e5eb69d395e6
md"""
As a silly example, here is a widget that displays a `String`, and it loops through each of the letters, showing the UTF-16 character codes. The looping animation is created with `setInterval`, and when the display disappears, we use `invalidation` to call `clearInterval` and stop the loop.

Why do we need this? Every time you change the text in the `TextField`, this triggers a re-render of the cell. If we would not call `clearInterval`, then each text would create a new interval, slowly taking up more resources and slowing down the browser.
"""

# ╔═╡ 1a46b59a-5fa0-486d-9192-b44861bba930
@bind some_text TextField(default="Gecko")

# ╔═╡ 3fe7d1cd-edd7-48f6-987a-577b9e6125c3
@htl """
<div>
<h6>$some_text</h6>

<p>🔡 Letters: <span style="font-family: monospace; font-weight: 900;"></span></p>

<script>
const span = currentScript.parentElement.querySelector("span")
const original_text = $some_text
let i = 0

const interval_handler = setInterval(() => {
	const index = i % original_text.length
	const char = original_text[index]
	span.innerText = `#\${index}: \${char} (code: \${char.codePointAt(0)})`
	i++
}, 500)

invalidation.then(() => {
	clearTimeout(interval_handler)
})
</script>
</div>
"""

# ╔═╡ 3afa78e2-d01e-4fc0-ae1d-882fe6ca94f7
html"<span id=return>"

# ╔═╡ eda0947b-16d7-459f-89ef-9a8febf70354
md"""
# `return` – generate DOM from JavaScript

If you `<script>` tag returns a `HTMLElement` (like a `<div>` or `<input>`), Pluto will prepend that element before the `<script>` element that generated it. This makes it easier to use JavaScript code to create a DOM element.

(The element is added *before*, not *after* the script, so that it's a bit easier to use with `@bind`.)
"""

# ╔═╡ 0a051a07-4e5f-461d-a588-16b0cc3a3974
@htl("""
<script>
const element = document.createElement("h5")
element.innerText = "Whoopsiedoo!"
element.style.color = "orange"

return element
</script>
""")

# ╔═╡ 226cd4d6-e719-4e4a-b403-5024a7f83975
details("Show with syntax highlighting", md"""
	```htmlmixed
	<script>
	const element = document.createElement("h5")
	element.innerText = "Whoopsiedoo!"
	element.style.color = "orange"
	
	return element
	</script>
	```
	""")

# ╔═╡ 367701a7-82e6-4864-8975-9323060872d4
md"""
!!! info "Persistant display"
	Little technical note that you could ignore: if the following conditions are met:
	- The cell re-runs *reactively*, i.e. because one of the referenced variables re-runs, not because you run the cell itself;
	- The old display and the new display have an `id` attribute set to the same value.
	
	Then the DOM element returned by the old script is shown as placeholder while the new script is running (JS runs synchronously, but using top-level `await` can cause a delay). This prevents a flash of empty content in between cell renders. In particular, if the new script happens to `return` the exact same element (using `this` persistence), then that means the DOM element will always be displayed.
"""

# ╔═╡ 48c39379-361d-4adb-b65a-1e2cc07f11f5
html"<span id=await>"

# ╔═╡ 134f6baa-8f92-4ade-93aa-8dea42092597
md"""
# `await` – top-level support

You can use `await` in the top-level code of your script. And when your script uses `await`, Pluto will wait for the script to complete before executing the next script.

You can use top-level `await` to `import` libraries and more. `await` is also used internally by `AbstractPlutoDingetjes.Display.published_to_js`.

Here is a silly example, showing that use can use `await` and that scripts execute sequentially:
"""

# ╔═╡ 392dd5c9-23f8-4b40-a6aa-6e3e9ba76a83
@bind await_example_val TextField(default="coolbeans")

# ╔═╡ 48d47baa-edab-49e0-8cc3-b1ab04a70027
widget = @htl """
<div>
<p>Loading...</p>
<script>
const p = currentScript.previousElementSibling
const val = $await_example_val

await new Promise(resolve => {
	setTimeout(() => {
		p.innerText = val

		resolve()
	}, 1000)
})
</script>
</div>
""";

# ╔═╡ 0534ccd3-858f-4247-9dbc-26bea18e437f
@htl """
$widget
$widget
$widget
"""

# ╔═╡ b79cb583-6ebb-411d-845e-0e68c1fd5e27
html"<span id=observablehq>"

# ╔═╡ 27231bd2-deb3-4c37-849e-b07782439dea
md"""
# ObservableHQ stdlib
Pluto is inspired by [observablehq.com](https://observablehq.com/), an online reactive notebook for JavaScript. _(It's REALLY good, try it out!)_ We design Pluto's JavaScript runtime to be close to the way you write code in observable.

Read more about the observable runtime in their (interactive) [documentation](https://observablehq.com/@observablehq/observables-not-javascript). You will find that many features (`this`, `return`, `invalidation`, `await`) are similar in Pluto and Observable. 

The following is different in Pluto:
- JavaScript code is not reactive, there are no global variables.
- Cells can contain multiple script tags, and they will run consecutively (also when using `await`)
- We do not (yet) support async generators, i.e. `yield`.
- We do not support the observable keywords `viewof` and `mutable`.

In Pluto, the [`observablehq/stdlib`](https://github.com/observablehq/stdlib) library is pre-imported, and you can use:
- `DOM`
- `Files`
- `Generators`
- `Promises`
- `now`
- `svg`
- `html`
- `require`

Currently not supported are:
- `FileAttachment`
- `md`
- `Mutable`
- `resolve`
- `tex`
- `width`

If you need these libraries, just get in touch. We are also using an outdated version of the stdlib. If you want the latest version, get in touch!

You can use these libraries in top-level scripts, like `html` in this example:
"""

# ╔═╡ 6ce86c19-6f05-4679-b6dc-bd5a9945f316
@htl("""
<script>

return html`<h5>Hello world!</h5>`

</script>
""")

# ╔═╡ f611bf4e-8d7a-415a-8633-e5b84afe08e6
html"<span id=lodash>"

# ╔═╡ aaa3e85e-9b09-45ae-9c47-c14979cde65d
md"""
# Lodash
The [Lodash](https://lodash.com/) library is pre-imported, and is available with `_` inside your code.
"""

# ╔═╡ e32d8a7f-91e3-4d85-b1ca-b6afef83f433
@htl("""
<script>
	const data = $(rand(1:10, 15))
	const parted = _.partition(data, n => n % 2)
	
	return html`<ul>\${
		_.map(parted, (ns) => {
			return html`<li>\${ns.join(", ")}</li>`
		})
	}</ul>`

</script>
""")

# ╔═╡ 9d0e67d1-f6ed-4f1d-a181-28a6e9d7016a
html"<span id=this>"

# ╔═╡ a33c7d7a-8071-448e-abd6-4e38b5444a3a
md"""
# `this` – stateful output

In Pluto's runtime, there is a distinction between two types of ways that a cell can run:
1. **An explicit run**: a run triggered by user input (Ctrl+S, Shift+Enter or clicking the play button) or a cell deletion.
2. **A reactive re-run**: the cell runs because one of the variables referenced in the cell was redefined by another cell run.

One difference is the JavaScript API `this`: for an **explicit run**, the variable `this` is set to `undefined`. But with a **reactive run**, `this` will take the value of the last thing that was returned by the script. In particular, if you return an HTML node, and the cell runs a second time, then you can access the HTML node using `this`. Two reasons for using this feature are:
- Stateful output: you can persist some state in-between re-renders. 
- Performance: you can 'recycle' the previous DOM and update it partially (using d3, for example). _When doing so, Pluto guarantees that the DOM node will always be visible, without flicker._

##### ☝️ Caveat: `<script id=...>`
This feature is **only enabled** for `<script>` tags with the `id` attribute set, e.g. `<script id="first">`. Without an `id`, `this` will always be set to `window`. Think of setting the `id` attribute as saying: "I am a Pluto script". There are two reasons for this:
- One Pluto cell can output multiple scripts, Pluto needs to know which output to assign to which script.
- Some existing scripts assume that `this` is set to `window` in toplevel code (like in the browser). By hiding the `this`-feature behind this caveat, we still support libraries that output such scripts.

What should the `id` attribute be? This is a bit awkward: we don't know yet. For now, just use the name of your favourite ice cream, but we are working on [something better](https://github.com/JuliaPluto/AbstractPlutoDingetjes.jl/pull/7). Please comment on that PR if you want it!
"""

# ╔═╡ 91f3dab8-5521-44a0-9890-8d988a994076
trigger = "edit me!"

# ╔═╡ dcaae662-4a4f-4dd3-8763-89ea9eab7d43
let
	trigger
	
	html"""
	<script id="something">
	
	console.log("'this' is currently:", this)

	if(this == null) {
		return html`<blockquote>I am running for the first time!</blockqoute>`
	} else {
		return html`<blockquote><b>I was triggered by reactivity!</b></blockqoute>`
	}


	</script>
	"""
end

# ╔═╡ d4bdc4fe-2af8-402f-950f-2afaf77c62de
details("Show with syntax highlighting", md"""
	```htmlmixed
	<script id="something">
	
	console.log("'this' is currently:", this)

	if(this == null) {
		return html`<blockquote>I am running for the first time!</blockqoute>`
	} else {
		return html`<blockquote><b>I was triggered by reactivity!</b></blockqoute>`
	}


	</script>
	```
	""")

# ╔═╡ e77cfefc-429d-49db-8135-f4604f6a9f0b
md"""
### Example: d3.js transitions

Type the coordinates of the circles here! 
"""

# ╔═╡ 2d5689f5-1d63-4b8b-a103-da35933ad26e
@bind positions TextField(default="100, 300")

# ╔═╡ 6dd221d1-7fd8-446e-aced-950512ea34bc
dot_positions = try
	parse.([Int], split(replace(positions, ',' => ' ')))
catch e
	[100, 300]
end

# ╔═╡ 0a9d6e2d-3a41-4cd5-9a4e-a9b76ed89fa9
# dot_positions = [100, 300] # edit me!

# ╔═╡ 0962d456-1a76-4b0d-85ff-c9e7dc66621d
md"""
Notice that, even though the cell below re-runs, we **smoothly transition** between states. We use `this` to maintain the d3 transition states in-between reactive runs.
"""

# ╔═╡ bf9b36e8-14c5-477b-a54b-35ba8e415c77
@htl("""
<script src="https://cdn.jsdelivr.net/npm/d3@6.2.0/dist/d3.min.js"></script>

<script id="hello">

const positions = $(dot_positions)
	
const svg = this == null ? DOM.svg(600,200) : this
const s = this == null ? d3.select(svg) : this.s

s.selectAll("circle")
	.data(positions)
	.join("circle")
    .transition()
    .duration(300)
	.attr("cx", d => d)
	.attr("cy", 100)
	.attr("r", 10)
	.attr("fill", "gray")


const output = svg
output.s = s
return output
</script>

""")

# ╔═╡ e910982c-8508-4729-a75d-8b5b847918b6
details("Show with syntax highlighting", md"""
```htmlmixed
<script src="https://cdn.jsdelivr.net/npm/d3@6.2.0/dist/d3.min.js"></script>

<script id="hello">

const positions = $(dot_positions)

const svg = this == null ? DOM.svg(600,200) : this
const s = this == null ? d3.select(svg) : this.s

s.selectAll("circle")
	.data(positions)
	.join("circle")
	.transition()
	.duration(300)
	.attr("cx", d => d)
	.attr("cy", 100)
	.attr("r", 10)
	.attr("fill", "gray")


const output = svg
output.s = s
return output
</script>
```
""")

# ╔═╡ 781adedc-2da7-4394-b323-e508d614afae
md"""
### Example: Preact with persistent state
"""

# ╔═╡ de789ad1-8197-48ae-81b2-a21ec2340ae0
md"""
Modify `x`, add and remove elements, and notice that preact maintains its state.
"""

# ╔═╡ 85483b28-341e-4ed6-bb1e-66c33613725e
x = ["hello pluto!", 232000,2,2,12 ,12,2,21,1,2, 120000]

# ╔═╡ 05d28aa2-9622-4e62-ab39-ca4c7dde6eb4
details(md"""
	```htmlmixed
	<script type="module" id="asdf">
		//await new Promise(r => setTimeout(r, 1000))

		const { html, render, Component, useEffect, useLayoutEffect, useState, useRef, useMemo, createContext, useContext, } = await import( "https://cdn.jsdelivr.net/npm/htm@3.0.4/preact/standalone.mjs")

		const node = this ?? document.createElement("div")

		const new_state = $(state)

		if(this == null){

			// PREACT APP STARTS HERE

			const Item = ({value}) => {
				const [loading, set_loading] = useState(true)

				useEffect(() => {
					set_loading(true)

					const handle = setTimeout(() => {
						set_loading(false)
					}, 1000)

					return () => clearTimeout(handle)
				}, [value])

				return html`<li>\${loading ? 
					html`<em>Loading...</em>` : 
					value
				}</li>`
			}

			const App = () => {

				const [state, set_state] = useState(new_state)
				node.set_app_state = set_state

				return html`<h5>Hello world!</h5>
					<ul>\${
					state.x.map((x,i) => html`<\${Item} value=\${x} key=\${i}/>`)
				}</ul>`;
			}

			// PREACT APP ENDS HERE

			render(html`<\${App}/>`, node);

		} else {

			node.set_app_state(new_state)
		}
		return node
	</script>
	```
	""", "Show with syntax highlighting")

# ╔═╡ 3266f9e6-42ad-4103-8db3-b87d2c315290
state = Dict(
	:x => x
	)

# ╔═╡ 9e37c18c-3ebb-443a-9663-bb4064391d6e
@htl("""
<script id="asdf">
	//await new Promise(r => setTimeout(r, 1000))
	
	const { html, render, Component, useEffect, useLayoutEffect, useState, useRef, useMemo, createContext, useContext, } = await import( "https://cdn.jsdelivr.net/npm/htm@3.0.4/preact/standalone.mjs")

	const node = this ?? document.createElement("div")
	
	const new_state = $(state)
	
	if(this == null){
	
		// PREACT APP STARTS HERE
		
		const Item = ({value}) => {
			const [loading, set_loading] = useState(true)

			useEffect(() => {
				set_loading(true)

				const handle = setTimeout(() => {
					set_loading(false)
				}, 1000)

				return () => clearTimeout(handle)
			}, [value])

			return html`<li>\${loading ? 
				html`<em>Loading...</em>` : 
				value
			}</li>`
		}

        const App = () => {

            const [state, set_state] = useState(new_state)
            node.set_app_state = set_state

            return html`<h5>Hello world!</h5>
                <ul>\${
                state.x.map((x,i) => html`<\${Item} value=\${x} key=\${i}/>`)
            }</ul>`;
        }

		// PREACT APP ENDS HERE

        render(html`<\${App}/>`, node);
	
	} else {
		
		node.set_app_state(new_state)
	}
	return node
</script>
	
	
""")

# ╔═╡ ddbe51f7-538a-4eff-b23f-da8d4deebd3c
html"<span id=getBoundElementValueLikePluto></span><span id=setBoundElementValueLikePluto></span><span id=getBoundElementEventNameLikePluto></span>"

# ╔═╡ fa3a860c-0215-4b55-aec0-a151bcbe1a06
md"""
# Bond internals: `getBoundElementValueLikePluto`, `setBoundElementValueLikePluto`, `getBoundElementEventNameLikePluto`

Okay this one is not so exciting, but when you use `@bind`:

```julia
@bind x html("<some-element></some-element>")
```

Then Pluto will subscribe to the `"input"` event of `<some-element>`, and take its `.value` property to bind to the Julia variable. Well... almost! For some elements, the event name and value-getting is different. E.g. with `<button>`, we actually listen to `"click"` instead of `"input"`. And for `<input type=range>`, we get the `.valueAsNumber` property instead of `.value`.

This is what you can use these functions for:

```ts
getBoundElementValueLikePluto(element: HTMLElement): any
setBoundElementValueLikePluto(element: HTMLElement, value: any): void
getBoundElementEventNameLikePluto(element: HTMLElement): string
```

They can be useful when creating higher-order-widgets: widgets that layer on top of, or interact with other widgets.
"""

# ╔═╡ d8e77231-6982-4c31-8ace-22fefc6f1e17
html"""
<span id=metadata></span>
<span id=getNotebookMetadataExperimental></span>
<span id=setNotebookMetadataExperimental></span>
<span id=deleteNotebookMetadataExperimental></span>
<span id=getCellMetadataExperimental></span>
<span id=setCellMetadataExperimental></span>
<span id=deleteCellMetadataExperimental></span>
"""

# ╔═╡ b99c7ea3-b364-4588-98a7-0ab6d7f99b64
md"""
# Metadata for notebooks and cells


Notebooks can have metadata, which is stored as TOML content at the top of the `.jl` file. For example, [frontmatter](https://github.com/fonsp/Pluto.jl/pull/2104) is stored as notebook metadata.

We have some experimental API that lets you work with notebook metadata from widgets! This could be a very powerful feature when used well!

Note that you can also use [sessionStorage/localStorage](https://javascript.info/localstorage) inside your widgets. Think about what your storage should be persisted for:
- **`sessionStorage`**: reading a notebook, running and changing cells. But when opening the notebook tomorrow, it should be gone.
- **`localStorage`**: stored for a long time on this browser. Will be there tomorrow, but someone else opening the notebook will not have the data.
- **notebook/cell metadata**: stored permanently in the `.jl` file: when someone else opens the notebook, they will continue with your storage.

For this, we provide the following API:

```ts
getNotebookMetadataExperimental(key: string): any
setNotebookMetadataExperimental(key: string, value: any): Promise<void>
deleteNotebookMetadataExperimental(key: string): Promise<void>
```

The objects that you store should be TOML-serializable: stick to simple JS types like String, Number, Array, Object.

Return type `Promise<void>` means that a promise is returned, that resolves when the data is stored correctly.

### Cell metadata


```ts
getCellMetadataExperimental(key: string, { cell_id: string? }): any
setCellMetadataExperimental(key: string, value: any, { cell_id: string? }): Promise<void>
deleteCellMetadataExperimental(key: string, { cell_id: string? }): Promise<void>
```

Providing the `cell_id` is only necessary when storing data on another cell than that where your `<script>` is executing.

Return type `Promise<void>` means that a promise is returned, that resolves when the data is stored correctly.
"""

# ╔═╡ d70a3a02-ef3a-450f-bf5a-4a0d7f6262e2
TableOfContents()

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
HypertextLiteral = "~0.9.3"
PlutoUI = "~0.7.34"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "8b72179abc660bfab5e28472e019392b97d0985c"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.4"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "ab55ee1510ad2af0ff674dbcced5e94921f867a9"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.59"

[[PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─97914842-76d2-11eb-0c48-a7eedca870fb
# ╟─88120468-a43d-4d58-ac04-9cc7c86ca179
# ╠═ea4b2da1-4c83-4a1f-8fc3-c71a120e58e1
# ╟─321b7f2e-542a-43af-bd4d-1264f5438322
# ╟─08bdeaff-5bfb-49ab-b4cc-3a3446c63edc
# ╠═571613a1-6b4b-496d-9a68-aac3f6a83a4b
# ╟─abd91e68-121b-46fc-830f-238f38329f0e
# ╟─9b6b5da9-8372-4ebf-9c66-ae9fcfc45d47
# ╟─f18b98f7-1e0f-4273-896f-8a667d15605b
# ╟─ce78a32b-cde5-411a-ad8e-c52dc6228d00
# ╟─75e1a973-7ef0-4ac5-b3e2-5edb63577927
# ╠═dd589798-81d7-412d-b689-80c75eba3cd8
# ╠═4a446964-104d-425b-8afe-cfd07474a7a2
# ╟─320c1fa1-44c5-4832-9d17-87a2cfd83d9d
# ╟─ada382a5-5375-4c96-95f7-9a8721567fc4
# ╠═7510b8bc-ea4d-43f9-be7c-e9529fe418a9
# ╠═ba7b29da-b706-40a1-916b-df9667ba7726
# ╟─eb7525c6-5593-4412-9535-39afab419891
# ╠═0dae6755-0e76-429a-8e12-15887e8f03c1
# ╠═93dbb350-ef2c-4662-af1f-2b522407c51b
# ╟─00fe3318-d05d-4f00-afe6-3191e2b70132
# ╟─d83d57e2-4787-4b8d-8669-64ed73d79e73
# ╟─077c95cf-2a1b-459f-830e-c29c11a2c5cc
# ╟─80511436-e41f-4913-8a30-d9e113cfaf71
# ╟─bd578b8a-f2dc-4299-8022-770f3323de4a
# ╟─71b78f2b-c171-4807-a886-d2dfa5f203a9
# ╟─311e95cf-ac6b-414b-873e-e5eb69d395e6
# ╠═1a46b59a-5fa0-486d-9192-b44861bba930
# ╠═3fe7d1cd-edd7-48f6-987a-577b9e6125c3
# ╟─3afa78e2-d01e-4fc0-ae1d-882fe6ca94f7
# ╟─eda0947b-16d7-459f-89ef-9a8febf70354
# ╠═0a051a07-4e5f-461d-a588-16b0cc3a3974
# ╟─226cd4d6-e719-4e4a-b403-5024a7f83975
# ╟─367701a7-82e6-4864-8975-9323060872d4
# ╟─48c39379-361d-4adb-b65a-1e2cc07f11f5
# ╟─134f6baa-8f92-4ade-93aa-8dea42092597
# ╠═392dd5c9-23f8-4b40-a6aa-6e3e9ba76a83
# ╠═0534ccd3-858f-4247-9dbc-26bea18e437f
# ╠═48d47baa-edab-49e0-8cc3-b1ab04a70027
# ╟─b79cb583-6ebb-411d-845e-0e68c1fd5e27
# ╟─27231bd2-deb3-4c37-849e-b07782439dea
# ╠═6ce86c19-6f05-4679-b6dc-bd5a9945f316
# ╟─f611bf4e-8d7a-415a-8633-e5b84afe08e6
# ╟─aaa3e85e-9b09-45ae-9c47-c14979cde65d
# ╠═e32d8a7f-91e3-4d85-b1ca-b6afef83f433
# ╟─9d0e67d1-f6ed-4f1d-a181-28a6e9d7016a
# ╟─a33c7d7a-8071-448e-abd6-4e38b5444a3a
# ╠═91f3dab8-5521-44a0-9890-8d988a994076
# ╠═dcaae662-4a4f-4dd3-8763-89ea9eab7d43
# ╟─d4bdc4fe-2af8-402f-950f-2afaf77c62de
# ╟─e77cfefc-429d-49db-8135-f4604f6a9f0b
# ╠═2d5689f5-1d63-4b8b-a103-da35933ad26e
# ╠═6dd221d1-7fd8-446e-aced-950512ea34bc
# ╠═0a9d6e2d-3a41-4cd5-9a4e-a9b76ed89fa9
# ╟─0962d456-1a76-4b0d-85ff-c9e7dc66621d
# ╠═bf9b36e8-14c5-477b-a54b-35ba8e415c77
# ╟─e910982c-8508-4729-a75d-8b5b847918b6
# ╟─781adedc-2da7-4394-b323-e508d614afae
# ╟─de789ad1-8197-48ae-81b2-a21ec2340ae0
# ╠═85483b28-341e-4ed6-bb1e-66c33613725e
# ╠═9e37c18c-3ebb-443a-9663-bb4064391d6e
# ╟─05d28aa2-9622-4e62-ab39-ca4c7dde6eb4
# ╠═3266f9e6-42ad-4103-8db3-b87d2c315290
# ╟─ddbe51f7-538a-4eff-b23f-da8d4deebd3c
# ╟─fa3a860c-0215-4b55-aec0-a151bcbe1a06
# ╟─d8e77231-6982-4c31-8ace-22fefc6f1e17
# ╟─b99c7ea3-b364-4588-98a7-0ab6d7f99b64
# ╠═d70a3a02-ef3a-450f-bf5a-4a0d7f6262e2
# ╠═6619d10d-d1e0-493d-b854-3deff1cf001f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
