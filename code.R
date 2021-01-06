#------------------------------
need.packs <- c("jsonlite")
#-----------------------START-------------------------------
#--------------Packages you want to install-----------------------
has <- need.packs %in% row.names(installed.packages())
if(any(!has))install.packages(need.packs[!has], repos = '')
lapply(need.packs, require, character.only = TRUE)

#------------------------Custom get_occ function-------------
get_data <- function(par,date,output){
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
  saveRDS(x,paste0(output,Sys.time(),".rds"))
}

if (!file.exists("water")){
  dir.create("water")
}


if (!file.exists("rain")){
  dir.create("rain")
}


get_data(par = "water",date = Sys.Date(),output = "water/")

get_data(par = "rain",date = Sys.Date(),output = "rain/")






