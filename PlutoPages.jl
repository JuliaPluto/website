### A Pluto.jl notebook ###
# v0.18.2

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

# ╔═╡ b8024c95-6a63-4409-9c75-9bad6b301a92
begin
	import Pkg
	# Pkg.activate()
	
	import PlutoSliderServer
	import Pluto
	using MarkdownLiteral
end

# ╔═╡ d4cfce05-bae4-49ae-b26d-ce27171a3853
using PlutoUI

# ╔═╡ ce840b47-8406-48e6-abfb-1b00daab28dd
using HypertextLiteral

# ╔═╡ 7c53c1e3-6ccf-4804-8bc3-09126036608e
using PlutoHooks

# ╔═╡ 725cb996-68ac-4736-95ee-0a9754867bf3
using BetterFileWatching

# ╔═╡ 9d996c55-0e37-4ae9-a6a2-8c8761e8c6db
using PlutoLinks

# ╔═╡ c5a0b072-7f49-4c0c-855e-773cfc03d308
TableOfContents()

# ╔═╡ 6c8e76ea-d648-449a-89de-cb6632cdd6b9
md"""
# Template systems

A **template** system is will turn an input file (markdown, julia, nunjucks, etc.) into an (HTML) output. This architecture is based on [eleventy](https://www.11ty.dev/docs/).

To register a template handler for a file extension, you add a method to `template_handler`, e.g.

```julia
function template_handler(
	::Val{Symbol(".md")}, 
	input::TemplateInput
)::TemplateOutput

	s = String(input.contents)
	result = run_markdown(s)
	
	return TemplateOutput(;
		contents=result.contents,
		front_matter=result.front_matter,
	)
end
```

See `TemplateInput` and `TemplateOutput` for more info!
"""

# ╔═╡ a166e8f3-542e-4068-a076-3f5fd4daa61c
Base.@kwdef struct TemplateInput
	contents::Vector{UInt8}
	relative_path::String
	absolute_path::String
	frontmatter::Dict{String,Any}=Dict{String,Any}()
end

# ╔═╡ 6288f145-444b-41cb-b9e3-8f273f9517fb
begin
	Base.@kwdef struct TemplateOutput
		contents::Union{Vector{UInt8},String,Nothing}
		file_extension::String="html"
		frontmatter::Dict{String,Any}=Dict{String,Any}()
	end
	TemplateOutput(t::TemplateOutput; kwargs...) = TemplateOutput(;
		contents=t.contents,
		file_extension=t.file_extension,
		frontmatter=t.frontmatter,
		kwargs...
	)
end

# ╔═╡ ff55f7eb-a23d-4ca7-b428-ab05dcb8f090
# fallback method
function template_handler(::Any, input::TemplateInput)::TemplateOutput
	TemplateOutput(;
		contents=nothing,
		file_extension="nothing",
	)
end

# ╔═╡ 4a2dc5a4-0bf2-4678-b984-4ecb7b397d72
md"""
## `.jlhtml`: HypertextLiteral.jl
"""

# ╔═╡ b3ce7742-fb47-4c17-bac2-e6a7710eb1a1
md"""
## `.md` and `.jlmd`: MarkdownLiteral.jl
"""

# ╔═╡ 6faafede-561d-462c-8c05-e8d5a5943e13
s3 = """
@__DIR__
"""

# ╔═╡ 65c9481b-f3b0-41cb-9ec1-758751811b51
Base.include_string(Module(), s3, "/Users/fons/Documents/asdf/a")

# ╔═╡ 90f0c676-b33f-441c-8ea6-d59c44a11547
s_example = raw"""
---
title: "Hello worfdsld!"
description: "A longer description of the same thing"
authors: ["Fonsi"]
---

### Hello there!

My name is <em>fons</em>

<ul>
$(map(1:num) do i
	@mdx ""\"<li>That's $i cool</li>""\"
end)
</ul>

Want to embed some cool HTML? *Easy!* Just type the HTML! **or markdown**, it's all the same!! 👀

```math
\\sqrt{\\frac{1}{2}}
````

$(begin
a = 1
b = 2
export b
end)

"""

# ╔═╡ 5381e8b3-d4f9-4e58-8da3-f1ee0a9b7a6d
@bind s TextField((70,20); default=s_example)

# ╔═╡ 08b42df7-9120-4b42-80ee-8e438752b50c
# s_result.exported

# ╔═╡ f4a4b741-8028-4626-9187-0b6a52f062b6
import CommonMark

# ╔═╡ 535efb29-73bd-4e65-8bbc-18b72ae8fe1f
import YAML

# ╔═╡ adb1ddac-d992-49ca-820f-e1ed8ca33bf8
md"""
## `.jl`: PlutoSliderServer.jl
"""

# ╔═╡ cd4e479c-deb7-4a44-9eb0-c3819b5c4067
find(f::Function, xs) = for x in xs
	if f(x)
		return x
	end
end

# ╔═╡ 5649b0ab-5d1e-4809-ae22-a8e08f4c0e86
import URIs

# ╔═╡ 644552c6-4e32-4caf-90ef-bee259977094
import Logging

