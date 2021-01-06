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

if (!file.exists("water")){
  dir.create("water")
}

water <- get_data(par = "water",date = Sys.Date())
saveRDS(water,paste0("water/",Sys.time(),".rds"))



