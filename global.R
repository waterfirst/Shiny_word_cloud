
library(tm)
library(wordcloud)
library(memoise)
library(shinythemes)

summer <- "http://www.gutenberg.org/cache/epub/2242/pg2242.txt"
merchant <- "http://www.gutenberg.org/cache/epub/2243/pg2243.txt"
romeo <-"http://www.gutenberg.org/cache/epub/1112/pg1112.txt"

# The list of valid books
books <- list("A Mid Summer Night's Dream" = "summer",
               "The Merchant of Venice" = "merchant",
               "Romeo and Juliet" = "romeo")



# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(book) {
  # Careful not to let just any name slip in here; a
  # malicious user could manipulate this value.
  if (!(book %in% books))
    stop("Unknown book")
  
  book <- switch(book,
         "summer" = summer,
         "merchant" = merchant,
         "romeo" = romeo)
  
  # text <- readLines(sprintf("./%s.txt.gz", book),
  #                   encoding="UTF-8")
  
  text <- readLines(book,
                    encoding="UTF-8")
  
  myCorpus = Corpus(VectorSource(text))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords,
                    c(stopwords("SMART"), "thy", "thou", "thee", "the", "and", "but"))
  
  myDTM = TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))
  
  m = as.matrix(myDTM)
  
  sort(rowSums(m), decreasing = TRUE)
})




