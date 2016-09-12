# ----get data----
conn <- dbConnect(MySQL(),dbname="shouhuan_origin",username="root",password="Psy!",host="localhost",port=3306)
on.exit(dbDisconnect(conn))

#编码问题
dbSendQuery(conn,"set character_set_results=gb18030;")
# dbSendQuery(conn,'set character set gbK')
dbSendQuery(conn,'set character set gb18030')

#测试是否中文乱码
dbListTables(conn)
dbGetQuery(conn,"SELECT * FROM `用户绑定的手环` LIMIT 6;")
