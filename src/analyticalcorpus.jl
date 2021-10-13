"""Essential components of an analytical corpus.

Its contents must be citable, in a defined orthography,
and tokens defined by that orthography must be parseable.
"""
struct AnalyticalCorpus
    corpus::CitableTextCorpus
    orthography::OrthographicSystem
    parser::CitableParser
end


"""Analyze all tokens in a corpus.  The result is a list of pairings of a 
`CitablePassage` with a (possibly empty) Vector of `Analysis` objects.

$(SIGNATURES)

First analyze list of unique tokens into a dictionary.
Then analyze each token successively.
"""
function analyzecorpus(ac::AnalyticalCorpus, data)
    wdlist = tokenvalues(ac.corpus, ac.orthography)
    parses = parsewordlist(wdlist, ac.parser, data)
    pairs = zip(wdlist, parses) |> collect |> Dict
    tokenized = tokenizedcorpus(ac.corpus, ac.orthography)

    analyses = []
    for cn in tokenized.passages
        if haskey(pairs, cn.text)
            push!(analyses, AnalyzedToken(cn, pairs[cn.text]))
        else
            # pair node with empty Vector if no
            # analyses found:
           push!(analyses, AnalyzedToken(cn, []))
        end
    end
    analyses
end


function serialize_analyses(analysispairs, register, delimiter = "|")
    error("NOT YET IMPLEMENTED")
end