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
    parses = parsewordlist(ac.parser, wdlist, data)
    pairs = zip(wdlist, parses) |> collect |> Dict
    tokenized = tokenizedcorpus(ac.orthography,ac.corpus)

    analyses = []
    for cn in tokenized.corpus
        if haskey(pairs, cn.text)
            #@info("Parse exists for ", cn.text)
            push!(analyses, (cn, pairs[cn.text]))
        else
           push!(analyses, (cn, []))
           #@info("NO PARSE for ", cn.text)
        end
    end
    analyses
end