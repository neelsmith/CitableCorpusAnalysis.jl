

![build](https://github.com/neelsmith/CitableCorpusAnalysis.jl/actions/workflows/Documentation.yml/badge.svg)


# CitableCorpusAnalysis.jl

A Julia module to work with multiple models of a text corpus.

See [the documentation](https://neelsmith.github.io/CitableCorpusAnalysis.jl/stable/).

## Current focus

The current focus of work on this module is to profile a citable corpus.  This includes measuring:

### Size of corpus, coverage of analysis

- [ ] total number of lexical tokens in corpus (*size of corpus*)
- [ ] number of *distinct* lexical tokens in corpus (and ratio to total size) (the *token vocabulary*)
- [ ] number (and proportion) of lexical tokens parsed by analyzer (*coverage of corpus*)
- [ ] number (and proportion) of distinct lexical  tokens parsed by analyzer (*coverage of token vocabulary*) 



### Size of lexicon, formal and lexical complexity

- [ ] number of lexemes recognized (*lexicon* of the corpus)
- [ ] proportion of lexemes to total tokens parsed (*lexical density or complexity of the corpus*)
- [ ] proportion of lexemes to distinct tokens parsed (*lexical density  or complexity of token vocabulary*)
- [ ] number of distinct forms related to lexemes, distinct tokens, and total tokens  (*morphological complexity* of lexicon, token vocabulary and corpus)
- [ ] number (proportion) of total tokens that are morphologically ambiguous by token vocabulary and corpus  (*formal ambiguity* of token vocabulary and corpus)
- [ ] number (proportion) of total tokens that are lexically ambiguous by token vocabulary and corpus (*lexical ambiguity* of token vocabulary and corpus)
