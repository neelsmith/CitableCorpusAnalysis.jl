# Profiling a corpus

## Using a Vector of `AnalyzedToken`s

The `analyzecorpus` function yields a list of `AnalyzedToken`s.  We can derive metrics for our corpus from this list including:


- lexical metrics
    - the lexical ambiguity of the corpus
    - the lexical histogram of the corpus
    - measures of the coverage of the parser for the corpus
- morphological metrics
    - the morphological ambiguity of the corpus
    - the morphological histogram of the corpus


## Interoperating with Julia `TextAnalysis.Corpus`

You can generate a `TextAnalysis.Corpus` from a `CitableCorpus`.

Sometimes, you'll want to preprocess the original `CitableCorpus` so as not to depend on the tokenization of the `TextAnalysis` module.  You can do this by creating a tokenized corpus that takes account of a specified orthography, and constructing a `TextAnalysis.Corpus` from this source.


