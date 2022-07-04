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

