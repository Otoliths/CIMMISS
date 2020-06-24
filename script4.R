# if(!("jsonlite" %in% row.names(installed.packages())))
#   install.packages("jsonlite",dependencies = T)
# get <- function(i){
#   baseurl <- function()"http://api.data.cma.cn:8090/api?"
#   userId <- "5921014329184DMzs"
#   pwd <- "O6Ex76U"
#   timestart <- paste0(gsub("-","",as.Date(Sys.Date())-2),"000000")
#   timeend <- paste0(gsub("-","",Sys.Date()-1),"000000")
#   timeRange <- paste0("[",timestart,",",timeend,"]")
#   # ids <- read.csv("China_SURF_Station.csv")
#   China_SURF_Station <- read.csv("China_SURF_Station.csv")
#   yunnan <- subset(China_SURF_Station,China_SURF_Station$省份 == "云南")
#   tibet <- subset(China_SURF_Station,China_SURF_Station$省份 == "西藏")
#   ids <- rbind(yunnan,tibet)
#   staIDs <- paste(ids$区站号[i],collapse=",")
#   elements <- "Station_Id_C,Year,Mon,Day,Hour,PRS,PRS_Sea,PRS_Max,PRS_Min,TEM,TEM_Max,TEM_Min,RHU,RHU_Min,VAP,PRE_1h,WIN_D_INST_Max,WIN_S_Max,WIN_D_S_Max,WIN_S_Avg_2mi,WIN_D_Avg_2mi,WEP_Now,WIN_S_Inst_Max,tigan,windpower,VIS,CLO_Cov,CLO_Cov_Low,CLO_COV_LM"
#   url = paste(baseurl(), "userId=", userId, "&pwd=",pwd,"&dataFormat=json&interfaceId=getSurfEleByTimeRangeAndStaID&dataCode=SURF_CHN_MUL_HOR&timeRange=",
#               timeRange,"&staIDs=",staIDs,"&elements=",elements,sep = "")
#   db <- jsonlite::fromJSON(url, flatten=TRUE)
#   if(db$returnMessage == "Query Succeed"){
#     dir.create(paste0("data/",Sys.Date()-2))
#     path <- paste0("data/",Sys.Date()-2,"/",ids$区站号[i],"-",ids$省份[i],"-",ids$站名[i],".rds")
#     saveRDS(db,path)
#     cat(length(list.files(paste0("data/",Sys.Date()-2,"/"), full.names = TRUE)))
#   }
# }
# pbmcapply::pbmclapply(1:132,get,mc.cores = 2)
# cat(length(list.files(paste0("data/",Sys.Date()-2,"/"), full.names = TRUE)))

#rm(list = ls())
need.packs <- c("spocc","pbmcapply","rlist","scrubr","magrittr")
#-----------------------START-------------------------------
#--------------Packages you want to install-----------------------
has <- need.packs %in% row.names(installed.packages())
if(any(!has))install.packages(need.packs[!has], repos = '')
lapply(need.packs, require, character.only = TRUE)

#------------------------Custom get_occ function-------------
get_occ <- function(sp,dbsource,limit,month,mc.cores,group){
  if(length(sp) == 1){
    #month <- match.arg(month, choices = as.character(1:12))
    print(spocc::occ(query = sp, from = dbsource,limit = limit, gbifopts = list(month = month)))
    dat <- pbmcapply::pbmclapply(sp,mc.cores = mc.cores,function(query){
        spocc::occ2df(spocc::occ(query = query, from = dbsource, limit = limit, gbifopts = list(month = month)), what = "data")
      })
  }else{
    print(spocc::occ(query = sp, from = dbsource,limit = limit))
    dat <- pbmcapply::pbmclapply(sp,mc.cores = mc.cores,function(query){
      spocc::occ2df(spocc::occ(query = query, from = dbsource, limit = limit), what = "data")
    })
  }
  #dat <- rlist::list.stack(dat)
  dat <- dplyr::bind_rows(dat)
  dat$group <- rep(group,dim(dat)[1])
  return(dat)
}
if (!file.exists("Anguilla_genus")){
    dir.create("Anguilla_genus")
  }

#************************************************************************
#*********************************group4*********************************
#************************************************************************

sp4 = c('Anguilla bicolor',
        'Anguilla bicolor bicolor',
        'Anguilla bicolor pacifica',
        'Anguilla obscura',
        'Anguilla australis',
        'Anguilla australis australis',
        'Anguilla australis schmidtii','Anguilla australis schmidti')

group4 <- get_occ(sp = sp4,dbsource = "gbif",mc.cores = 4,limit = 60000,group = 4) 
group4 <- group4 %>% date_missing() %>% coord_impossible() %>% coord_incomplete() %>% coord_unlikely()
group4 <- unique(group4)
group4 <- group4[-grep("BOLD",group4$name),]
saveRDS(group4,"Anguilla_genus/group4.rds")
