
@testset "Test profiling a sample corpus" begin
    f = joinpath(pwd(), "data","gettysburg","gettysburgcorpus.cex")
    c = fromcex(f, CitableTextCorpus, FileReader)
    ortho = simpleAscii()
    dictsrc = joinpath(pwd(), "data","posdict.csv")
    parserdict = CSV.File(dictsrc) |> Dict
    parser = CitableParserBuilder.gettysburgParser(dict = parserdict)
    ac = AnalyticalCorpus(c,ortho,parser)

    tc = tokenizedcorpus(ac)
    @test length(tc.passages) == 1506
    tkns = filter(tkn -> tkn.tokentype == LexicalToken(), Orthography.tokenize(tc, ortho))
    @test length(tkns)== 1313
    lexcorpus = lexicalcorpus(ac)
    @test length(lexcorpus.passages) == length(tkns)

    vocab = vocabulary(ac)
    mostfrequent = "that"
    # Sorted by frequency
    @test vocab[1] == mostfrequent
    @test vocabulary_size(ac) == 151 
end