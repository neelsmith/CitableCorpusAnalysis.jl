
@testset "Test analyzing a corpus" begin
    f = "data/gettysburg/gettysburgcorpus.cex"
    c = corpus_fromfile(f, "|")
    ortho = simpleAscii()
    parser = CitableCorpusAnalysis.gettysburgParser()
    acorpus = AnalyticalCorpus(c,ortho,parser)
    #strings = tokenvalues(acorpus.orthography, acorpus.corpus)
    #parser.data
    #dict = CSV.File(HTTP.get(CitableCorpusAnalysisBANCROFT_URL).body) |> Dict
    #=
    wdlist = tokenvalues(ortho,c)
    =#
    analyses = CitableCorpusAnalysis.analyzecorpus(acorpus, parser.data)
end