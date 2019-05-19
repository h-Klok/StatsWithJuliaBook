using PyCall
TB = pyimport("textblob")

str =
"""Some people think that Star Wars The Last Jedi is an excellent movie,
with perfect, flawless storytelling and impeccable acting. Others
think that it was an average movie, with a simple storyline and basic
acting. However, the reality is almost everyone felt anger and
disappointment with its forced acting and bad storytelling."""

blob = TB.TextBlob(str)
[ i.sentiment for i in blob.sentences ]
