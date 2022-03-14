import Pluto

s = Pluto.ServerSession()

# s.options.server.disable_writing_notebook_files = true
s.options.server.launch_browser = false

nb = Pluto.SessionActions.open(s, joinpath(@__DIR__, "PlutoPages.jl"); run_async=false)

write("generation_report.html", Pluto.generate_html(generate_html))

for c in nb.cells
    if c.errored == "code"
        println("Cell errored: ", c.cell_id)
        println()
        show(io, MIME"text/plain"(), c.output.body)
        println()
        println()
    end
end

Pluto.SessionActions.shutdown(s, nb)

if any(c -> c.errored, nb.cells)
    exit(1)
end
