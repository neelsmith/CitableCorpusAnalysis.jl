# CitableCorpusAnalysis.jl

> *Tokenize and analyze a citable text corpus*.

There are many ways to model a text corpus.  The `CitableCorpusAnalysis` module integrates two models from other Julia modules:

- `Corpus` in `TextAnalysis`
- `CitableTextCorpus` in `CitableCorpus`

One application of this integration is to allow LDA topic modeling (from the `TextAnalysis` package) to operate on a `CitableTextCorpus`.


`CitableCorpusAnalysis.jl` also introduces a further model, the `AnalyticalCorpus`.


## Overview of an analytical corpus


An `AnalyticalCorpus` has three components:

1. a citable corpus of texts (a `CitableText.CitableTextCorpus`)
2. an orthographic system that can validate orthography and tokenize a citable text (an `Orthography.OrthographicSystem`)
3. a citable parser, that analyses citable tokens in terms of citable lexemes and morphological or other data (a `CitableParserBuilder.CitableParser`)

Functions working with an `AnalyticalCorpus` can tokenize a corpus, analyze its tokens with a `CitableParser`, and can apply the corpus analytical functions of a `TextAnalysis.Corpus` to any citable text content.

## Example pages


The following pages walk through examples using a small corpus comprising all the extant versions of the Gettysburg address.  We will tokenize it with a simple ASCII tokenizer included in the `Orthography` module, and will parse it with a custom `GettysburgParser` built for this demo. (Its construction is documented in the appendix to these pages, and illustrates one simple way to build an English-language parser by wrapping the Python NLTK POS tagger.)



```@example
using CitableCorpusAnalysis
using CitableCorpus, CitableBase
using Orthography
using CitableParserBuilder

# Load a CitableCorpus from a URL:
url = "https://raw.githubusercontent.com/neelsmith/CitableCorpusAnalysis.jl/dev/test/data/gettysburg/gettysburgcorpus.cex"
corpus = fromcex(url,CitableTextCorpus,UrlReader)
# Instantiate an orthographic system and parser
orthography = Orthography.simpleAscii()
parser = CitableParserBuilder.gettysburgParser()
acorpus = AnalyticalCorpus(corpus, orthography, parser)
typeof(acorpus)
```