# ╔═╡ e7505301-9fb8-4a93-bde4-16ed3b9d6d20
md"""
### Front matter

Not so easy to get the front matter out...
"""

# ╔═╡ 2e527d04-e4e7-4dc8-87e6-8b3dd3c7688a
const FrontMatter = Dict{String,Any}

# ╔═╡ 692c1e0b-07e1-41b3-abcd-2156bda65b41
"""
Turn a MarkdownLiteral.jl string into HTML contents and front matter.
"""
function run_mdx(s::String; 
		data::Dict{String,<:Any}=Dict{String,Any}(),
		cm::Bool=true,
		filename::AbstractString="unknown",
	)
	# take a look at https://github.com/JuliaPluto/MarkdownLiteral.jl if you want to use it this too!

	# Just HTL, CommonMark parsing comes in a later step
	code = "@htl(\"\"\"$(s)\"\"\")"

	m = Module()
	Core.eval(m, :(var"@mdx" = var"@md" = $(MarkdownLiteral.var"@mdx")))
	Core.eval(m, :(var"@htl" = $(HypertextLiteral.var"@htl")))
	# Core.eval(m, :(setpage = $(setpage)))
	Core.eval(m, :(using Markdown, InteractiveUtils))
	for (k,v) in data
		Core.eval(m, :($(Symbol(k)) = $(v)))
	end

	result = Base.include_string(m, code, filename)

	to_render, frontmatter = if !cm
		result, FrontMatter()
	else
	
		# we want to apply our own CM parser, so we do the MarkdownLiteral.jl trick manually:
		result_str = repr(MIME"text/html"(), result)
		cm_parser = CommonMark.Parser()
	    CommonMark.enable!(cm_parser, [
	        CommonMark.AdmonitionRule(),
	        CommonMark.AttributeRule(),
	        CommonMark.AutoIdentifierRule(),
	        CommonMark.CitationRule(),
	        CommonMark.FootnoteRule(),
	        CommonMark.MathRule(),
	        CommonMark.RawContentRule(),
	        CommonMark.TableRule(),
	        CommonMark.TypographyRule(),
			# TODO: allow Julia in front matter by using Meta.parse as the TOML parser?
			# but you probably want to be able to use those variables inside the document, so they have to be evaluated *before* running the expr.
	        CommonMark.FrontMatterRule(yaml=YAML.load),
	    ])
	
		ast = cm_parser(result_str)

		ast, CommonMark.frontmatter(ast)
	end
	
	contents = repr(MIME"text/html"(), to_render)

	# TODO: might be nice:
	# exported = filter(names(m; all=false, imported=false)) do s
	# 	s_str = string(s)
	# 	!(startswith(s_str, "#") || startswith(s_str, "anonymous"))
	# end
	
	(; 
		contents, 
		frontmatter, 
		# exported,
	)
end

# ╔═╡ 7717e24f-62ee-4852-9dec-d09b734d0693
s_result = run_mdx(s; data=Dict("num" => 3));

# ╔═╡ 9f945292-ff9e-4f29-93ea-69b10fc4428d
s_result.contents |> HTML

# ╔═╡ 83366d96-4cd3-4def-a0da-16a22b40124f
s_result.frontmatter

# ╔═╡ 00fe8ec0-e7c9-43d6-9d06-960384ca465f
function get_frontmatter_from_pluto(abs_path::String)

	# this will load the notebook to analyse, it won't run it
	nb = Pluto.load_notebook_nobackup(abs_path)
	top = Pluto.updated_topology(nb.topology, nb, nb.cells)

	cs = Pluto.where_assigned(top, Set([:frontmatter]))
	if isempty(cs)
		FrontMatter()
	else
		try
			c = only(cs)
			m = Module()
			Core.eval(m, Meta.parse(c.code))
			result = Core.eval(m, :frontmatter)
			if result isa FrontMatter
				result
			else
				FrontMatter(String(k)=>v for (k,v) in pairs(result))
			end
		catch e
			@error "Error reading frontmatter. Make sure that `frontmatter` is a `NamedTuple` or a `Dict{String,Any}`, and that it does not use global variables." abs_path exception=(e,catch_backtrace())
			FrontMatter()
		end
	end
end

# ╔═╡ c5d9f25b-b14a-4031-9853-ce04ac120e75
# test_file_str = read(joinpath(dir, "hello", "world.jl"), String)

# ╔═╡ 2285cf2e-09e9-4b05-bbd9-5f926c9712bd
# let
# 	file = tempname()
# 	write(file, test_file_str)
# 	get_frontmatter_from_pluto(file)
# end

# ╔═╡ 94bb6730-a4ad-42d2-aa58-41b70a15cd0e
md"""
## `.css`, `.html`, `.js`, `.png`, etc: passthrough

"""

# ╔═╡ e15cf987-3615-4e96-8ccd-04cad3bcd48e
function template_handler(::Union{
		Val{Symbol(".css")},
		Val{Symbol(".html")},
		Val{Symbol(".js")},
		Val{Symbol(".png")},
		Val{Symbol(".svg")},
		Val{Symbol(".gif")},
	}, input::TemplateInput)::TemplateOutput

	TemplateOutput(;
		contents=input.contents,
		file_extension=lstrip(isequal('.'), splitext(input.relative_path)[2]),
	)
