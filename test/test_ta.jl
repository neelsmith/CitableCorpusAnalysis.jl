@testset begin
    f = "data/hyginus.csv"
    c = fromfile(CitableTextCorpus, f, "#")  
    @test length(c.corpus) == 1234
    tacorp = tacorpus(c)
    @test length(tacorp.documents) == length(c.corpus)

    talex = talexicon(c)
    @test  length(talex) == 8711

    dtm = dtmatrix(c)
    @test size(dtm) == (1234, 8711)
end