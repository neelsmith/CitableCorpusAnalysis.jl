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
function analyzecorpus(ac::AnalyticalCorpus; data = nothing)
    wdlist = tokenvalues(ac.corpus, ac.orthography)
    pairs = parsewordlist(wdlist, ac.parser; data = data)
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

"""Tokenize text corpus.
$(SIGNATURES)
Returns a Vector of tuples pairing a `CitablePassage` with a `TokenCategory`.
"""
function tokenize(ac::AnalyticalCorpus; filterby = LexicalToken())
    alltokens = tokenize(ac.corpus, ac.orthography)
    isnothing(filterby) ? alltokens : filter(pr -> pr[2] == filterby, alltokens)
end