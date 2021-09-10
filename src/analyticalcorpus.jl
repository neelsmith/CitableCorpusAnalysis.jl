"""Essential components of an analytical corpus.

Its contents must be citable, in a defined orthography,
and tokens defined by that orthography must be parseable.
"""
struct AnalyticalCorpus
    corpus::CitableTextCorpus
    orthography::OrthographicSystem
    parser::CitableParser
end


"""Analyze all tokens in a corpus.

$(SIGNATURES)

First analyze list of unique tokens into a dictionary.
Then analyze each token successively.
"""
function analyzecorpus(ac::AnalyticalCorpus, data...)
    wdlist = tokenvalues(ac.orthography,ac.corpus)
    dict = data[1]
    parses = parsewordlist(ac.parser, wdlist, dict)
    pairs = zip(wdlist, parses) |> collect |> Dict


end