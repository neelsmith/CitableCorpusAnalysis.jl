"""A topic model.
- `terms`: ordered list of terms in the model
- `docids`: ordred list of identifiers for documents in the model
- `topic_terms`: topic-to-term index. Rows of this matrix sum to 1.
- `topic_docs`: topic-to-document index.  Columns of this matrix sum to 1.
"""
struct TopicModel
    terms
    docids
    topic_terms
    topic_docs
end

"""Override Base.show for `TopicModel`.
$(SIGNATURES)
"""
function show(io::IO, tm::TopicModel)
    msg = string("LDA topic model for ", length(tm.terms), " terms in ", length(tm.docids), " documents.")

    print(io,msg)
end

"""Create a `TopicModel` of text in corpus `c` with `k` topics."""
function lda_tm(c::CitableTextCorpus, k::Int; 
    alpha = 0.1, beta = 0.1, iters = 1000,
    stopwords = String[],
    doclabels = []
    )     
    #1. create tacorpus
	corp = map(psg -> StringDocument(psg.text), c.passages) |> Corpus
   
    try
        prepare!(corp, strip_punctuation)
    catch e
        @warn("Failed to strip punctuation.")
    end
	remove_words!(corp, stopwords)
    update_inverse_index!(corp)
	update_lexicon!(corp)
    # 2. compute terms list
    dtmatrix = DocumentTermMatrix(corp)
    # 3. compute doclabels if needed
    if isempty(doclabels)
        doclabels = map(psg -> string(psg.urn), c.passages)
    end
    # 4. run lda() to get 2 matrices we need
    ϕ, θ  = lda(dtmatrix, k, iters, alpha, beta)
    # 5. construct 
    TopicModel(dtmatrix.terms, doclabels, ϕ, θ)
   
end

