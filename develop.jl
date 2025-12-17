cd(@__DIR__)

@assert v"1.10.0" <= VERSION < v"1.11.4"

import Pkg
Pkg.activate("./pluto-deployment-environment")
Pkg.instantiate()
import PlutoPages

PlutoPages.develop(@__DIR__)