end

# ╔═╡ 940f3995-1739-4b30-b8cf-c27a671043e5
md"""
## Generated assets
"""

# ╔═╡ 5e91e7dc-82b6-486a-b745-34f97b6fb20c
struct RegisteredAsset
	url::String
	relative_path::String
	absolute_path::String
end

# ╔═╡ 8f6393a4-e945-4f06-90f6-0a71f874c8e9
import SHA

# ╔═╡ 4fcdd524-86a8-4033-bc7c-4a7c04224eeb
import Unicode

# ╔═╡ 070c710d-3746-4706-bd03-b5b00a576007
function myhash(data)
	s = SHA.sha256(data)
	string(reinterpret(UInt32, s)[1]; base=16, pad=8)
end

# ╔═╡ a5c22f80-58c7-4c63-95b8-ecb30bc896d0
myhash(rand(UInt8, 50))

# ╔═╡ 750782a1-3aeb-4816-8f6a-ec31055373c1
legalize(filename) = replace(
	Unicode.normalize(
		replace(filename, " " => "_");
		stripmark=true)
	, r"[^\w-]" => "")

# ╔═╡ f6b89b8c-3750-4dd2-940e-579be953c1c2
legalize(" ëasdfa sd23__--f//asd f?\$%^&*() .")

# ╔═╡ 29a81ad7-3803-4b7a-98ca-6e5b1077e1c7
md"""
# Input folder
"""

# ╔═╡ c52c9786-a25f-11ec-1fdc-9b13922d7ccb
const dir = joinpath(@__DIR__, "src")

# ╔═╡ cf27b3d3-1689-4b3a-a8fe-3ad639eb2f82
md"""
## File watching
"""

# ╔═╡ 485b7956-0774-4b25-a897-3d9232ef8590
const this_file = split(@__FILE__, "#==#")[1]

# ╔═╡ d38dc2aa-d5ba-4cf7-9f9e-c4e4611a57ac
function ignore(abs_path)
	p = relpath(abs_path, dir)

	any(startswith("_"), splitpath(p)) || # (_cache, _site, _includes)
		startswith(p, ".git") ||
		abs_path == this_file
end

# ╔═╡ 8da0c249-6094-49ab-9e59-d6e356818651
dir_changed_time = let
	valx, set_valx = @use_state(time())

	@info "asdf 1"
	
	@use_task([dir]) do
		BetterFileWatching.watch_folder(dir) do e
			# @warn "what is happening" e
			is_caused_by_me = all(ignore, e.paths)

			if !is_caused_by_me
				@info "Reloading!" e
				set_valx(time())
			end
		end
	end

	valx
end

# ╔═╡ 7d9cb939-da6b-4961-9584-a905ad453b5d
allfiles = filter(PlutoSliderServer.list_files_recursive(dir)) do p
	# reference to retrigger when files change
	dir_changed_time
	
	!ignore(joinpath(dir, p))
end

# ╔═╡ d314ab46-b866-44c6-bfca-9a413bc06514
md"""
# Output folder generation
"""

# ╔═╡ e01ebbab-dc9a-4aaf-ae16-200d171fcbd9
const output_dir = mkpath(joinpath(@__DIR__, "_site"))

# ╔═╡ 37b2cecc-e4c7-4b80-b7d9-71c68f3c0339
try
	run(`open $(output_dir)`)
catch
end

# ╔═╡ 7a95681a-df77-408f-919a-2bee5afd7777
"""
This directory can be used to store cache files that are persisted between builds. Currently used as PlutoSliderServer.jl cache.
"""
const cache_dir = mkpath(joinpath(@__DIR__, "_cache"))

# ╔═╡ 4e88cf07-8d85-4327-b310-6c71ba951bba
md"""
## Running the templates

(This can take a while if you are running this for the first time with an empty cache.)
"""

# ╔═╡ aaad71bd-5425-4783-952c-82e4d4fa7bb8
md"""
## URL generation
"""

# ╔═╡ 76c2ac85-2e89-4396-a498-a4ceb1cc80bd
Base.@kwdef struct Page
	url::String
	input::TemplateInput
	output::TemplateOutput
end

# ╔═╡ 1c269e16-65c7-47ae-aeab-001f1b205e14
ishtml(output::TemplateOutput) = output.file_extension == "html"

# ╔═╡ 898eb093-444c-45cf-88d7-3dbe9708ae31
function final_url(input::TemplateInput, output::TemplateOutput)::String
	if ishtml(output)
		# Examples:
		#   a/b.jl   	->    a/b/index.html
		#   a/index.jl  ->    a/index.html
		
		in_dir, in_filename = splitdir(input.relative_path)
		in_name, in_ext = splitext(in_filename)

		if in_name == "index"
			joinpath(in_dir, "index.html")
		else
			joinpath(in_dir, in_name, "index.html")
		end
	else
		ext = lstrip(isequal('.'), output.file_extension)
		join((splitext(input.relative_path)[1], ".", ext))
	end
