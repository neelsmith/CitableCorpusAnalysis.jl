var documenterSearchIndex = {"docs":
[{"location":"example/corpus/#Analyzing-a-text-corpus","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"","category":"section"},{"location":"example/corpus/#Summary","page":"Analyzing a text corpus","title":"Summary","text":"","category":"section"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"We start with a corpus citable by CTS URN. In these examples, we'll work with a citable corpus of the five extant versions of the Gettysburg Address.  We will then construct an AnalyticalCorpus that matches this citable corpus with an orthography and a parser.  With this in hand, we can create a full, morphologically aware analysis of each token in the corpus with a single function call.","category":"page"},{"location":"example/corpus/#Load-the-source-corpus","page":"Analyzing a text corpus","title":"Load the source corpus","text":"","category":"section"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"We can load the source data into the CitableTextCorpus model from a URL.  The corpus_cex function works on string data, so we will use standard Julia methods to load a String from the URL.","category":"page"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"using CitableCorpus\nusing HTTP\ncorpusurl = \"https://raw.githubusercontent.com/neelsmith/CitableCorpusAnalysis.jl/dev/test/data/gettysburg/gettysburgcorpus.cex\"\ncorpus = HTTP.get(corpusurl).body |> String  |> corpus_fromcex\ntypeof(corpus)\n\n# output\n\nCitableTextCorpus","category":"page"},{"location":"example/corpus/#Aside:-working-with-selections","page":"Analyzing a text corpus","title":"Aside: working with selections","text":"","category":"section"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"You can use any of the functions of the CitableCorpus module to work with selections from a citable corpus.  E.g., you can retrieve selected passages, or select a complete document from the corpus","category":"page"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"using CitableText\nrangeUrn = CtsUrn(\"urn:cts:citedemo:gburg.nicolay.v2:1-2\")\nrangePassages = retrieve(rangeUrn, corpus)\n\n# output\n\n2-element Vector{Any}:\n <urn:cts:citedemo:gburg.nicolay.v2:1> Four score and seven years ago our fathers brought forth, upon this continent, a new nation, conceived in liberty, and dedicated to the proposition that all men are created equal.\n <urn:cts:citedemo:gburg.nicolay.v2:2> Now we are engaged in a great civil war, testing whether that nation, or any nation so conceived, and so dedicated, can long endure. We are met on a great battle field of that war. We come to dedicate a portion of it, as a final resting place for those who died here, that the nation might live. This we may, in all propriety do.","category":"page"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"hayUrn = CtsUrn(\"urn:cts:citedemo:gburg.hay.v2:\")\nhay = document(hayUrn, corpus)\n\n# output\n\n\"Citable document <urn:cts:citedemo:gburg.hay.v2:> 4 citable passages\"","category":"page"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"note: Note\nSee the documentation for the CitableCorpus module to learn more about manipulating citable documents and corpora.","category":"page"},{"location":"example/corpus/#Constructing-an-AnalyticalCorpus","page":"Analyzing a text corpus","title":"Constructing an AnalyticalCorpus","text":"","category":"section"},{"location":"example/corpus/#Orthography","page":"Analyzing a text corpus","title":"Orthography","text":"","category":"section"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"The Orthography module includes a simple ASCII orthography that we can use with our Gettsyburg corpus.","category":"page"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"using Orthography\northography = simpleAscii()\ntypeof(orthography) |> supertype\n\n# output\n\nOrthographicSystem","category":"page"},{"location":"example/corpus/#Morphology","page":"Analyzing a text corpus","title":"Morphology","text":"","category":"section"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"The CitableCorpusAnalysis module includes an implementation of the CitableParser abstraction that can parse tokens in the Gettysburg Address to their corresponding Penn treebank POS code.  (For details on how the parser was constructed, see the appendix to this documentation.)","category":"page"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"using CitableCorpusAnalysis\nparser = CitableCorpusAnalysis.gettysburgParser()\ntypeof(parser) |> supertype\n\n# output\n\nCitableParserBuilder.CitableParser","category":"page"},{"location":"example/corpus/#The-analytical-corpus","page":"Analyzing a text corpus","title":"The analytical corpus","text":"","category":"section"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"Our analytical corpus associates these three components.","category":"page"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"acorpus = AnalyticalCorpus(corpus, orthography, parser)\ntypeof(acorpus)\n\n# output\n\nCitableParserBuilder.AnalyzedToken","category":"page"},{"location":"example/corpus/#The-analyses","page":"Analyzing a text corpus","title":"The analyses","text":"","category":"section"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"The analyzecorpus function requires an AnalyticalCorpus as an argument. It first creates a tokenized edition, then analyses each token. It returns a Vector of AnalyzedTokens, where each CitablePassage is associated with a (possibly empty) Vector of Analysis objects.","category":"page"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"Our corpus has a total of 1506 tokens, so the result will have 1506 AnalyzedTokens.","category":"page"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"analyses = analyzecorpus(acorpus, parser.data)\nlength(analyses)\n\n# output\n\n1506","category":"page"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"analyses[1] |> typeof\n\n# output\n\nAnalyzedToken","category":"page"},{"location":"example/corpus/#Additional-arguments","page":"Analyzing a text corpus","title":"Additional arguments","text":"","category":"section"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"The analyzecorpus function allows an optional data parameter that will passed along to the parsing functions it applies.  In this example, the GettysburgParser can use a dictionary of analyses to get better performance, since it otherwise loads the entire dictionary for each individual parse.","category":"page"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"fastanalyses = analyzecorpus(acorpus, parser.data)\nlength(fastanalyses)\n\n# output\n\n1506","category":"page"},{"location":"example/profiling/#Profiling-a-corpus","page":"Profiling a corpus","title":"Profiling a corpus","text":"","category":"section"},{"location":"example/profiling/#Using-a-Vector-of-AnalyzedTokens","page":"Profiling a corpus","title":"Using a Vector of AnalyzedTokens","text":"","category":"section"},{"location":"example/profiling/","page":"Profiling a corpus","title":"Profiling a corpus","text":"The analyzecorpus function yields a list of AnalyzedTokens.  We can derive metrics for our corpus from this list including:","category":"page"},{"location":"example/profiling/","page":"Profiling a corpus","title":"Profiling a corpus","text":"lexical metrics\nthe lexical ambiguity of the corpus\nthe lexical histogram of the corpus\nmeasures of the coverage of the parser for the corpus\nmorphological metrics\nthe morphological ambiguity of the corpus\nthe morphological histogram of the corpus","category":"page"},{"location":"example/profiling/#Interoperating-with-Julia-TextAnalysis.Corpus","page":"Profiling a corpus","title":"Interoperating with Julia TextAnalysis.Corpus","text":"","category":"section"},{"location":"example/profiling/","page":"Profiling a corpus","title":"Profiling a corpus","text":"You can generate a TextAnalysis.Corpus from a CitableCorpus.","category":"page"},{"location":"example/profiling/","page":"Profiling a corpus","title":"Profiling a corpus","text":"Sometimes, you'll want to preprocess the original CitableCorpus so as not to depend on the tokenization of the TextAnalysis module.  You can do this by creating a tokenized corpus that takes account of a specified orthography, and constructing a TextAnalysis.Corpus from this source.","category":"page"},{"location":"#CitableCorpusAnalysis.jl","page":"Overview","title":"CitableCorpusAnalysis.jl","text":"","category":"section"},{"location":"","page":"Overview","title":"Overview","text":"Tokenize and analyze a citable text corpus.","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"There are many ways to model a text corpus.  CitableCorpusAnalysis integrates models from these Julia modules:","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"Corpus in TextAnalysis\nCitableTextCorpus in CitableCorpus","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"It also introduces a further model, the AnalyticalCorpus.","category":"page"},{"location":"#Overview-of-an-analytical-corpus","page":"Overview","title":"Overview of an analytical corpus","text":"","category":"section"},{"location":"","page":"Overview","title":"Overview","text":"An AnalyticalCorpus has three components:","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"a citable corpus of texts (a CitableText.CitableTextCorpus)\nan orthographic system that can validate orthography and tokenize a citable text (an Orthography.OrthographicSystem)\na citable parser, that analyses citable tokens in terms of citable lexemes and morphological or other data (a CitableParserBuilder.CitableParser)","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"Functions working with an AnalyticalCorpus can tokenize a corpus, analyze its tokens with a CitableParser, and can apply the corpus analytical functions of a TextAnalysis.Corpus to any citable text content.","category":"page"},{"location":"#Example-pages","page":"Overview","title":"Example pages","text":"","category":"section"},{"location":"","page":"Overview","title":"Overview","text":"The following pages walk through examples using a small corpus comprising all the extant versions of the Gettysburg address.  We will tokenize it with a simple ASCII tokenizer included in the Orthography module, and will parse it with a custom GettysburgParser built for this demo. (Its construction is documented in the appendix to these pages, and illustrates one simple way to build an English-language parser by wrapping the Python NLTK POS tagger.)","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"using CitableCorpusAnalysis\nusing CitableCorpus\nusing Orthography\nusing HTTP\n# Load a CitableCorpus from a URL:\nurl = \"https://raw.githubusercontent.com/neelsmith/CitableCorpusAnalysis.jl/dev/test/data/gettysburg/gettysburgcorpus.cex\"\ncorpus = HTTP.get(url).body |> String  |> corpus_fromcex\n# Instantiate an orthographic system and parser\northography = Orthography.simpleAscii()\nparser = CitableCorpusAnalysis.gettysburgParser()\nacorpus = AnalyticalCorpus(corpus, orthography, parser)\ntypeof(acorpus)\n\n# output\n\nAnalyticalCorpus","category":"page"},{"location":"man/api/#API-Documentation","page":"API documentation","title":"API Documentation","text":"","category":"section"},{"location":"man/api/#Types","page":"API documentation","title":"Types","text":"","category":"section"},{"location":"man/api/","page":"API documentation","title":"API documentation","text":"AnalyticalCorpus","category":"page"},{"location":"man/api/#CitableCorpusAnalysis.AnalyticalCorpus","page":"API documentation","title":"CitableCorpusAnalysis.AnalyticalCorpus","text":"Essential components of an analytical corpus.\n\nIts contents must be citable, in a defined orthography, and tokens defined by that orthography must be parseable.\n\n\n\n\n\n","category":"type"},{"location":"man/api/#Exported-functions","page":"API documentation","title":"Exported functions","text":"","category":"section"},{"location":"man/api/","page":"API documentation","title":"API documentation","text":"tacorpus\ntalexicon\ndtmatrix","category":"page"},{"location":"man/api/#CitableCorpusAnalysis.tacorpus","page":"API documentation","title":"CitableCorpusAnalysis.tacorpus","text":"Create a TextAnalysis.Corpus from a CitableTextCorpus.\n\ntacorpus(c)\n\n\n\n\n\n\n","category":"function"},{"location":"man/api/#CitableCorpusAnalysis.talexicon","page":"API documentation","title":"CitableCorpusAnalysis.talexicon","text":"Create a lexicon (a Dict of tokens to counts) from a CitableTextCorpus using the lexicon function of the TextAnalysis module.\n\ntalexicon(c)\n\n\n\n\n\n\n","category":"function"},{"location":"man/api/#CitableCorpusAnalysis.dtmatrix","page":"API documentation","title":"CitableCorpusAnalysis.dtmatrix","text":"Creates the document-term matrix for a CitableTextCorpus in dense matrix  format.\n\ndtmatrix(c)\n\n\nNote that this relies on the dictionary created by TextAnalysis.lexicon().\n\n\n\n\n\n","category":"function"},{"location":"example/parser/#Appendix:-a-note-on-the-citable-parser","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"","category":"section"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"The GettysburgParser used in this demonstration works with a simple dictionary of tokens to POS tags.  The dictionary was constructed by wrapping the Python NLTK POS tagger with a Julia function. This page documents how to do that so that you can generically apply the NTLK tagger to a list of tokens from Julia.","category":"page"},{"location":"example/parser/#Python-prerequisites","page":"Appendix: a note on the citable parser","title":"Python prerequisites","text":"","category":"section"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"You need to have Python, with nltk.","category":"page"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"pip install nltk","category":"page"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"Then start python, and at the python prompt,","category":"page"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"import nltk\nnltk.download","category":"page"},{"location":"example/parser/#A-Julia-wrapper","page":"Appendix: a note on the citable parser","title":"A Julia wrapper","text":"","category":"section"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"# If you're in a system with python accessible\n# and the nltk module installed, you can actually\n# execute all the code blocks on this page.\nrepo = pwd() |> dirname  |> dirname |> dirname\ngburgfile = repo * \"/test/data/gettysburg/gettysburgcorpus.cex\"\nusing CitableCorpus\ncorpus = corpus_fromfile(gburgfile, \"|\")","category":"page"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"note: Note\nIn the extra directory, the script engpos.jl does everything documented here, and can be run from the command line from the root of the repository with julia --project=extra/ extra/engpos.jl","category":"page"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"In Julia, you can make the NLTK module's tag function available like this:","category":"page"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"using Conda\nConda.add(\"nltk\")\nusing PyCall\n@pyimport nltk.tag as ptag","category":"page"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"Now if we have a citable corpus named corpus, we can use the TextAnalysis functions to extract a unique lexicon, and apply the NLTK tagger to it.","category":"page"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"using CitableCorpusAnalysis\nusing TextAnalysis\ntacorp = tacorpus(corpus)\n\ntkns = []\nfor doc in tacorp.documents\n    push!(tkns, tokens(doc))\nend\ntknlist = tkns |> Iterators.flatten |> collect |> unique\ntagged = ptag.pos_tag(tknlist)","category":"page"}]
}
