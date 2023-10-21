@testset "Test builidng Topic Model corpus" begin
    f = joinpath(pwd(), "data","hyginus.cex")
    c = fromcex(f, CitableTextCorpus, FileReader)
    tmcorp = tmcorpus(c, simpleAscii())
    @test length(tmcorp.docs) == length(c.passages)
end