end

# ╔═╡ 76193b12-842c-4b82-a23e-fb7403274234
md"""
## Collections from `tags`
"""

# ╔═╡ 4f563136-fc7b-4322-92ba-78c0183c40cc
struct Collection
	tag::String
	pages::Vector{Page}
end

# ╔═╡ 41ab51f9-0b33-4548-b08a-ad1ef7d38f1b
function sort_by(p::Page)
	bn = basename(p.input.relative_path)
	
	return (
		get(p.output.frontmatter, "order", Inf),
		splitext(bn)[1] != "index",
		# TODO: sort based on dates if we ever need that
		bn,
	)
end

# ╔═╡ b0006e61-b037-41ed-a3e4-9962d15584c4
md"""
## Layouts
"""

# ╔═╡ f2fbcc70-a714-4eda-8786-7ee5692e3268
with_doctype(p::Page) = Page(p.url, p.input, with_doctype(p.output))

# ╔═╡ 57fd383b-d791-4170-a353-f839356f9d7a
with_doctype(output::TemplateOutput) = if ishtml(output) && output.contents !== nothing
	TemplateOutput(output;
		contents="<!DOCTYPE html>" * String(output.contents)
	)
else
	output
end

# ╔═╡ 1a303aa4-bed5-4d9b-855c-23355f4a88fe
md"""
## Writing to the output directory
"""

# ╔═╡ eef54261-767a-4ce4-b549-0b1828379f7e
StringSafe(x) = String(x)

# ╔═╡ cda8689d-9ae5-42c4-8e7e-715cf44c33bb
StringSafe(x::Vector{UInt8}) = String(copy(x))

# ╔═╡ 995c6810-8df2-483d-a87a-2277af0d43bd
function template_handler(
	::Union{Val{Symbol(".jlhtml")}}, 
	input::TemplateInput)::TemplateOutput
	s = StringSafe(input.contents)
	result = run_mdx(s; 
		data=input.frontmatter, 
		cm=false,
		filename=input.absolute_path,
	)
	
	return TemplateOutput(;
		contents=result.contents,
		frontmatter=result.frontmatter,
	)
end

# ╔═╡ 7e86cfc7-5439-4c7a-9c3b-381c776d8371
function template_handler(
	::Union{
		Val{Symbol(".jlmd")},
		Val{Symbol(".md")}
	}, 
	input::TemplateInput)::TemplateOutput
	s = StringSafe(input.contents)
	result = run_mdx(s; 
		data=input.frontmatter,
		filename=input.absolute_path,
	)
	
	return TemplateOutput(;
		contents=result.contents,
		frontmatter=result.frontmatter,
	)
end

# ╔═╡ 4013400c-acb4-40fa-a826-fd0cbae09e7e
reprhtml(x) = repr(MIME"text/html"(), x)

# ╔═╡ 5b325b50-8984-44c6-8677-3c6bc5c2b0b1
"A magic token that will turn into a relative URL pointing to the website root when used in output."
const root_url = "++magic#root#url~$(string(rand(UInt128),base=62))++"

# ╔═╡ 0d2b7382-2ddf-48c3-90c8-bc22de454c97
"""
```julia
register_asset(contents, original_name::String)
```

Place an asset in the `/generated_assets/` subfolder of the output directory and return a [`RegisteredAsset`](@ref) referencing it for later use. (The original filename will be sanitized, and a content hash will be appended.)

To be used inside `process_file` methods which need to generate additional files. You can use `registered_asset.url` to get a location-independent href to the result.
"""
function register_asset(contents, original_name::String)
	h = myhash(contents)
	n, e = splitext(basename(original_name))
	
	
	mkpath(joinpath(output_dir, "generated_assets"))
	newpath = joinpath(output_dir, "generated_assets", "$(legalize(n))_$(h)$(e)")
	write(newpath, contents)
	rel = relpath(newpath, output_dir)
	return RegisteredAsset(joinpath(root_url, rel), rel, newpath)
end

# ╔═╡ e2510a44-df48-4c05-9453-8822deadce24
function template_handler(
	::Val{Symbol(".jl")}, 
	input::TemplateInput
)::TemplateOutput

	
	if Pluto.is_pluto_notebook(input.absolute_path)
		temp_out = mktempdir()
		Logging.with_logger(Logging.NullLogger()) do
			PlutoSliderServer.export_notebook(
				input.absolute_path;
				Export_create_index=false,
				Export_cache_dir=cache_dir,
				Export_baked_state=false,
				Export_baked_notebookfile=false,
				Export_output_dir=temp_out,
			)
		end
		d = readdir(temp_out)

		statefile = find(contains("state") ∘ last ∘ splitext, d)
		notebookfile = find(!contains("html") ∘ last ∘ splitext, d)

		reg_s = register_asset(read(joinpath(temp_out, statefile)), statefile)
		reg_n = register_asset(read(joinpath(temp_out, notebookfile)), notebookfile)

		# TODO these relative paths can't be right...
		h = @htl """
		<pluto-editor statefile=$(reg_s.url) notebookfile=$(reg_n.url) disable_ui>
		"""

		frontmatter = get_frontmatter_from_pluto(input.absolute_path)
		
		return TemplateOutput(;
			contents = repr(MIME"text/html"(), h),
			frontmatter,
		)
	else
		
		s = String(input.contents)
	
		h = @htl """
		<pre class="language-julia"><code>$(s)</code></pre>
		"""
		
		return TemplateOutput(;
			contents = repr(MIME"text/html"(), h),
		)
	end
