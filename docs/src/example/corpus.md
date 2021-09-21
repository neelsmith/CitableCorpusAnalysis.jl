# Analyzing a text corpus


## Summary

We start with a corpus citable by CTS URN. In these examples, we'll work with a citable corpus of [the five extant versions of the Gettysburg Address](http://www.abrahamlincolnonline.org/lincoln/speeches/gettysburg.htm).  We will then construct an `AnalyticalCorpus` that matches this citable corpus with an orthography and a parser.  With this in hand, we can create a full, morphologically aware analysis of each token in the corpus with a single function call.


### Load the source corpus

We can load the source data into the `CitableTextCorpus` model from a URL.  The `corpus_cex` function works on string data, so we will use standard Julia methods to load a String from the URL.

```jldoctest corpus
using CitableCorpus
using HTTP
corpusurl = "https://raw.githubusercontent.com/neelsmith/CitableCorpusAnalysis.jl/dev/test/data/gettysburg/gettysburgcorpus.cex"
corpus = HTTP.get(corpusurl).body |> String  |> corpus_fromcex
typeof(corpus)

# output

CitableTextCorpus
```

### Aside: working with selections

You can use any of the functions of the `CitableCorpus` module to work with selections from a citable corpus.  E.g., you can retrieve selected passages, or select a complete document from the corpus

```jldoctest corpus
using CitableText
rangeUrn = CtsUrn("urn:cts:citedemo:gburg.nicolay.v2:1-2")
rangePassages = retrieve(rangeUrn, corpus)

# output

2-element Vector{Any}:
 <urn:cts:citedemo:gburg.nicolay.v2:1> Four score and seven years ago our fathers brought forth, upon this continent, a new nation, conceived in liberty, and dedicated to the proposition that all men are created equal.
 <urn:cts:citedemo:gburg.nicolay.v2:2> Now we are engaged in a great civil war, testing whether that nation, or any nation so conceived, and so dedicated, can long endure. We are met on a great battle field of that war. We come to dedicate a portion of it, as a final resting place for those who died here, that the nation might live. This we may, in all propriety do.
```

```jldoctest corpus
hayUrn = CtsUrn("urn:cts:citedemo:gburg.hay.v2:")
hay = document(hayUrn, corpus)

# output

"Citable document <urn:cts:citedemo:gburg.hay.v2:> 4 citable passages"
```

!!! note

    See the [documentation for the `CitableCorpus` module](https://cite-architecture.github.io/CitableCorpus.jl/stable/) to learn more about manipulating citable documents and corpora.



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

The `analyzecorpus` function requires an `AnalyticalCorpus` as an argument. It first creates a tokenized edition, then analyses each token. It returns a Vector of pairings that associate a `CitablePassage` (from the `CitableText` module) with a Vector of `Analysis` objects (from the `CitableParserBuilder` module), where each `CitablePassage` is a node in the tokenized edition.

Our corpus has a total of 1506 tokens, so the result will have 1506 pairings of tokens with analysis vectors.

```jldoctest corpus
analyses = analyzecorpus(acorpus, parser.data)
length(analyses)

# output

1506
```

We can check that the number of analyzed tokens matches the number of tokens in our corpus.


```jldoctest corpus

```

### Additional arguments

This may be followed by an optional `data` parameter that will passed along to the parsing functions it applies.  Here, by passing along a dictionary that the parsing function can use, we can get better performance that loading the entire dictionary for each individual parse.

```jldoctest corpus
fastanalyses = analyzecorpus(acorpus, parser.data)
length(fastanalyses)

# output

1506
```

### Serializing the analyses

The result of analyzing a corpus is a list of pairs: each `CitablePassage` in the corpus is paired with a (possibly empty) Vector of `Analysis` objects.  This is serialized as a flat list of `CitablePassage` plus one `Analysis` object, allowing each `CitablePassage` to be repeated as many times as there are analyses for that node.
