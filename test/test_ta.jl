@testset begin
    f = "data/hyginus.csv"
    c = corpus_fromfile(f, "#")  
    @test length(c.corpus) == 1234
    tacorp = CitableCorpusAnalysis.tacorpus(c)
    @test length(tacorp.documents) == length(c.corpus)

    talex = talexicon(c)
    @test  length(talex) == 8711

    dtm = dtmatrix(c)
    @test size(dtm) == (1234, 8711)
end