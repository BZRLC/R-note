de_dupli <- function(data,jiebar) {
  
  # 先group_by 然后合并 HDMC & HDNR,排序
  shsj_by <- data %>% group_by(HDMC,HDNR) %>% 
    summarise(N=n()) %>% ungroup() %>% 
    mutate(HB = paste0(HDMC,HDNR)) %>%
    arrange(HB)
  
  #总行数
  all_n <- nrow(shsj_by)
  
  # ---去标点----
  x <- shsj_by["HB"]
  
  df_biaodian <- data_frame(biaodian =apply(x,1,FUN =  function(x) {
    result <- str_replace_all(x,pattern = "[[:punct:]]","") %>% 
      str_replace_all(pattern = "[[:space:]]","")
    return(result)
  }))
  
  #数量
  biaodian_n <- nrow(unique(df_biaodian))
  
  # ---过滤----
  ## 无意义词
  filter_words <- readLines("filter_words.utf8",encoding = "UTF-8")
  pt <- str_c(filter_words,collapse = "|")
  
  df_guolv <- data_frame(guolv = apply(df_biaodian,1,FUN = function(x) {
    result <- str_replace_all(x,pt,"")
    return(result)
  }))
  
  #数量
  guolv_n <- nrow(unique(df_guolv))
  
  # ---提取关键词----
  ##取关键词
  simhasher = jiebar
  
  ##用guolv后的结果
  df_keywords <- data_frame(keywords = apply(df_guolv, 1, function(x){
    simhasher[x]$keyword %>% str_c(collapse="")}
  ))
  keywords_n <- nrow(unique(df_keywords))
  
  # ---系统聚类-----
  hash <- data_frame(simhash = apply(df_guolv, 1, function(x) simhasher[x]$simhash))
  
  # 计算hamming距离
  hash_bin <- data_frame(bin=apply(hash,1,tobin))
  sim_dist <- stringdist::stringdistmatrix(hash_bin$bin,method="hamming")
  
  ## "ward.D2"
  hc_w <- fastcluster::hclust(sim_dist,method = "ward.D2")
  hc_w_result <- data_frame(hc_result = cutree(hc_w,h = 3))
  hc_n <- nrow(unique(hc_w_result))
  
  result_count <- data_frame(原始= all_n/all_n,去标点=biaodian_n/all_n, 过滤=guolv_n/all_n,
                               关键词=keywords_n/all_n, 聚类=hc_n/all_n)
  result_all <- bind_cols(shsj_by,df_biaodian) %>% 
    bind_cols(df_guolv) %>% 
    bind_cols(df_keywords) %>% 
    bind_cols(hc_w_result) %>% 
    arrange(hc_result)
  return(list(result_all,result_count))
} 
