#------------------------Custom get_occ function-------------
if (!requireNamespace("jsonlite", quietly = TRUE))
  install.packages("jsonlite",dependencies = T)

 get_data <- function(par,date){
  par <- match.arg(par, c("water","rain"))
  web <-"http://www.ynswj.cn/webapi/api/v1"
  switch (par,
          water = {
            url = paste0(web,"/water?")
            urls <- url(url,"rb")
            x <- jsonlite::fromJSON(urls,flatten=TRUE)
            x <- x[["data"]]
            print(paste0(as.POSIXlt(Sys.time(), "Asia/Shanghai")," is OK !"))
          },
          rain = {
            url = paste0(web,"/rain?")
            urls <- url(url,"rb")
            x <- jsonlite::fromJSON(urls,flatten=TRUE)
            x <- x[["data"]]
            print(paste0(as.POSIXlt(Sys.time(), "Asia/Shanghai")," is OK !"))
          }
  )
  return(x)
}
 
 if (!file.exists(paste0("rain/",as.POSIXlt(Sys.Date(), "Asia/Shanghai")))){
   dir.create(paste0("rain/",as.POSIXlt(Sys.Date(), "Asia/Shanghai")))
 }
 rain <- get_data(par = "rain",date = as.POSIXlt(Sys.Date(), "Asia/Shanghai"))
 path <- paste0("rain/",as.POSIXlt(Sys.Date(), "Asia/Shanghai"),"/",as.POSIXlt(Sys.time(), "Asia/Shanghai"),".rds")
 saveRDS(rain,path)

#get_rain <- function(date){
#  seq <- strptime(paste0(as.Date(date)-1," 23:30:00"),"%Y-%m-%d %H:%M:%S")+3600*0:24
#  seq <- gsub(" ","T",seq)
#  x <- lapply(1:24, function(i){
#    url <- paste0("http://www.ynswj.cn/webapi/api/v1/rain?extra=area&itm=1&area_code=530000&no_data_visible=false&time=[",seq[i],",",seq[i+1],"]")
#    d1 <- jsonlite::fromJSON(url)
#  })
#  return(x)
#}

#if (!file.exists("rain")){
#  dir.create("rain")
#}

#rain <- get_rain(date = as.POSIXlt(Sys.Date()-1, "Asia/Shanghai"))
#path <- paste0("rain/",as.POSIXlt(Sys.Date()-1, "Asia/Shanghai"),".rds")
#saveRDS(rain,path)

