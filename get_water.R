#------------------------Custom get_occ function-------------
get_data <- function(par,date){
  par <- match.arg(par, c("water","rain"))
  web <-"http://www.ynswj.cn/webapi/api/v1"
  switch (par,
          water = {
            url = paste0(web,"/water?")
            x <- jsonlite::fromJSON(url,flatten=TRUE)
            x <- x[["data"]]
            print(paste0(as.POSIXlt(Sys.time(), "Asia/Shanghai")," is OK !"))
          },
          rain = {
            url = paste0(web,"/rain?")
            x <- jsonlite::fromJSON(url,flatten=TRUE)
            x <- x[["data"]]
            print(paste0(as.POSIXlt(Sys.time(), "Asia/Shanghai")," is OK !"))
          }
  )
  return(x)
}

if (!file.exists(paste0("water/",as.POSIXlt(Sys.Date(), "Asia/Shanghai")))){
  dir.create(paste0("water/",as.POSIXlt(Sys.Date(), "Asia/Shanghai")))
}
water <- get_data(par = "water",date = as.POSIXlt(Sys.Date(), "Asia/Shanghai"))
path <- paste0("water/",as.POSIXlt(Sys.Date(), "Asia/Shanghai"),"/",as.POSIXlt(Sys.time(), "Asia/Shanghai"),".rds")
saveRDS(water,path)
