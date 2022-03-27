
#getwd()
#setwd()

#zad2
install.packages("httr")
install.packages("jsonlite") 

#zad2
library(httr)
library(jsonlite)
#require(httr)

endpoint <- "https://api.openweathermap.org/data/2.5/weather?q=Warszawa&appid=1765994b51ed366c506d5dc0d0b07b77&units=metric"
#httr::GET
getWeather<- GET(endpoint)
weatherText<- content(getWeather,"text")
View(weatherText)
weatherJSON<-fromJSON(weatherText)
wdf<- as.data.frame(weatherJSON)
View(wdf)

#Zad1 
?read.csv
df <- read.csv("./autaSmall.csv",fileEncoding = "UTF-8")
View(head(df,5))

#3.Napisz funckję zapisującą porcjami danych plik csv do tabeli  w SQLite
#Mały przykład - autaSmall.csv
#a<-1

readToBase<-function(filepath,dbConn,tablename,size,sep=",",header=TRUE,delete=TRUE){
  ap<- !delete
  ov<- delete
  fileConnection<-file(description = filepath,open="r")
  df<- read.table(fileConnection,nrows = size,header = header,fill=TRUE,sep=sep) 
  dbWriteTable(con, tablename, df,append=ap,overwrite=ov)
  myColNames<- names(df)
  repeat{
    if( nrow(df)==0){
      dbDisconnect(con)
      close(fileConnection)
      break 
    }
    df<- read.table(fileConnection,nrows = size,col.names = myColNames,fill=TRUE,sep=sep)
    dbWriteTable(con,tablename, df,append=TRUE,overwrite=FALSE)
  }
} 

?read.table

df <- read.table('autaSmall.csv', sep=',', header=TRUE, fileEncoding='utf-8')
str(df)

install.packages( c("DBI","RSQLite") )
library(DBI)
library(RSQLite)

#DBI::dbWriteTable()
dbWriteTable()
?dbWriteTable
#"auta.sqlite"

?file
con <- dbConnect( SQLite(), "auta.sqlite")
readToBase("./autaSmall.csv",con,"tabela",size=1000)
#https://sqlitebrowser.org/

con <- dbConnect( SQLite(), "auta.sqlite")
res<-dbSendQuery(con,"SELECT * FROM tabela")
zBazy<-dbFetch(res)
dbClearResult(res)
dbDisconnect(con)

fromJSON("http://54.37.136.190:8000/row?id=10000000")