end

# ╔═╡ 079a6399-50eb-4dee-a36d-b3dcb81c8456
template_results = let
	# delete any old files
	for f in readdir(output_dir)
		rm(joinpath(output_dir, f); recursive=true)
	end

	# let's go! running all the template handlers
	map(allfiles) do f
		absolute_path = joinpath(dir, f)
		
		input = TemplateInput(;
			contents=read(absolute_path),
			absolute_path,
			relative_path=f,
		)
		
		output = template_handler(Val(Symbol(splitext(f)[2])), input)

		input, output
	end
end

# ╔═╡ 318dc59e-15f6-4b25-bcf5-1ab6b0d87af7
pages = Page[
	Page(
		 final_url(input, output), input, output,
	)
	for (input, output) in template_results if output.contents !== nothing
]

# ╔═╡ f93da14a-e4c8-4c28-ab01-4a5ba1a3cf47
collections = let
	result = Dict{String,Set{Page}}()

	for page in pages
		for t in get(page.output.frontmatter, "tags", String[])
			old = get!(result, t, Set{Page}())
			push!(old, page)
		end
	end


	Dict{String,Collection}(
		k => Collection(k, sort(collect(v); by=sort_by)) for (k,v) in result
	)
end

# ╔═╡ c2ee20be-16f5-47a8-851a-67a361bb0316
"""
```julia
process_layouts(page::Page)::Page
```

Recursively apply the layout specified in the frontmatter, returning a new `Page` with updated `output`.
"""
function process_layouts(page::Page)::Page
	output = page.output
	
	if haskey(output.frontmatter, "layout")
		@assert output.file_extension == "html" "Layout is not (yet) supported on non-HTML outputs."
		
		layoutname = output.frontmatter["layout"]
		@assert layoutname isa String
		layout_file = joinpath(dir, "_includes", layoutname)
		@assert isfile(layout_file) "$layout_file is not a valid layout path"


		content = if ishtml(output)
			HTML(StringSafe(output.contents))
		else
			output.contents
		end
		
		input = TemplateInput(;
			contents=read(layout_file),
			absolute_path=layout_file,
			relative_path=relpath(layout_file, dir),
			frontmatter=merge(output.frontmatter, 
				FrontMatter(
					"content" => content,
					"page" => page,
					"collections" => collections,
					"root_url" => root_url,
				),
			)
		)

		result = template_handler(Val(Symbol(splitext(layout_file)[2])), input)
		
		@assert result.file_extension == "html" "Non-HTML output from Layouts is not (yet) supported."


		
		old_frontmatter = copy(output.frontmatter)
		delete!(old_frontmatter, "layout")
		new_frontmatter = merge(old_frontmatter, result.frontmatter)

		process_layouts(Page(
			page.url,
			page.input,
			TemplateOutput(result; frontmatter = new_frontmatter),
		))
	else
		page
	end
end

# ╔═╡ 06edb2d7-325f-4f80-8c55-dc01c7783054
rendered_results = map(with_doctype ∘ process_layouts, pages)

# ╔═╡ 9845db00-149c-45be-9e4f-55d1157afc87
process_results = map(rendered_results) do page
	input = page.input
	output = page.output
	
	if output !== nothing && output.contents !== nothing
		
		# TODO: use front matter for permalink

		output_path2 = joinpath(output_dir, page.url)
		mkpath(output_path2 |> dirname)
		# Our magic root url:
		# in Julia, you can safely call `String` and `replace` on arbitrary, non-utf8 data :)
		write(output_path2, 
			replace(StringSafe(output.contents), root_url => relpath(output_dir, output_path2 |> dirname))
		)
	end
end

# ╔═╡ d17c96fb-8459-4527-a139-05fdf74cdc39
let
	process_results
	PlutoSliderServer.list_files_recursive(output_dir)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BetterFileWatching = "c9fd44ac-77b5-486c-9482-9798bd063cc6"
CommonMark = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
Logging = "56ddb016-857b-54e1-b83d-db4d58db5568"
MarkdownLiteral = "736d6165-7244-6769-4267-6b50796e6954"
Pkg = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
Pluto = "c3e4b0f8-55cb-11ea-2926-15256bba5781"
PlutoHooks = "0ff47ea0-7a50-410d-8455-4348d5de0774"
PlutoLinks = "0ff47ea0-7a50-410d-8455-4348d5de0420"
PlutoSliderServer = "2fc8631c-6f24-4c5b-bca7-cbb509c42db4"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
SHA = "ea8e919c-243c-51af-8825-aaa63cd721ce"
URIs = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
Unicode = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
YAML = "ddb6d928-2868-570f-bddf-ab3f9cf99eb6"

