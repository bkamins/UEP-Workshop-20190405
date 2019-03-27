# Bogumił Kamiński, 2019-03-25

using DataFrames, CSV

df = CSV.read("iris.csv")
describe(df)
df2 = stack(df)
CSV.write("iris2.csv", df2)
