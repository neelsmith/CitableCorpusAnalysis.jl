
@testset "Test analyzing a corpus" begin
    f = "data/gettysburg/gettysburgcorpus.cex"
    c = read(f, String) |> corpus_fromcex
    ortho = simpleAscii()
    dictsrc = "data/posdict.csv"
    parserdict = CSV.File(dictsrc) |> Dict
    parser = CitableParserBuilder.gettysburgParser(dict = parserdict)
    acorpus = AnalyticalCorpus(c,ortho,parser)
    
    analyses = analyzecorpus(acorpus; data = parserdict)

    tokenized = tokenizedcorpus(c, ortho)
    @test length(analyses) == length(tokenized.passages)
    @test isa(analyses[1], AnalyzedToken)
end



@testset "Test serializing an analysis list" begin
    f = "data/gettysburg/gettysburgcorpus.cex"
    c = read(f, String) |> corpus_fromcex
    ortho = simpleAscii()
    dictsrc = "data/posdict.csv"
    parserdict = CSV.File(dictsrc) |> Dict
    parser = CitableParserBuilder.gettysburgParser(dict = parserdict)
    acorpus = AnalyticalCorpus(c,ortho,parser)
    analyses = analyzecorpus(acorpus; data = parser.data)
    registry = Dict(
        "gburglex" => "urn:cite2:citedemo:gburglex.v1:",
        "gburgform" => "urn:cite2:citedemo:gburgform.v1:",
        "gburgrule" => "urn:cite2:citedemo:gburgrule.v1:",
        "gburgstem" => "urn:cite2:citedemo:gburgstem.v1:"
    )
    # ADD TEST HERE WHEN IMPLEMENTED
end
