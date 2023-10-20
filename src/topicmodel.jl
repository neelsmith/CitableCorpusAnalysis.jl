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

"""Compose a human-readable label for a topic by catting together
the top `count` term values.
"""
function labeltopic(tm::TopicModel, topicnum::Int; count = 4)
	pairs = top_scores(tm.topic_terms[topicnum,:], tm.terms)
	join(map(pr -> pr[1], pairs)[1:count], "_")
end





### "Private" functions

"""Find top `n` scores in `datalist`, and return corresponding values from `labelslist`.
Parameters:
- `datalist`: a single row or column of scores (for terms or documents)
- `labelslist`: ordered list of values corresponding to columns of scores (string for term, or ID for document)
"""
function top_scores(datalist, labelslist; n = 10)
	raw = raw_pairs(datalist, labelslist; n = n)
	isolatescores(raw, n)
end

"""Given a list of possible index keys with corresponding scores, flatten the
list to create a list of the top `n` value-score pairs."""
function isolatescores(scorelists, n)
    flatresults = []
    names = map(pr -> pr[1], scorelists) |> Iterators.flatten |> collect |> unique
    for nameval in names[1:n]
        score = filter(pr -> nameval in pr[1], scorelists)[1][2]
        push!(flatresults,(nameval,score))
    end
    flatresults
end



"""Given one row of a topic index, find top `n` scores,
and return a Vector of `n` pairs of topic relations and scores."""
function raw_pairs(row, termlist; n = 10)
	sorted = sort(row, rev = true)
	termvalpairs = []
	for val in sorted[1:n]	
		rowidx = findall(col -> col == val, row)
		push!(termvalpairs, (termlist[rowidx], val))
	end
    termvalpairs
end