
@testset "Test analyzing a corpus" begin
    f = "data/gettysburg/gettysburgcorpus.csv"
    c = corpus_fromfile(f, "|")
    ortho = simpleAscii()
    parser = CitableCorpusAnalysis.gettysburgParser()
    acorpus = AnalyticalCorpus(c,ortho,parser)
    analyses = CitableCorpusAnalysis.analyzecorpus(acorpus, parser.data)

    wdlist = tokenvalues(ortho,c)
    tokenized = tokenizedcorpus(ortho,c)
    @test length(analyses) == length(tokenized.corpus)
end