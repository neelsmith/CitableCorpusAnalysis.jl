# Modelling a text corpus


## Background

From `CitableText` and `CitableCorpus`:

- load a corpus
- retrieve passages


Some key functions from libraries implementing `Orthography` and `CitableParser`:

- orthography: validation
- orthography: tokenization
- morphological analysis

## Interoperating with Julia `TextAnalysis.Corpus`

- generate a `TextAnalysis.Corpus` from a `CitableCorpus`

Sometimes, you'll want to preprocess the original `CitableCorpus` so as not to depend on the tokenization of the `TextAnalysis` module.  You can do this by creating a tokenized corpus that takes account of a specified orthography, and constructing a `TextAnalysis.Corpus` from this source.

## Profiling a corpus

- lexical metrics
- morphological metrics