@testset "Test builidng Topic Model corpus" begin
    f = "data/hyginus.cex"
    c = fromcex(f, CitableTextCorpus, FileReader)
    tmcorp = tmcorpus(c)
    @test length(tmcorp.docs) == length(c.passages)
end