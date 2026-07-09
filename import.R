# Title: Import IPA hémato
# author: Philm
# date: 06/07/26
  
  
  
  
library("tidyverse")
library("tm")

tt <- NULL
prof <- c("IDE en consultation", "Assistante sociale", 
          "Cadre supérieure de santé", "Pharmacien",
          "Pharmacien", "Cadre faisant fonction",
          "Hématologue", "Secrétaire médicale")

mesmots <- c("cest", "ça", "donc", "fait", "parce", "peut","quand",
             "être", "puis", "aussi", "plus", "fois", "là", "sous", "après",
             "peux", "alors", "beaucoup", "comme", "quil", "faut", "voilà",
             "vont","oui", "peutêtr", "ben", "peu", "tout", "car", "quelqu",
             "puisqu","ell","vraiment", "évidem", "non","jai", "sai", "déjà",
             "tous", "avoir","estc", "autr", "...", "quon", "ouai", "entr")


for(nt in 1:8){
nomtxt <- paste0("datas/entretien",nt,".txt")
texte <- readr::read_file(nomtxt)
docs <- Corpus(VectorSource(texte))
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, toSpace, ",")
docs <- tm_map(docs, toSpace, "’")
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, removeWords, stopwords("fr"))
docs <- tm_map(docs, removeWords, mesmots)
docs <- tm_map(docs, stemDocument)


profession <- prof[nt]
ll <- c(nt,profession,docs)
tt <- rbind(tt,ll)
}

tt <- as_tibble(tt)
names(tt) <- c("id", "profession", "texte")