[compat]
BetterFileWatching = "~0.1.5"
CommonMark = "~0.8.6"
HypertextLiteral = "~0.9.3"
MarkdownLiteral = "~0.1.1"
Pluto = "~0.18.2"
PlutoHooks = "~0.0.5"
PlutoLinks = "~0.1.5"
PlutoSliderServer = "~0.3.8"
PlutoUI = "~0.7.37"
URIs = "~1.3.0"
YAML = "~0.4.7"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.0"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.AbstractTrees]]
git-tree-sha1 = "03e0550477d86222521d254b741d470ba17ea0b5"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.3.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BetterFileWatching]]
deps = ["Deno_jll", "JSON"]
git-tree-sha1 = "0d7ee0a1acad90d544fa87cc3d6f463e99abb77a"
uuid = "c9fd44ac-77b5-486c-9482-9798bd063cc6"
version = "0.1.5"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "9fb640864691a0936f94f89150711c36072b0e8f"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.0.8"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.CommonMark]]
deps = ["Crayons", "JSON", "URIs"]
git-tree-sha1 = "4cd7063c9bdebdbd55ede1af70f3c2f48fab4215"
uuid = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
version = "0.8.6"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Configurations]]
deps = ["ExproniconLite", "OrderedCollections", "TOML"]
git-tree-sha1 = "79e812c535bb9780ba00f3acba526bde5652eb13"
uuid = "5218b696-f38b-4ac9-8b61-a12ec717816d"
version = "0.16.6"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "cc70b17275652eb47bc9e5f81635981f13cea5c8"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.9.0"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Deno_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "244309ef7003f30c7a5fe571f6b860c6b032b691"
uuid = "04572ae6-984a-583e-9378-9577a1c2574d"
version = "1.16.3+0"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ae13fcbc7ab8f16b0856729b050ef0c446aa3492"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.4+0"

[[deps.ExproniconLite]]
git-tree-sha1 = "8b08cc88844e4d01db5a2405a08e9178e19e479e"
uuid = "55351af7-c7e9-48d6-89ff-24e801d99491"
version = "0.6.13"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.FromFile]]
deps = ["Requires"]
git-tree-sha1 = "625b50a8f5ae8520be86f191420bc8b970b24907"
uuid = "ff7dd447-1dcb-4ce3-b8ac-22a812192de7"
version = "0.1.3"

[[deps.FuzzyCompletions]]
deps = ["REPL"]
git-tree-sha1 = "efd6c064e15e92fcce436977c825d2117bf8ce76"
uuid = "fb4132e2-a121-4a70-b8a1-d5b831dcdcc2"
version = "0.5.0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Git]]
deps = ["Git_jll"]
git-tree-sha1 = "d7bffc3fe097e9589145493c08c41297b457e5d0"
uuid = "d7ba0133-e1db-5d97-8f8c-041e4b3a1eb2"
version = "1.2.1"

[[deps.GitHubActions]]
deps = ["JSON", "Logging"]
git-tree-sha1 = "56e01ec63d13e1cf015d9ff586156eae3cc7cd6f"
uuid = "6b79fd1a-b13a-48ab-b6b0-aaee1fee41df"
version = "0.1.4"

[[deps.Git_jll]]
deps = ["Artifacts", "Expat_jll", "Gettext_jll", "JLLWrappers", "LibCURL_jll", "Libdl", "Libiconv_jll", "OpenSSL_jll", "PCRE2_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "6e93d42b97978709e9c941fa43d0f01701f0d290"
uuid = "f8c6e375-362e-5223-8a59-34ff63f689eb"
version = "2.34.1+0"

[[deps.HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "0fa77022fe4b511826b39c894c90daf5fce3334a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.17"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "d4294ea0357f0496844d09a667109cf5b3b3eadb"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.10"

[[deps.LeftChildRightSiblingTrees]]
deps = ["AbstractTrees"]
git-tree-sha1 = "b864cb409e8e445688bc478ef87c0afe4f6d1f8d"
uuid = "1d6d02ad-be62-4b6b-8a6d-2f90e265016e"
version = "0.1.3"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoweredCodeUtils]]
deps = ["JuliaInterpreter"]
git-tree-sha1 = "6b0440822974cab904c8b14d79743565140567f6"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "2.2.1"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MarkdownLiteral]]
deps = ["CommonMark", "HypertextLiteral"]
git-tree-sha1 = "0d3fa2dd374934b62ee16a4721fe68c418b92899"
uuid = "736d6165-7244-6769-4267-6b50796e6954"
version = "0.1.1"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.MsgPack]]
deps = ["Serialization"]
git-tree-sha1 = "a8cbf066b54d793b9a48c5daa5d586cf2b5bd43d"
uuid = "99f44e22-a591-53d1-9472-aa23ef4bd671"
version = "1.1.0"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "648107615c15d4e09f7eca16307bc821c1f718d8"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.13+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "85b5da0fa43588c75bb1ff986493443f821c70b7"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.Pluto]]
deps = ["Base64", "Configurations", "Dates", "Distributed", "FileWatching", "FuzzyCompletions", "HTTP", "InteractiveUtils", "Logging", "Markdown", "MsgPack", "Pkg", "REPL", "RelocatableFolders", "Sockets", "Tables", "UUIDs"]
git-tree-sha1 = "921a6c34f1aac583538c50232f3e05aa830d4f6a"
uuid = "c3e4b0f8-55cb-11ea-2926-15256bba5781"
version = "0.18.2"

