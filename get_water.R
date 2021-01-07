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


#get_water <- function(date){
#  seq <- strptime(paste0(as.Date(date)-1," 23:30:00"),"%Y-%m-%d %H:%M:%S")+3600*0:24
#  seq <- gsub(" ","T",seq)
#  x <- lapply(1:24, function(i){
#    url <- paste0("http://www.ynswj.cn/webapi/api/v1/water?extra=area&itm=1&area_code=530000&no_data_visible=false&time=[",seq[i],",",seq[i+1],"]")
#    d1 <- jsonlite::fromJSON(url)
#  })
#  return(x)
#}

#if (!file.exists("water")){
#  dir.create("water")
#}

#water <- get_water(date = as.POSIXlt(Sys.Date()-1, "Asia/Shanghai"))
#path <- paste0("water/",as.POSIXlt(Sys.Date()-1, "Asia/Shanghai"),".rds")
#saveRDS(water,path)
