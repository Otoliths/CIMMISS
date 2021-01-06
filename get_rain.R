#------------------------Custom get_occ function-------------
get_data <- function(par,date){
  par <- match.arg(par, c("water","rain"))
  web <-"http://www.ynswj.cn/webapi/api/v1"
  switch (par,
          water = {
            url = paste0(web,"/water?")
            x <- jsonlite::fromJSON(url,flatten=TRUE)
            x <- x[["data"]]
            cat(Sys.time()," is OK !")
          },
          rain = {
            url = paste0(web,"/rain?")
            x <- jsonlite::fromJSON(url,flatten=TRUE)
            x <- x[["data"]]
            cat(Sys.time()," is OK !")
          }
  )
  return(x)
}

if (!file.exists(paste0("rain/",Sys.Date()))){
  dir.create(paste0("rain/",Sys.Date()))
}
rain <- get_data(par = "rain",date = Sys.Date())
path <- paste0("rain/",Sys.Date(),"/",Sys.time(),".rds")
saveRDS(rain,path)
