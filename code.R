install.packages("curl")
install.packages("httr")
install.packages("jsonlite",dependencies=TRUE)
baseurl <- function()"http://api.data.cma.cn:8090/api?"
userId <- "5921014329184DMzs"
pwd <- "O6Ex76U"
timestart <- paste0(gsub("-","",as.Date(Sys.Date())-7),"000000")
timeend <- paste0(gsub("-","",Sys.Date()),"000000")
timeRange <- paste0("[",timestart,",",timeend,"]")
staIDs <- "56489,56497,56533,56543,56548"
elements <- "Station_Id_C,Year,Mon,Day,Hour,PRS,PRS_Sea,PRS_Max,PRS_Min,TEM,TEM_Max,TEM_Min,RHU,RHU_Min,VAP,PRE_1h,WIN_D_INST_Max,WIN_S_Max,WIN_D_S_Max,WIN_S_Avg_2mi,WIN_D_Avg_2mi,WEP_Now,WIN_S_Inst_Max,tigan,windpower,VIS,CLO_Cov,CLO_Cov_Low,CLO_COV_LM"
url = paste(baseurl(), "userId=", userId, "&pwd=",pwd,"&dataFormat=json&interfaceId=getSurfEleByTimeRangeAndStaID&dataCode=SURF_CHN_MUL_HOR&timeRange=",
            timeRange,"&staIDs=",staIDs,"&elements=",elements,sep = "")
db <- jsonlite::fromJSON(url, flatten=TRUE)
if(db$returnMessage == "Query Succeed"){
  path <- paste0(Sys.time(),".rds")
  saveRDS(db,path)
}
