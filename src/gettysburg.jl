# For use in testing and demonstartsions: 
# pure-Julia POS tagger for the corpus of all
# extant versions of the Gettysburg address.
#
using CSV, HTTP

"""POS tagger keyed to the text of the Gettysburg address.

- `stringparser` is the parsing function required by the `CitableParser` interface.
- `data` is a dictionary of tokens to form POS tag.
"""
struct GettysburgParser <: CitableParser
    stringparser
    data
end

GETTYSBURG_DICT_URL = "https://raw.githubusercontent.com/neelsmith/CitableCorpusAnalysis.jl/main/test/data/posdict.csv"


"""Instantiate a `GettysburgParser`.
"""
function gettysburgParser() 
    dict = CSV.File(HTTP.get(CitableCorpusAnalysis.GETTYSBURG_DICT_URL).body) |> Dict
    GettysburgParser(parsestring, dict)
end

"""Parse String `s` by looking it up in a given dictionary.

Note that since `data` is defined in the `CitableParserBuilder` model as a  vararg, the dictionary itself will be data[1].
"""
function parsestring(s::AbstractString, data)
    dict = data[1][1]
    objid = s in keys(dict) ? dict[s] : "UNANALYZED"
    formurn = FormUrn("gburg.$objid")
    lexurn = LexemeUrn("gburg.$s")
    ruleurn = RuleUrn("gburg.all")
    stemurn = StemUrn("gburg.all")
    [Analysis(s, lexurn, formurn, stemurn, ruleurn)]
end