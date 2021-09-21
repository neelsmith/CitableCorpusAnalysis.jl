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
`CitableNode` with a (possibly empty) Vector of `Analysis` objects.

$(SIGNATURES)

First analyze list of unique tokens into a dictionary.
Then analyze each token successively.
"""
function analyzecorpus(ac::AnalyticalCorpus, data)
    wdlist = tokenvalues(ac.orthography,ac.corpus)
    parses = parsewordlist(ac.parser, wdlist, data)
    pairs = zip(wdlist, parses) |> collect |> Dict
    tokenized = tokenizedcorpus(ac.orthography,ac.corpus)

    analyses = []
    for cn in tokenized.passages
        if haskey(pairs, cn.text)
            push!(analyses, (cn, pairs[cn.text]))
        else
            # pair node with empty Vector if no
            # analyses found:
           push!(analyses, (cn, []))
        end
    end
    analyses
end


function serialize_analyses(analysispairs, register, delimiter = "|")

end