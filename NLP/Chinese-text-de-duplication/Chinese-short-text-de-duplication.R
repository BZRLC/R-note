library(dplyr)
library(readr)
library(jiebaR)
library(stringdist)
library(stringr)
library(tidyr)
library(ggplot2)

#从数据库中取数据
library(RODBC)

mycon <- odbcConnect("DATASERVER",uid="test",pwd="Psy!")

#主题活动表 zthd
# sql1 <- "SELECT XN,XQ,XXDM,XXJC,NJDM,BJXH,TYLX,HDMC FROM [SJJH_N_20151028].[dbo].[j_yw_czty_zthd] where xn = 2014 and xxjc = '浦江二中'"
# tst1 <- sqlQuery(mycon,sql1,stringsAsFactors=F)
odbcClose(mycon)


source("de_dupli.R",encoding = "UTF-8")

xuexiao_names <- read_table("xuexiao_names.txt")

simhasher2 = worker(type="simhash",topn = 2)

ff <- function(xn,xxdm,jiebar) {
  mycon<- RODBC::odbcConnect("DATASERVER",uid="test",pwd="Psy!")
  sql2 <- paste0("SELECT XN, XQ, XXDM, NJDM, BJXH, SJLX, HDMC, HDNR FROM [SJJH_N_20151028].[dbo].[j_yw_czty_shsj] WHERE XN=",xn,"AND XXDM =",xxdm)
  shsj_raw <- RODBC::sqlQuery(mycon,sql2,stringsAsFactors=F)
  RODBC::odbcClose(mycon)
  shsj <- tbl_df(shsj_raw)
  result <- try(de_dupli(shsj,jiebar))
  if(class(result)=="try-error"){
    result <- NULL
    print(paste0("error:",xxdm))
  }
  return(result)
}


xx_all <- sort(xuexiao_names$xxdm)

xx <- NULL
lst <- NULL
for (i in 1:length(xx_all)){
  gc()
  xxdm <- xx_all[i]
  tmp <- ff(2012,xxdm,simhasher2)
  lst[[i]] <- tmp[[1]]
  xx <- bind_rows(xx,tmp[[2]])
  print(paste0("ok:",xxdm))
}


which(xx_all=="1010")
xxx_all <- xx_all[-60]
  
fenlei_all <- data_frame(xxdm = xxx_all) %>% bind_cols(xx)

write_csv(fenlei_all,"所有学校结果.csv")


# kemeans 快速分类
cl4 <- fenlei_all %>% bind_cols(data_frame(km4 = km4$cluster))

cl_by <- cl4 %>% group_by(km4) %>% summarise(原始=mean(原始),去标点=mean(去标点),
                                      过滤=mean(过滤),关键词=mean(关键词),
                                      聚类=mean(聚类))

# ----ggplot----


g_cl_by <- gather(cl_by,"steps","ratio",2:6)

pp <- data_frame(km4=1:4,col=c("C","D","A","B"))
  
df <- g_cl_by %>% left_join(pp,by="km4") %>% select(-1)
df_by <- select(df,col,everything()) %>% spread(steps,ratio)
write_csv(df_by,"学校模型归纳.csv")

windowsFonts(myfont=windowsFont("等线"))


#彩色
ggplot(df,aes(steps,ratio,group=col,colour=col)) +
  geom_line(size=1.25) +
  labs(title="学校分类模型",colour="学校类型")+
  scale_x_discrete(limits=c("原始","去标点", "过滤", "关键词", "聚类"))+
  theme_bw()+
  theme(text=element_text(family = "myfont"),
        title=element_text(family = "myfont",face="bold"))

eng <-read_csv(c("原始, raw text
去标点 , drop punctuation
过滤, drop stop-words 
关键词, keywords
聚类, cluster"),locale=locale(encoding="gbk"),col_names=F)

df <- df %>% left_join(eng,by=c("steps"="X1"))

windowsFonts(myfont=windowsFont("Arial"))
#黑白
ggplot(df,aes(X2,ratio,group=col,linetype=col)) +
  geom_line(size=1.25) +
  labs(linetype="School\nCluster",x="Steps",y="Percentage")+
  scale_x_discrete(limits=c("raw text","drop punctuation", "drop stop-words", "keywords", "cluster"))+
  theme_bw()+
  theme(text=element_text(family = "myfont"),
        title=element_text(family = "myfont",face="bold"))+
  scale_linetype_manual(values=c(1,2,3,6))+
  coord_cartesian(expand = F)


ggsave("分类高清.png",width = 8,height = 4.5,dpi = 600)
ggsave("分类低清.png",width = 8,height = 4.5,dpi = 300)

ggplot(df,aes(steps,ratio,group=col,linetype=col)) +
  geom_line(size=2) +
  labs(title="学校分类模型",colour="学校类型")+
  scale_x_discrete(limits=c("原始","去标点", "过滤", "关键词", "聚类"))+
  theme(text=element_text(family = "myfont"),
        title=element_text(family = "myfont",face="bold")) +
  facet_wrap(~col,nrow = 2)+
  theme_bw()

ggsave("分类-facet_wrap.png",width = 6,height = 4,dpi = 300)

ggplot(df,aes(steps,ratio,group=col,colour=col)) +
  geom_line(size=2) +
  labs(title="学校分类模型",colour="学校类型")+
  scale_x_discrete(limits=c("原始","去标点", "过滤", "关键词", "聚类"))+
  theme(text=element_text(family = "myfont"),
        title=element_text(family = "myfont",face="bold")) +
  facet_grid(~col)

ggsave("分类-facet_grid.png",width = 8,height = 4.5,dpi = 300)
