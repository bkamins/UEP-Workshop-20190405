# Bogumił Kamiński, 2019-03-25

using DataFrames

lines = readlines("sample_dataframes.log")

author = r"^Author: ([^<]*) <"
insc = r"^.+changed, ([0-9]+) insertion"
delc = r"^.+changed.*, ([0-9]+) deletion"
authordata = DataFrame(author=String[], action=String[], count=Int[])
curauthor = ""

for line in lines
    m = match(author, line)
    if m !== nothing
        global curauthor = m[1]
    end
    m = match(insc, line)
    m === nothing || push!(authordata,
                           [curauthor, "insertion", parse(Int, m[1])])
    m = match(delc, line)
    m === nothing || push!(authordata,
                           [curauthor, "deletion", parse(Int, m[1])])
end

authorstats = by(authordata, [:author, :action], count = :count=>sum)
df = unstack(authorstats, :action, :count)
df.all = coalesce.(df.deletion, 0) .+ coalesce.(df.insertion, 0)
display(sort!(df, :all, rev=true))