[[deps.PlutoHooks]]
deps = ["InteractiveUtils", "Markdown", "UUIDs"]
git-tree-sha1 = "072cdf20c9b0507fdd977d7d246d90030609674b"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0774"
version = "0.0.5"

[[deps.PlutoLinks]]
deps = ["FileWatching", "InteractiveUtils", "Markdown", "PlutoHooks", "Revise", "UUIDs"]
git-tree-sha1 = "0e8bcc235ec8367a8e9648d48325ff00e4b0a545"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0420"
version = "0.1.5"

[[deps.PlutoSliderServer]]
deps = ["AbstractPlutoDingetjes", "Base64", "BetterFileWatching", "Configurations", "Distributed", "FromFile", "Git", "GitHubActions", "HTTP", "Logging", "Pkg", "Pluto", "SHA", "Sockets", "TOML", "TerminalLoggers", "UUIDs"]
git-tree-sha1 = "ed3844b31b1a4abed2389f5c6ca5f488dd13e67f"
repo-rev = "04a12d7"
repo-url = "https://github.com/JuliaPluto/PlutoSliderServer.jl.git"
uuid = "2fc8631c-6f24-4c5b-bca7-cbb509c42db4"
version = "0.3.9"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "bf0a1121af131d9974241ba53f601211e9303a9e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.37"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "d3538e7f8a790dc8903519090857ef8e1283eecd"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.5"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.ProgressLogging]]
deps = ["Logging", "SHA", "UUIDs"]
git-tree-sha1 = "80d919dee55b9c50e8d9e2da5eeafff3fe58b539"
uuid = "33c8b6b6-d38a-422a-b730-caa89a2f386c"
version = "0.1.4"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "307761d71804208c0c62abdbd0ea6822aa5bbefd"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "0.2.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Revise]]
deps = ["CodeTracking", "Distributed", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "Pkg", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "4d4239e93531ac3e7ca7e339f15978d0b5149d03"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.3.3"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "0b4b7f1393cff97c33891da2a0bf69c6ed241fda"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StringEncodings]]
deps = ["Libiconv_jll"]
git-tree-sha1 = "50ccd5ddb00d19392577902f0079267a72c5ab04"
uuid = "69024149-9ee7-55f6-a4c4-859efe599b68"
version = "0.3.5"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "5ce79ce186cc678bbb5c5681ca3379d1ddae11a1"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.7.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.TerminalLoggers]]
deps = ["LeftChildRightSiblingTrees", "Logging", "Markdown", "Printf", "ProgressLogging", "UUIDs"]
git-tree-sha1 = "62846a48a6cd70e63aa29944b8c4ef704360d72f"
uuid = "5d786b92-1e48-4d6f-9151-6b4477ca9bed"
version = "0.1.5"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "1acf5bdf07aa0907e0a37d3718bb88d4b687b74a"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.12+0"

