@testset "Test topic modeling" begin
    f = joinpath(pwd(), "data", "hyginus.cex")
    #u = "https://raw.githubusercontent.com/neelsmith/digitalmyth/dev/texts/grant-hyginus.cex"
    c = fromcex(f, CitableTextCorpus, FileReader)
    tm = lda_tm(c, 10; iters = 500)

    @test tm isa TopicModel
    @test k(tm) == 10

    @test length(topiclabels(tm)) == k(tm)
    @test topicsfordoc(tm, 1) isa Vector{Float64}
    @test length(topicsfordoc(tm, 1)) == k(tm)
    @test topicfordoc(tm, 1) isa Tuple{String, Float64}

    @test termindex(tm, "et") isa Int
    @test length(topterms(tm, 1; n = 5)) == 5

    @test documentindex(tm, "urn:cts:latinLit:stoa1263.stoa001.hc:t.1") == 1
    @test length(topdocs(tm, 1; n = 5)) == 5

    
end