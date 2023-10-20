struct TopicModel
    terms
    docids
    topic_terms
    topic_docs
end


function lda_tm(c::CitableTextCorpus, k::Int, o::T; 
    alpha = 0.1, beta = 0.1, iters = 1000,
    stopwords = [],
    doclabels = []
    ) where T <: OrthographicSystem

    #=
    1. create tacorpus
    2. compute terms list (tokenize for lex, rm stopwords)
    3. compute doclabels if needed
    4. run lda() to get 2 matrices we need
    5. construct 
    =#
end

