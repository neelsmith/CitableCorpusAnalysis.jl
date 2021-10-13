
@testset "Test profiling a sample corpus" begin
    f = "data/gettysburg/gettysburgcorpus.cex"
    c = read(f, String) |> corpus_fromcex
    ortho = simpleAscii()
    parser = CitableParserBuilder.gettysburgParser()
    ac = AnalyticalCorpus(c,ortho,parser)

    tc = tokenizedcorpus(ac)
    tkns = tokenize(ac)
    @test length(tc.passages) == length(tkns)

    pairs = tokentuples(ac)
    @test length(tc.passages) == length(pairs)

    lexcorpus = lexicalcorpus(ac)
    @test length(lexcorpus) == 1313

    vocab = vocabulary(ac)
    mostfrequent = "that"
    # Sorted by frequency
    @test vocab[1] == mostfrequent

    @test vocabularysize(ac) == 151

    
end