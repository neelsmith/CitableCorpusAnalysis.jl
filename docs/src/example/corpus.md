# Analyzing a text corpus


## Summary

We start with a corpus citable by CTS URN. In these examples, we'll work with a citable corpus of [the five extant versions of the Gettysburg Address](http://www.abrahamlincolnonline.org/lincoln/speeches/gettysburg.htm).  We will then construct an `AnalyticalCorpus` that matches this citable corpus with an orthography and a parser.  With this in hand, we can create a full, morphologically aware analysis of each token in the corpus with a single function call.


### Load the source corpus

We can load the source data into the `CitableTextCorpus` model from a URL.  The `corpus_cex` function works on string data, so we will use standard Julia methods to load a String from the URL.

```@example corpus
using CitableBase, CitableCorpus
corpusurl = "https://raw.githubusercontent.com/neelsmith/CitableCorpusAnalysis.jl/dev/test/data/gettysburg/gettysburgcorpus.cex"
corpus = fromcex(corpusurl, CitableTextCorpus, UrlReader)
typeof(corpus)
```



## Constructing an `AnalyticalCorpus`

### Orthography

The `Orthography` module includes a simple ASCII orthography that we can use with our Gettsyburg corpus.

```@example corpus
using Orthography
orthography = simpleAscii()
typeof(orthography) |> supertype
```

### Morphology

The `CitableCorpusAnalysis` module includes an implementation of the `CitableParser` abstraction that can parse tokens in the Gettysburg Address to their corresponding Penn treebank POS code.  (For details on how the parser was constructed, see the appendix to this documentation.)

```@example corpus
using CitableParserBuilder
parser = CitableParserBuilder.gettysburgParser()
typeof(parser) |> supertype
```

### The analytical corpus

Our analytical corpus associates these three components.

```@example corpus
using CitableCorpusAnalysis
acorpus = AnalyticalCorpus(corpus, orthography, parser)
typeof(acorpus)
```

## The analyses

The `analyzecorpus` function requires an `AnalyticalCorpus` as an argument. It first creates a tokenized edition, then analyses each token. It returns a Vector of `AnalyzedToken`s, where each `CitablePassage` is associated with a (possibly empty) Vector of `Analysis` objects.


### Additional arguments

The `analyzecorpus` function allows an optional `data` parameter that will passed along to the parsing functions it applies.  In this example, the `GettysburgParser` can use a dictionary of analyses to get better performance, since it otherwise loads the entire dictionary for each individual parse.

```
analyses = analyzecorpus(acorpus; data = parser.data)
```
