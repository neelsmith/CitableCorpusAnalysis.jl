@testset "Test converting a citable corpus to  a TextAnalysi.Corpus" begin
    f = "data/hyginus.cex"
    c = read(f, String) |> corpus_fromcex
    @test length(c.passages) == 1234
    tacorp = CitableCorpusAnalysis.tacorpus(c)
    @test length(tacorp.documents) == length(c.passages)

    talex = talexicon(c)
    @test  length(talex) == 8711

    dtm = dtmatrix(c)
    @test size(dtm) == (1234, 8711)
end
