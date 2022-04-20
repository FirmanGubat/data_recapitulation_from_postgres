#Package
library(RPostgres)
library(DBI)
library(dplyr)
library(dbplyr)
library(xlsx2dfs)

con <- dbConnect(RPostgres::Postgres()
                 , host='host'
                 , port='port'
                 , dbname='database_name'
                 , user='username'
                 , password='password'
)

x = DBI::dbListObjects(con, DBI::Id(schema = 'your_schema'))
v = lapply(x$table, function(x) slot(x, 'name'))
d = as.data.frame(do.call(rbind, v))

df=data.frame()
for(i in 1:nrow(d)) {
  judul_dataset <- paste0(d$table[i])
  atribute <- paste0(colnames(tbl(con, in_schema("your_schema", d$table[i]))))
  data <- data.frame(judul_dataset,atribute)
  df <- as.data.frame(rbind(df,data))
  print(df)
}

write.xlsx(df,"path\\name_file.xlsx")
