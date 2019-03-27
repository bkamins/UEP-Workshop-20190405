# Bogumił Kamiński, 2019-03-25

# run as
# julia installation.jl

# Tested under Julia 1.1.0 (but any Julia 1.x version should work).
# In order to install Julia go to https://julialang.org/downloads/
# and follow the instructions given there.

# I give package versions under which the scripts were tested
# but installing their latest versions should be OK.

# In some environments installation of Cbc or PyPlot might fail
# due to clashes with external dependencies on OS level.
# Please contact me if you encounter such problems.

# "4. Logparser" example assumes that git is installed on the host machine
# and its executable is in search path.

using Pkg

Pkg.add("Distributions") # 0.17.0
Pkg.add("DataFrames") # 0.17.1
Pkg.add("ForwardDiff") # v0.10.3
Pkg.add("CSV") # 0.4.3
Pkg.add("GLM") # 1.1.1
Pkg.add("Flux") # 0.8.1
Pkg.add("HTTP") # 0.8.0
Pkg.add("JuMP") # 0.19.0
Pkg.add("Cbc") # 0.6.0
Pkg.add("PyPlot") # 2.8.0
