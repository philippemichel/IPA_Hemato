
tt$texte <-  str_replace_all(tt$texte,"’", " ") 
  tt$texte <-  str_replace_all(tt$texte,"…", " ") 
    tt$texte <-  str_replace_all(tt$texte,"'", " ")
  
zz <- tt |> 
tidytext::unnest_tokens(output="mots",
                        input=texte,
                        token="words") |> 
  anti_join(proustr::proust_stopwords(),by=c("mots"="word")) |> 
 # anti_join(as_tibble(mesmots),by=c("mots"="value")) |> 
  anti_join(get_stopwords("fr"),by=c("mots"="word")) |> 
  mutate(mots = wordStem(mots, language = "fr"))

zz |> 
  count(mots, sort = TRUE) |> 
  head(50) |> 
  ggplot() +
  aes(label = mots, size= n, color = n) +
  geom_text_wordcloud(grid_size = 20) +
  scale_size_area(max_size = 20) +
  scale_color_viridis_c()






 zz |> 
   count(mots, sort = TRUE) |> 
   head(100) |> 
    ggplot() +
    aes(label = mots, size= n, color = n) +
    geom_text_wordcloud(grid_size = 4) +
    scale_size_area(max_size = 20) +
    scale_color_viridis_c()+
    facet_grid(~profession)







aa <- zz |> 
  mutate(across(is.character, as.factor)) |>
  pivot_wider(names_from = profession, values_from = mots,
                  values_fn = count)
