
"""Use orthography to create a tokenized corpus.

$(SIGNATURES)
"""
function tokenizedcorpus(ac::AnalyticalCorpus)
    tokenizedcorpus(ac.corpus, ac.orthography)
end

"""Create a Vector of tuples pairing citable passages with token types.

$(SIGNATURES)
"""
function tokentuples(ac::AnalyticalCorpus)
    tc = tokenizedcorpus(ac)
    tokenize(tc, ac.orthography) 
end

"""Create a new `CitableTextCorpus` containing only nodes of type `lextype`.

$(SIGNATURES)
"""
function lexicalcorpus(ac::AnalyticalCorpus, lextype = LexicalToken())
    pairs = tokentuples(ac)
    lexonly = filter(pr -> pr[2] == lextype, pairs)
    map(pr -> pr[1], lexonly) |> CitableTextCorpus
end


"""Measure number of tokens of type `lextype`in the corpus.

$(SIGNATURES)
"""
function lexicalsize(ac::AnalyticalCorpus, lextype = LexicalToken())
    lc = lexicalcorpus(ac, lextype)
    length(lc.passages)
end

"""Compile vocabulary list for corpus.

$(SIGNATURES)
"""
function vocabulary(ac::AnalyticalCorpus, lextype = LexicalToken())
    tokenvalues(ac.corpus, ac.orthography, lextype)
end


"""Count number of distinct tokens in corpus.

$(SIGNATURES)
"""
function vocabularysize(ac::AnalyticalCorpus, lextype = LexicalToken())
    vocabulary(ac, lextype) |> length
end