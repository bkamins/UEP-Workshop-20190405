# Bogumił Kamiński, 2019-03-25

url = "https://projecteuler.net/project/resources/p096_sudoku.txt"
filename = "p096_sudoku.txt"
if !isfile(filename) # download only if needed
    println("File not found. Fetching from a remote location ...")
    try
        # this uses OS tools and might fail if they are not found
        download(url, filename)
    catch
        # thus we provide a fallback
        using HTTP
        r = HTTP.get(url)
        write(filename, r.body)
    end
end
