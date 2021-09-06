# A pure Julia POS tagger for Bancroft's version of the Gettysburg address.
using CSV, HTTP

"""POS tagger keyed to the text of the Gettysburg address."""
struct GettysburgParser <: CitableParser
    stringparser
    data
end

BANCROFT_URL = "https://raw.githubusercontent.com/neelsmith/CitableCorpusAnalysis.jl/main/test/data/posdict.csv"


"""Instantiate a `GettysburgParser`.
"""
function gettysburgParser() 
    dict = CSV.File(HTTP.get(BANCROFT_URL).body) |> Dict
    GettysburgParser(parsestring, dict)
end

"""Lookup String `s` in dictionary.

Note that since data is a vararg, we can find the dictionary 
in data[1].
"""
function parsestring(s::AbstractString, data)
    dict = data[1]
    s in keys(dict) ? dict[s] : nothing
end