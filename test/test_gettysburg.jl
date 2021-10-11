
@testset "Test analyzing a corpus" begin
    f = "data/gettysburg/gettysburgcorpus.cex"
    c = read(f, String) |> corpus_fromcex
    ortho = simpleAscii()
    parser = CitableParserBuilder.gettysburgParser()
    acorpus = AnalyticalCorpus(c,ortho,parser)
    analyses = CitableCorpusAnalysis.analyzecorpus(acorpus, parser.data)

    wdlist = tokenvalues(c, ortho)
    tokenized = tokenizedcorpus(c, ortho)
    @test length(analyses) == length(tokenized.passages)
    @test isa(analyses[1], AnalyzedToken)
end



@testset "Test serializing an analysis list" begin
    f = "data/gettysburg/gettysburgcorpus.cex"
    c = read(f, String) |> corpus_fromcex
    ortho = simpleAscii()
    parser = CitableParserBuilder.gettysburgParser()
    acorpus = AnalyticalCorpus(c,ortho,parser)
    analyses = CitableCorpusAnalysis.analyzecorpus(acorpus, parser.data)
    registry = Dict(
        "gburglex" => "urn:cite2:citedemo:gburglex.v1:",
        "gburgform" => "urn:cite2:citedemo:gburgform.v1:",
        "gburgrule" => "urn:cite2:citedemo:gburgrule.v1:",
        "gburgstem" => "urn:cite2:citedemo:gburgstem.v1:"
    )
end
