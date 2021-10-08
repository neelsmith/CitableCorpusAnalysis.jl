var documenterSearchIndex = {"docs":
[{"location":"example/corpus/#Analyzing-a-text-corpus","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"","category":"section"},{"location":"example/corpus/#Summary","page":"Analyzing a text corpus","title":"Summary","text":"","category":"section"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"We start with a corpus citable by CTS URN. In these examples, we'll work with a citable corpus of the extant versions of the Gettysburg Address.  We will then construct an AnalyticalCorpus that matches this citable corpus with an orthography and a parser.  With this in hand, we can create a full, morphologically aware analysis of each token in the corpus with a single function call.","category":"page"},{"location":"example/corpus/#Load-the-source-corpus","page":"Analyzing a text corpus","title":"Load the source corpus","text":"","category":"section"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"We can load the source data into the CitableTextCorpus model from a URL.","category":"page"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"using CitableCorpus\ncorpusurl = \"https://raw.githubusercontent.com/neelsmith/CitableCorpusAnalysis.jl/main/test/data/gettysburg/gettysburgcorpus.csv\"\ncorpus = corpus_fromurl(corpusurl, \"|\")\ntypeof(corpus)\n\n# output\n\nCitableTextCorpus","category":"page"},{"location":"example/corpus/#Retrieve-passages","page":"Analyzing a text corpus","title":"Retrieve passages","text":"","category":"section"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"TBA","category":"page"},{"location":"example/corpus/#Constructing-an-AnalyticalCorpus","page":"Analyzing a text corpus","title":"Constructing an AnalyticalCorpus","text":"","category":"section"},{"location":"example/corpus/#Orthography","page":"Analyzing a text corpus","title":"Orthography","text":"","category":"section"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"The Orthography module includes a simple ASCII orthography that we can use with our Gettsyburg corpus.","category":"page"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"using Orthography\northography = simpleAscii()\ntypeof(orthography) |> supertype\n\n# output\n\nOrthographicSystem","category":"page"},{"location":"example/corpus/#Morphology","page":"Analyzing a text corpus","title":"Morphology","text":"","category":"section"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"The CitableCorpusAnalysis module includes an implementation of the CitableParser abstraction that can parse tokens in the Gettysburg Address to their corresponding Penn treebank POS code.  (For details on how the parser was constructed, see the appendix to this documentation.)","category":"page"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"using CitableCorpusAnalysis\nparser = CitableCorpusAnalysis.gettysburgParser()\ntypeof(parser) |> supertype\n\n# output\n\nCitableParserBuilder.CitableParser","category":"page"},{"location":"example/corpus/#The-analytical-corpus","page":"Analyzing a text corpus","title":"The analytical corpus","text":"","category":"section"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"Our analytical corpus associates these three components.","category":"page"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"acorpus = AnalyticalCorpus(corpus, orthography, parser)\ntypeof(acorpus)\n\n# output\n\nAnalyticalCorpus","category":"page"},{"location":"example/corpus/#The-analyses","page":"Analyzing a text corpus","title":"The analyses","text":"","category":"section"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"The analyzecorpus function requires an AnalyticalCorpus as an argument. It returns a Vector of pairings that associate a CitableNode (from the CitableText module) with a Vector of Analysis objects (from the CitableParserBuilder module).  Our corpus has a total of 1506 tokens.","category":"page"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"analyses = analyzecorpus(acorpus, parser.data)\nlength(analyses)\n\n# output\n\n1506","category":"page"},{"location":"example/corpus/#Additional-arguments","page":"Analyzing a text corpus","title":"Additional arguments","text":"","category":"section"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"This may be followed by an optional data parameter that will passed along to the parsing functions it applies.  Here, by passing along a dictionary that the parsing function can use, we can get better performance that loading the entire dictionary for each individual parse.","category":"page"},{"location":"example/corpus/","page":"Analyzing a text corpus","title":"Analyzing a text corpus","text":"fastanalyses = analyzecorpus(acorpus, parser.data)\nlength(fastanalyses)\n\n# output\n\n1506","category":"page"},{"location":"example/profiling/#Profiling-a-corpus","page":"Profiling a corpus","title":"Profiling a corpus","text":"","category":"section"},{"location":"example/profiling/#Interoperating-with-Julia-TextAnalysis.Corpus","page":"Profiling a corpus","title":"Interoperating with Julia TextAnalysis.Corpus","text":"","category":"section"},{"location":"example/profiling/","page":"Profiling a corpus","title":"Profiling a corpus","text":"generate a TextAnalysis.Corpus from a CitableCorpus","category":"page"},{"location":"example/profiling/","page":"Profiling a corpus","title":"Profiling a corpus","text":"Sometimes, you'll want to preprocess the original CitableCorpus so as not to depend on the tokenization of the TextAnalysis module.  You can do this by creating a tokenized corpus that takes account of a specified orthography, and constructing a TextAnalysis.Corpus from this source.","category":"page"},{"location":"example/profiling/#Profiling-a-corpus-2","page":"Profiling a corpus","title":"Profiling a corpus","text":"","category":"section"},{"location":"example/profiling/","page":"Profiling a corpus","title":"Profiling a corpus","text":"lexical metrics\nmorphological metrics","category":"page"},{"location":"#CitableCorpusAnalysis.jl","page":"Overview","title":"CitableCorpusAnalysis.jl","text":"","category":"section"},{"location":"","page":"Overview","title":"Overview","text":"Tokenize and analyze a citable text corpus.","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"There are many ways to model a text corpus.  CitableCorpusAnalysis integrates the models from these Julia modules:","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"Corpus in TextAnalysis\nCitableTextCorpus in CitableCorpus","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"It also introduces a further model, the AnalyticalCorpus.","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"warning: Warning\nThe CitableCorpusAnalysis module is in very early stages of development, and is intended for experimental use.","category":"page"},{"location":"#Overview","page":"Overview","title":"Overview","text":"","category":"section"},{"location":"","page":"Overview","title":"Overview","text":"An AnalyticalCorpus has three components:","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"a citable corpus of texts (a CitableText.CitableTextCorpus)\nan orthographic system that can validate orthography and tokenize a citable text (an Orthography.OrthographicSystem)\na citable parser, that analyses citable tokens in terms of citable lexemes and morphological or other data (a CitableParserBuilder.CitableParser)","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"Functions working an AnalyticalCorpus can tokenize a corpus, analyze its tokens with a CitableParser, and can apply the corpus analytical functions of a TextAnalysis.Corpus to any citable text content.","category":"page"},{"location":"#Example-pages","page":"Overview","title":"Example pages","text":"","category":"section"},{"location":"","page":"Overview","title":"Overview","text":"The following pages walk through examples using a small corpus comprising all the extant versions of the Gettysburg address.  We will tokenize it with a simple ASCII tokenizer included in the Orthography module, and will parse it with a custom GettysburgParser built for this demo. (Its construction is documented in the appendix to these pages, and illustrates one simple way to build an English-language parser by wrapping the Python NLTK POS tagger.)","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"using CitableCorpusAnalysis\nusing CitableCorpus\nusing Orthography\n\ncorpus = corpus_fromurl(\"https://raw.githubusercontent.com/neelsmith/CitableCorpusAnalysis.jl/main/test/data/gettysburg/gettysburgcorpus.csv\", \"|\")\northography = Orthography.simpleAscii()\nparser = CitableCorpusAnalysis.gettysburgParser()\nacorpus = AnalyticalCorpus(corpus, orthography, parser)\ntypeof(acorpus)\n\n# output\n\nAnalyticalCorpus","category":"page"},{"location":"man/api/#API-Documentation","page":"API documentation","title":"API Documentation","text":"","category":"section"},{"location":"man/api/#Types","page":"API documentation","title":"Types","text":"","category":"section"},{"location":"man/api/","page":"API documentation","title":"API documentation","text":"AnalyticalCorpus","category":"page"},{"location":"man/api/#CitableCorpusAnalysis.AnalyticalCorpus","page":"API documentation","title":"CitableCorpusAnalysis.AnalyticalCorpus","text":"Essential components of an analytical corpus.\n\nIts contents must be citable, in a defined orthography, and tokens defined by that orthography must be parseable.\n\n\n\n\n\n","category":"type"},{"location":"man/api/#Exported-functions","page":"API documentation","title":"Exported functions","text":"","category":"section"},{"location":"man/api/","page":"API documentation","title":"API documentation","text":"tacorpus\ntalexicon\ndtmatrix","category":"page"},{"location":"man/api/#CitableCorpusAnalysis.tacorpus","page":"API documentation","title":"CitableCorpusAnalysis.tacorpus","text":"Create a TextAnalysis.Corpus from a CitableTextCorpus.\n\ntacorpus(c)\n\n\n\n\n\n\n","category":"function"},{"location":"man/api/#CitableCorpusAnalysis.talexicon","page":"API documentation","title":"CitableCorpusAnalysis.talexicon","text":"Create a lexicon (a Dict of tokens to counts) from a CitableTextCorpus using the lexicon function of the TextAnalysis module.\n\ntalexicon(c)\n\n\n\n\n\n\n","category":"function"},{"location":"man/api/#CitableCorpusAnalysis.dtmatrix","page":"API documentation","title":"CitableCorpusAnalysis.dtmatrix","text":"Creates the document-term matrix for a CitableTextCorpus in dense matrix  format.\n\ndtmatrix(c)\n\n\nNote that this relies on the dictionary created by TextAnalysis.lexicon().\n\n\n\n\n\n","category":"function"},{"location":"example/parser/#Appendix:-a-note-on-the-citable-parser","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"","category":"section"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"The GettysburgParser used in this demonstration works with a simple dictionary of tokens to POS tags.  The dictionary was constructed by wrapping the Python NLTK POS tagger with a Julia function. This page documents how to do that so that you can generically apply the NTLK tagger to a list of tokens from Julia.","category":"page"},{"location":"example/parser/#Python-prerequisites","page":"Appendix: a note on the citable parser","title":"Python prerequisites","text":"","category":"section"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"You need to have Python, with nltk.","category":"page"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"pip install nltk","category":"page"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"Then start python, and at the python prompt,","category":"page"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"import nltk\nnltk.download","category":"page"},{"location":"example/parser/#A-Julia-wrapper","page":"Appendix: a note on the citable parser","title":"A Julia wrapper","text":"","category":"section"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"# If you're in a system with python accessible\n# and the nltk module installed, you can actually\n# execute all the code blocks on this page.\nrepo = pwd() |> dirname  |> dirname |> dirname\ngburgfile = repo * \"/test/data/gettysburg/gettysburgcorpus.csv\"\nusing CitableCorpus\ncorpus = corpus_fromfile(gburgfile, \"|\")","category":"page"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"note: Note\nIn the extra directory, the script engpos.jl does everything documented here, and can be run from the command line from the root of the repository with julia --project=extra/ extra/engpos.jl","category":"page"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"In Julia, you can make the NLTK module's tag function available like this:","category":"page"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"using Conda\nConda.add(\"nltk\")\nusing PyCall\n@pyimport nltk.tag as ptag","category":"page"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"Now if we have a citable corpus named corpus, we can use the TextAnalysis functions to extract a unique lexicon, and apply the NLTK tagger to it.","category":"page"},{"location":"example/parser/","page":"Appendix: a note on the citable parser","title":"Appendix: a note on the citable parser","text":"using CitableCorpusAnalysis\nusing TextAnalysis\ntacorp = tacorpus(corpus)\n\ntkns = []\nfor doc in tacorp.documents\n    push!(tkns, tokens(doc))\nend\ntknlist = tkns |> Iterators.flatten |> collect |> unique\ntagged = ptag.pos_tag(tknlist)","category":"page"}]
}