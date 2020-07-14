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
need.packs <- c("spocc","dplyr")
#-----------------------START-------------------------------
#--------------Packages you want to install-----------------------
has <- need.packs %in% row.names(installed.packages())
if(any(!has))install.packages(need.packs[!has], repos = '')
lapply(need.packs, require, character.only = TRUE)

#------------------------Custom get_occ function-------------
get_occ <- function(sp,dbsource,limit,month,group){
  if(length(sp)==1){
    #month <- match.arg(month, choices = as.character(1:12))
    dat <- spocc::occ(query = sp, from = dbsource, limit = limit, gbifopts = list(month = month))
    dat <- dat$gbif$data
      #spocc::occ2df(spocc::occ(query = query, from = dbsource, limit = limit, gbifopts = list(month = month)), what = "data")
  }else{
    dat <- spocc::occ(query = sp, from = dbsource, limit = limit)
    dat <- dat$gbif$data
      #spocc::occ2df(spocc::occ(query = query, from = dbsource, limit = limit), what = "data")
    
  }
  #dat <- rlist::list.stack(dat)
  dat <- dplyr::bind_rows(dat[1])
  dat$group <- rep(group,dim(dat)[1])
  return(dat)
}

if (!file.exists("Anguilla_genus")){
    dir.create("Anguilla_genus")
  }


#************************************************************************
#*********************************group3*********************************
#************************************************************************
sp3 = c('Anguilla borneensis',
        'Anguilla japonica',
        'Anguilla rostrata')
group3_1 <- get_occ(sp = sp3,dbsource = "gbif",limit = 60000,group = 3) 
#group3_1 <- group3_1 %>% date_missing() %>% coord_impossible() %>% coord_incomplete() %>% coord_unlikely()
#group3_1 <- unique(group3_1)
#group3_1 <- group3_1[-grep("BOLD",group3_1$name),]

df1 <- get_occ(sp = 'Anguilla anguilla',dbsource = "gbif",limit = 60000,month = 1,group = 3) 
#df1 <- df1 %>% coord_impossible() %>% coord_incomplete() %>% coord_unlikely()
#df1 <- unique(df1)

df2 <- get_occ(sp = 'Anguilla anguilla',dbsource = "gbif",limit = 60000,month = 2,group = 3)
#df2 <- df2 %>% coord_impossible() %>% coord_incomplete() %>% coord_unlikely()
#df2 <- unique(df2)

df3 <- get_occ(sp = 'Anguilla anguilla',dbsource = "gbif",limit = 60000,month = 3,group = 3)
#df3 <- df3 %>% coord_impossible() %>% coord_incomplete() %>% coord_unlikely()
#df3 <- unique(df3)

df4 <- get_occ(sp = 'Anguilla anguilla',dbsource = "gbif",limit = 60000,month = 4,group = 3) 
#df4 <- df4 %>% coord_impossible() %>% coord_incomplete() %>% coord_unlikely()
#df4 <- unique(df4)

df5 <- get_occ(sp = 'Anguilla anguilla',dbsource = "gbif",limit = 60000,month = 5,group = 3) 
#df5 <- df5 %>% coord_impossible() %>% coord_incomplete() %>% coord_unlikely()
#df5 <- unique(df5)

df6 <- get_occ(sp = 'Anguilla anguilla',dbsource = "gbif",limit = 60000,month = 6,group = 3) 
#df6 <- df6 %>% coord_impossible() %>% coord_incomplete() %>% coord_unlikely()
#df6 <- unique(df6)

df7 <- get_occ(sp = 'Anguilla anguilla',dbsource = "gbif",limit = 60000,month = 7,group = 3) 
#df7 <- df7 %>% coord_impossible() %>% coord_incomplete() %>% coord_unlikely()
#df7 <- unique(df7)

df8 <- get_occ(sp = 'Anguilla anguilla',dbsource = "gbif",limit = 60000,month = 8,group = 3) 
#df8 <- df7 %>% coord_impossible() %>% coord_incomplete() %>% coord_unlikely()
#df8 <- unique(df8)

df9 <- get_occ(sp = 'Anguilla anguilla',dbsource = "gbif",limit = 60000,month = 9,group = 3)
#df9 <- df9 %>% coord_impossible() %>% coord_incomplete() %>% coord_unlikely()
#df9 <- unique(df9)

df10 <- get_occ(sp = 'Anguilla anguilla',dbsource = "gbif",limit = 60000,month = 10,group = 3) 
#df10 <- df10 %>% coord_impossible() %>% coord_incomplete() %>% coord_unlikely()
#df10 <- unique(df10)

df11 <- get_occ(sp = 'Anguilla anguilla',dbsource = "gbif",limit = 60000,month = 11,group = 3) 
#df11 <- df11 %>% coord_impossible() %>% coord_incomplete() %>% coord_unlikely()
#df11 <- unique(df11)

df12 <- get_occ(sp = 'Anguilla anguilla',dbsource = "gbif",limit = 60000,month = 12,group = 3) 
#df12 <- df12 %>% coord_impossible() %>% coord_incomplete() %>% coord_unlikely()
#df12 <- unique(df12)

df_list <- list(group3_1,df1,df2,df3,df4,df5,df6,df7,df8,df9,df10,df11,df12)
group3 <- Reduce(function(x,y) merge(x,y,all=T),df_list)

saveRDS(group3,"Anguilla_genus/group3.rds")
