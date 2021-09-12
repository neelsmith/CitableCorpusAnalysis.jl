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
    dict = CSV.File(HTTP.get(CitableCorpusAnalysis.BANCROFT_URL).body) |> Dict
    GettysburgParser(parsestring, dict)
end

"""Parse String `s` by looking it up in a given dictionary.

Note that since `data` is a vararg, the dictionary 
will be data[1].
"""
function parsestring(s::AbstractString, data)
    dict = data[1][1]
    objid = s in keys(dict) ? dict[s] : "UNANALYZED"
    formurn = FormUrn(s"gburg.${objid}")
    lexurn = LexemeUrn("gburg.$s")
    ruleurn = RuleUrn("gburg.all")
    stemurn = StemUrn("gburg.all")
    [Analysis(s, lexurn, formurn, stemurn, ruleurn)]
end