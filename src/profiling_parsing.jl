
function coverage(ac::AnalyticalCorpus; lextype = LexicalToken(),  data = nothing)
    lexcorpus = lexicalcorpus(ac, lextype)
    analyticallex = AnalyticalCorpus(lexcorpus, ac.orthography, ac.parser)
    atokens = analyzecorpus(analyticallex, data)
end