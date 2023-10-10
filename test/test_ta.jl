@testset "Test converting a citable corpus to  a TextAnalysi.Corpus" begin
    f = joinpath(pwd(), "data", "hyginus.cex")
    c = fromcex(f, CitableTextCorpus, FileReader)
    @test length(c.passages) == 1229
    tacorp = CitableCorpusAnalysis.tacorpus(c)
    @test length(tacorp.documents) == length(c.passages)

    talex = talexicon(c)
    @test  length(talex) == 8710

    dtm = dtmatrix(c)
    @test size(dtm) == (1229, 8710)
end
