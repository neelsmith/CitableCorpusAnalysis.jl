@testset "Test builidng Topic Model corpus" begin
    f = "data/hyginus.csv"
    c = fromfile(CitableTextCorpus, f, "#") 
    tmcorp = tmcorpus(c)
    @test length(tmcorp.docs) == length(c.corpus)
end