cd(@__DIR__)

@assert VERSION >= v"1.10.0"

import Pkg
Pkg.activate("./pluto-deployment-environment")
Pkg.instantiate()
import PlutoPages

PlutoPages.develop(@__DIR__)
