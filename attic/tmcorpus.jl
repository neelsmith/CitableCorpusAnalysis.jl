
"""Construct a TopicModelsVB.Corpus from a
CitableTextCorpus.

$(SIGNATURES)

To build a TopicModelsVB.Corpus, we need data in local files. 
At a minimum, we need a lexicon file and the DT matrix.
"""
function tmcorpus(corpus::CitableTextCorpus, ortho::T) where {T <: OrthographicSystem}
    concordance = corpusindex(corpus,ortho)
    idx = 0
    vocabkey = []
    vocabdict = Dict()
    for k in keys(concordance)
        idx = idx + 1
        push!(vocabkey,"$(idx)\t$(k)")
        vocabdict[k] = idx
    end
    vocabfile = tempname()
    open(vocabfile,"w") do io
        write(io, join(vocabkey,"\n") * "\n")
    end
    

    # Citable units are our "documents" for topic modelling purposes.
    # Use URNs as titles
    titlefile = tempname()
    titles = map(p -> string(p.urn), corpus) 
    open(titlefile, "w") do io
        write(io, join(titles,"\n") * "\n")
    end
    
    bow = []
    # map lex tokens  to lexicon keys
    for p in corpus
        tkns = tokenize(p.text, ortho)
        lex = filter(t -> t.tokencategory == LexicalToken(), tkns)
        lexstrs = map(t -> t.text, lex)
        indexedwords = []
        for wd in lexstrs
            if haskey(vocabdict, wd)
                push!(indexedwords, vocabdict[wd])
            else
                throw(DomainError("No key $(wd) in vocabulary for document $(p)"))
            end
        end
        push!(bow,join(indexedwords,","))
    end
    docsfile = tempname()
    open(docsfile,"w") do io
        write(io, join(bow,"\n") * "\n")
    end
    @info("Peek at ", vocabfile, titlefile, docsfile)
    #(vocabfile, titlefile, docsfile)
    tmvb = TopicModelsVB.readcorp(docfile=docsfile, vocabfile = vocabfile, titlefile = titlefile)
    rm(vocabfile)
    rm(titlefile)
    rm(docsfile)
    tmvb


end
