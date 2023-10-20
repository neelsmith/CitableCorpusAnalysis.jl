@testset "Test topic modeling" begin
    f = joinpath(pwd(), "data", "hyginus.cex")
    c = fromcex(f, CitableTextCorpus, FileReader)
    tm = lda_tm(c, 10)

    @test tm isa TopicModel
end