[[deps.YAML]]
deps = ["Base64", "Dates", "Printf", "StringEncodings"]
git-tree-sha1 = "3c6e8b9f5cdaaa21340f841653942e1a6b6561e5"
uuid = "ddb6d928-2868-570f-bddf-ab3f9cf99eb6"
version = "0.4.7"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═b8024c95-6a63-4409-9c75-9bad6b301a92
# ╠═c5a0b072-7f49-4c0c-855e-773cfc03d308
# ╠═d4cfce05-bae4-49ae-b26d-ce27171a3853
# ╟─6c8e76ea-d648-449a-89de-cb6632cdd6b9
# ╠═a166e8f3-542e-4068-a076-3f5fd4daa61c
# ╠═6288f145-444b-41cb-b9e3-8f273f9517fb
# ╠═ff55f7eb-a23d-4ca7-b428-ab05dcb8f090
# ╟─4a2dc5a4-0bf2-4678-b984-4ecb7b397d72
# ╠═995c6810-8df2-483d-a87a-2277af0d43bd
# ╟─b3ce7742-fb47-4c17-bac2-e6a7710eb1a1
# ╠═7e86cfc7-5439-4c7a-9c3b-381c776d8371
# ╠═6faafede-561d-462c-8c05-e8d5a5943e13
# ╠═65c9481b-f3b0-41cb-9ec1-758751811b51
# ╠═90f0c676-b33f-441c-8ea6-d59c44a11547
# ╠═5381e8b3-d4f9-4e58-8da3-f1ee0a9b7a6d
# ╠═9f945292-ff9e-4f29-93ea-69b10fc4428d
# ╠═83366d96-4cd3-4def-a0da-16a22b40124f
# ╠═08b42df7-9120-4b42-80ee-8e438752b50c
# ╠═7717e24f-62ee-4852-9dec-d09b734d0693
# ╠═f4a4b741-8028-4626-9187-0b6a52f062b6
# ╠═535efb29-73bd-4e65-8bbc-18b72ae8fe1f
# ╠═692c1e0b-07e1-41b3-abcd-2156bda65b41
# ╟─adb1ddac-d992-49ca-820f-e1ed8ca33bf8
# ╠═e2510a44-df48-4c05-9453-8822deadce24
# ╟─cd4e479c-deb7-4a44-9eb0-c3819b5c4067
# ╠═5649b0ab-5d1e-4809-ae22-a8e08f4c0e86
# ╠═ce840b47-8406-48e6-abfb-1b00daab28dd
# ╠═644552c6-4e32-4caf-90ef-bee259977094
# ╟─e7505301-9fb8-4a93-bde4-16ed3b9d6d20
# ╠═2e527d04-e4e7-4dc8-87e6-8b3dd3c7688a
# ╟─00fe8ec0-e7c9-43d6-9d06-960384ca465f
# ╠═c5d9f25b-b14a-4031-9853-ce04ac120e75
# ╠═2285cf2e-09e9-4b05-bbd9-5f926c9712bd
# ╟─94bb6730-a4ad-42d2-aa58-41b70a15cd0e
# ╠═e15cf987-3615-4e96-8ccd-04cad3bcd48e
# ╟─940f3995-1739-4b30-b8cf-c27a671043e5
# ╟─0d2b7382-2ddf-48c3-90c8-bc22de454c97
# ╠═5e91e7dc-82b6-486a-b745-34f97b6fb20c
# ╠═8f6393a4-e945-4f06-90f6-0a71f874c8e9
# ╠═4fcdd524-86a8-4033-bc7c-4a7c04224eeb
# ╟─070c710d-3746-4706-bd03-b5b00a576007
# ╟─a5c22f80-58c7-4c63-95b8-ecb30bc896d0
# ╟─750782a1-3aeb-4816-8f6a-ec31055373c1
# ╟─f6b89b8c-3750-4dd2-940e-579be953c1c2
# ╟─29a81ad7-3803-4b7a-98ca-6e5b1077e1c7
# ╠═c52c9786-a25f-11ec-1fdc-9b13922d7ccb
# ╠═7c53c1e3-6ccf-4804-8bc3-09126036608e
# ╠═725cb996-68ac-4736-95ee-0a9754867bf3
# ╠═9d996c55-0e37-4ae9-a6a2-8c8761e8c6db
# ╟─cf27b3d3-1689-4b3a-a8fe-3ad639eb2f82
# ╠═7d9cb939-da6b-4961-9584-a905ad453b5d
# ╠═d38dc2aa-d5ba-4cf7-9f9e-c4e4611a57ac
# ╠═485b7956-0774-4b25-a897-3d9232ef8590
# ╠═8da0c249-6094-49ab-9e59-d6e356818651
# ╟─d314ab46-b866-44c6-bfca-9a413bc06514
# ╠═e01ebbab-dc9a-4aaf-ae16-200d171fcbd9
# ╠═37b2cecc-e4c7-4b80-b7d9-71c68f3c0339
# ╟─7a95681a-df77-408f-919a-2bee5afd7777
# ╟─4e88cf07-8d85-4327-b310-6c71ba951bba
# ╠═079a6399-50eb-4dee-a36d-b3dcb81c8456
# ╟─aaad71bd-5425-4783-952c-82e4d4fa7bb8
# ╠═76c2ac85-2e89-4396-a498-a4ceb1cc80bd
# ╠═898eb093-444c-45cf-88d7-3dbe9708ae31
# ╟─1c269e16-65c7-47ae-aeab-001f1b205e14
# ╟─318dc59e-15f6-4b25-bcf5-1ab6b0d87af7
# ╟─76193b12-842c-4b82-a23e-fb7403274234
# ╠═4f563136-fc7b-4322-92ba-78c0183c40cc
# ╠═f93da14a-e4c8-4c28-ab01-4a5ba1a3cf47
# ╠═41ab51f9-0b33-4548-b08a-ad1ef7d38f1b
# ╟─b0006e61-b037-41ed-a3e4-9962d15584c4
# ╠═c2ee20be-16f5-47a8-851a-67a361bb0316
# ╠═06edb2d7-325f-4f80-8c55-dc01c7783054
# ╟─f2fbcc70-a714-4eda-8786-7ee5692e3268
# ╟─57fd383b-d791-4170-a353-f839356f9d7a
# ╟─1a303aa4-bed5-4d9b-855c-23355f4a88fe
# ╠═9845db00-149c-45be-9e4f-55d1157afc87
# ╟─eef54261-767a-4ce4-b549-0b1828379f7e
# ╟─cda8689d-9ae5-42c4-8e7e-715cf44c33bb
# ╠═d17c96fb-8459-4527-a139-05fdf74cdc39
# ╟─4013400c-acb4-40fa-a826-fd0cbae09e7e
# ╟─5b325b50-8984-44c6-8677-3c6bc5c2b0b1
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
