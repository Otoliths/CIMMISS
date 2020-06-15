if(!("jsonlite" %in% row.names(installed.packages())))
  install.packages("jsonlite",dependencies = T)
get <- function(i){
  baseurl <- function()"http://api.data.cma.cn:8090/api?"
  userId <- "5921014329184DMzs"
  pwd <- "O6Ex76U"
  timestart <- paste0(gsub("-","",as.Date(Sys.Date())-2),"000000")
  timeend <- paste0(gsub("-","",Sys.Date()-1),"000000")
  timeRange <- paste0("[",timestart,",",timeend,"]")
  # ids <- read.csv("China_SURF_Station.csv")
  China_SURF_Station <- read.csv("China_SURF_Station.csv")
  yunnan <- subset(China_SURF_Station,China_SURF_Station$省份 == "云南")
  tibet <- subset(China_SURF_Station,China_SURF_Station$省份 == "西藏")
  ids <- rbind(yunnan,tibet)
  staIDs <- paste(ids$区站号[i],collapse=",")
  elements <- "Station_Id_C,Year,Mon,Day,Hour,PRS,PRS_Sea,PRS_Max,PRS_Min,TEM,TEM_Max,TEM_Min,RHU,RHU_Min,VAP,PRE_1h,WIN_D_INST_Max,WIN_S_Max,WIN_D_S_Max,WIN_S_Avg_2mi,WIN_D_Avg_2mi,WEP_Now,WIN_S_Inst_Max,tigan,windpower,VIS,CLO_Cov,CLO_Cov_Low,CLO_COV_LM"
  url = paste(baseurl(), "userId=", userId, "&pwd=",pwd,"&dataFormat=json&interfaceId=getSurfEleByTimeRangeAndStaID&dataCode=SURF_CHN_MUL_HOR&timeRange=",
              timeRange,"&staIDs=",staIDs,"&elements=",elements,sep = "")
  db <- jsonlite::fromJSON(url, flatten=TRUE)
  if(db$returnMessage == "Query Succeed"){
    dir.create(paste0("data/",Sys.Date()-2))
    path <- paste0("data/",Sys.Date()-2,"/",ids$区站号[i],"-",ids$省份[i],"-",ids$站名[i],".rds")
    saveRDS(db,path)
    cat(length(list.files(paste0("data/",Sys.Date()-2,"/"), full.names = TRUE)))
  }
}
pbmcapply::pbmclapply(1:132,get,mc.cores = 2)
sink(paste0(Sys.Date()-2,".text"))
cat(sprintf("last Update: %s",Sys.time()),sep = "\n")
cat(length(list.files(paste0("data/",Sys.Date()-2,"/"), full.names = TRUE)))
sink()
