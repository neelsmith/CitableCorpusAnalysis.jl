
"""Create a `TextAnalysis.Corpus` from a `CitableTextCorpus`.

$(SIGNATURES)
"""
function tacorpus(c::CitableTextCorpus)
    docs = map(cn -> StringDocument(cn.text), c.corpus)
    TextAnalysis.Corpus(docs)
end

"""Create a lexicon (a `Dict` of tokens to counts) from a `CitableTextCorpus`
using the `lexicon` function of the `TextAnalysis` module.

$(SIGNATURES)
"""
function talexicon(c::CitableTextCorpus)
    corp = tacorpus(c)
    update_lexicon!(corp)
    lexicon(corp)
end


"""Creates document-term matrix in dense matrix 
format.

$(SIGNATURES)
"""
function dtmatrix(c::CitableTextCorpus)
    tac = tacorpus(c)
    update_lexicon!(tac)
    sparsedtm = DocumentTermMatrix(tac)
	m = dtm(sparsedtm, :dense)
    m
end