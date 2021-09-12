# Analyzing a text corpus


## Summary

We start with a corpus citable by CTS URN. In these examples, we'll work with a citable corpus of the extant versions of the Gettysburg Address.  We will then construct an `AnalyticalCorpus` that matches this citable corpus with an orthography and a parser.  With this in hand, we can create a full, morphologically aware analysis of each token in the corpus with a single function call.


### Load the source corpus

We can load the source data into the `CitableTextCorpus` model from a URL.

```jldoctest corpus
using CitableCorpus
corpusurl = "https://raw.githubusercontent.com/neelsmith/CitableCorpusAnalysis.jl/main/test/data/gettysburg/gettysburgcorpus.cex"
corpus = corpus_fromurl(corpusurl, "|")
typeof(corpus)

# output

CitableTextCorpus
```

### Retrieve passages


TBA


## Constructing an `AnalyticalCorpus`

### Orthography

The `Orthography` module includes a simple ASCII orthography that we can use with our Gettsyburg corpus.

```jldoctest corpus
using Orthography
orthography = simpleAscii()
typeof(orthography) |> supertype

# output

OrthographicSystem
```

### Morphology

The `CitableCorpusAnalysis` module includes an implementation of the `CitableParser` abstraction that can parse tokens in the Gettysburg Address to their corresponding Penn treebank POS code.  (For details on how the parser was constructed, see the appendix to this documentation.)

```jldoctest corpus
using CitableCorpusAnalysis
parser = CitableCorpusAnalysis.gettysburgParser()
typeof(parser) |> supertype

# output

CitableParserBuilder.CitableParser
```

### The analytical corpus

Our analytical corpus associates these three components.

```jldoctest corpus
acorpus = AnalyticalCorpus(corpus, orthography, parser)
typeof(acorpus)

# output

AnalyticalCorpus
```

## The analyses

The `analyzecorpus` function requires an `AnalyticalCorpus` as an argument. It returns a Vector of pairings that associate a `CitableNode` (from the `CitableText` module) with a Vector of `Analysis` objects (from the `CitableParserBuilder` module).

```jldoctest corpus
analyses = analyzecorpus(acorpus)
length(analyses)

# output

1471
```


### Additional arguments

This may be followed by a variable argument list that will passed along to the parsing functions it applies. 