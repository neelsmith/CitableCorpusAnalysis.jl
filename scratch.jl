using TextAnalysis
using Conda
Conda.add("nltk")
using PyCall
@pyimport nltk.tag as ptag


# Tokenize a document:
doc = StringDocument("In the beginning, God created the heavens and the earth.")
tkns = tokens(doc) # In TextAnalysis

parsed = ptag.pos_tag(tkns)

# Token values:
# https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html
println(join(parsed,"\n"))