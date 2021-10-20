
@testset "Test profiling a sample corpus" begin
    f = "data/gettysburg/gettysburgcorpus.cex"
    c = read(f, String) |> corpus_fromcex
    ortho = simpleAscii()
    dictsrc = "data/posdict.csv"
    parserdict = CSV.File(dictsrc) |> Dict
    parser = CitableParserBuilder.gettysburgParser(dict = parserdict)
    ac = AnalyticalCorpus(c,ortho,parser)

    tc = tokenizedcorpus(ac)
    tkns = tokenize(ac; filterby = LexicalToken())
    @test length(tc.passages) == length(tkns)

    pairs = tokenize(ac; filterby = LexicalToken())
    @test length(tc.passages) == length(pairs)

    lexcorpus = lexicalcorpus(ac)
    @test length(lexcorpus.passages) == 1313

    vocab = vocabulary(ac)
    mostfrequent = "that"
    # Sorted by frequency
    @test vocab[1] == mostfrequent
    @test vocabulary_size(ac) == 151 
end