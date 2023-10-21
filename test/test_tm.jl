@testset "Test topic modeling" begin
    f = joinpath(pwd(), "data", "hyginus.cex")
    u = "https://raw.githubusercontent.com/neelsmith/digitalmyth/dev/texts/grant-hyginus.cex"
    c = fromcex(u, CitableTextCorpus, UrlReader)
    tm = lda_tm(c, 10)

    @test tm isa TopicModel
end