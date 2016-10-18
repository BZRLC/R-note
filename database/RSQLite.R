library(readr)
library(readxl)
library(dplyr)
library(RSQLite)

# 通过dplyr src 连接数据库

mydb <- src_sqlite("E:/SQLite/database/yourdbname.db",create = T)
mydb

#直接导入的到R操作
tbl(mydb,"表名")

#选择 select
#过滤 filter
#排序 arrange
#更改 mutate

#group_by summarise

#join 

##转为tbl_df    collect()
##转为SQL 语句  explain()

## 写入表格  copy_to(mydb,"R中的表名",temporary = FALSE, indexes = 索引)



# 通过 https://github.com/rstats-db/RSQLite
# DBI 操作
library(DBI)
# Create an ephemeral in-memory RSQLite database
con <- dbConnect(RSQLite::SQLite(), "E:/SQLite/database/你的数据名字.db")

dbWriteTable(con, "mtcars", mtcars)

dbGetQuery(con, "SELECT * FROM mtcars")


cx <- "select * from mtcars"
dbGetQuery(con, cx)

####测试 ,不运行
test <- src_sqlite("D:/sqlite-db/test.db",create = T)

con <- dbConnect(RSQLite::SQLite(),"E:/R/R-3.3.1/library/RSQLite/db/datasets.sqlite")





devtools::install_github("rstats-db/RSQLite")

Creating a new database

To create a new SQLite database, you simply supply the filename to dbConnect():

mydb <- dbConnect(RSQLite::SQLite(), "my-db.sqlite")
dbDisconnect(mydb)
unlink("my-db.sqlite")
If you just need a temporary database, use either "" (for an on-disk database) or ":memory:" or "file::memory:" (for a in-memory database). This database will be automatically deleted when you disconnect from it.

mydb <- dbConnect(RSQLite::SQLite(), "")
dbDisconnect(mydb)

library(DBI)
# Create an ephemeral in-memory RSQLite database
con <- dbConnect(RSQLite::SQLite(), ":memory:")

dbListTables(con)
dbWriteTable(con, "mtcars", mtcars)
dbListTables(con)

dbListFields(con, "mtcars")
dbReadTable(con, "mtcars")

# You can fetch all results:
res <- dbSendQuery(con, "SELECT * FROM mtcars WHERE cyl = 4")
dbFetch(res)
dbClearResult(res)

# Or a chunk at a time
res <- dbSendQuery(con, "SELECT * FROM mtcars WHERE cyl = 4")
while(!dbHasCompleted(res)){
  chunk <- dbFetch(res, n = 5)
  print(nrow(chunk))
}
# Clear the result
dbClearResult(res)

# Disconnect from the database
dbDisconnect(con)
