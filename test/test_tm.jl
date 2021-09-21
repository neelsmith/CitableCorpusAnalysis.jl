@testset "Test builidng Topic Model corpus" begin
    f = "data/hyginus.cex"
    c = read(f, String) |> corpus_fromcex
    tmcorp = tmcorpus(c)
    @test length(tmcorp.docs) == length(c.passages)
end