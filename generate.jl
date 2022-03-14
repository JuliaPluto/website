import Pluto

s = Pluto.ServerSession()

# s.options.server.disable_writing_notebook_files = true
s.options.server.launch_browser = false

nb = Pluto.SessionActions.open(s, joinpath(@__DIR__, "PlutoPages.jl"); run_async=false)
Pluto.SessionActions.shutdown(s, nb)
