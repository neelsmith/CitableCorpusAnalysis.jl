"""Use orthography to create a tokenized corpus.

$(SIGNATURES)
"""
function tokenizedcorpus(ac::AnalyticalCorpus)
    tokenizedcorpus(ac.corpus, ac.orthography)
end


"""Create a new `CitableTextCorpus` containing only nodes of type `lextype`.

$(SIGNATURES)
"""
function lexicalcorpus(ac::AnalyticalCorpus; lextype = LexicalToken())
    pairs = tokenize(ac; filterby = lextype)
    lexonly = filter(tkn -> tkn.tokentype == lextype, pairs)
    map(pr -> pr.passage, lexonly) |> CitableTextCorpus
end

"""Compile vocabulary list for corpus.

$(SIGNATURES)
"""
function vocabulary(ac::AnalyticalCorpus; lextype = LexicalToken())
    tokenvalues(ac.corpus, ac.orthography; filterby = lextype)
end

"""Count number of distinct tokens in corpus.

$(SIGNATURES)
"""
function vocabulary_size(ac::AnalyticalCorpus; lextype = LexicalToken())
    vocabulary(ac; lextype =  lextype) |> length
end
