EMOC_tm<-fread('EMOC_tm.csv',encoding ="UTF-8")
EMOC_tm<-EMOC_tm[排除==""]

wk = worker()
EMOC_tm_seg<-segment(EMOC_tm[,轉院原因分析], wk)
ap.corpus <- Corpus(DataframeSource(data.frame(as.character(EMOC_tm_seg))))


tdm <- TermDocumentMatrix(ap.corpus, control = list(wordLengths = c(2, Inf)))
dtm <-DocumentTermMatrix(ap.corpus, control = list(wordLengths = c(2, Inf)))
m1 <- as.matrix(tdm)
v <- sort(rowSums(m1), decreasing = TRUE)
d <- data.frame(word = names(v), freq = v)
pal2 <- brewer.pal(8,"Dark2")

wordcloud(d$word, d$freq, min.freq = 5, random.order = T, ordered.colors = F, rot.per=.15, colors=pal2)

wordcloud(ap.corpus, max.words =1000 , random.order = T)
