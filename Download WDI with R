#####################################################
#This code shows you how to download WDI data with R#
#       and how to export as an excel file          #
#####################################################

#~~~defining the work file: where the exported data will be stored~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

#Define the work file

setwd(choose.dir())

#or
setwd("C:/Users/Dany/Desktop/mes_travaux/TIC-STAT_Data/ma_chaine_youtube/codes")

#~~~~~Install and have help about the  package WDI~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# to install the package WDI  (you need to be connected)
install.packages("WDI")
library(help="WDI")

# having help about the package
library(help="WDI")

# load the package
library("WDI")


#~~~~~~~~~~~~~~~~   Extracting and exporting data  ~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

#to see more about WDI_data
str(WDI_data)


#Voir les Variables contenus dans la Base

View(WDI_data$series)
colnames(WDI_data$series)

#Updata data in the cache : is there new series, countries or years?

WDIcache()


#Download the entire world Bank data (WDI)
completedata=WDIbulk()

#~~~~selecting the series you need to download~~~~#

#(Posi1=grep("GDP",WDI_data$series[,1], ignore.case = T ))

(Posi2=grep("external debt ",WDI_data$series[,2], ignore.case = T ))

#(Posi3=grep("IND",WDI_data$series[,1], ignore.case = T ))

#(Posi4=grep("MANF",WDI_data$series[,1], ignore.case = T ))

#View(WDI_data$series[Posi1,1:2])

View(WDI_data$series[Posi2,1:2]) #showing all cases containing the expression "external debt"

#View(WDI_data$series[Posi3,1:2])

#View(WDI_data$series[Posi4,1:2])

#DT.DOD.DECT.CD 
#NV.IND.MANF.CD
#NV.IND.TOTL.CD



##Have information about contries

View(WDI_data$country)
colnames(WDI_data$country) 
infocontries=as.data.frame(WDI_data$country)

#choosing regions

levels(infocontries$region)

chosedregion=c("South Asia","Sub-Saharan Africa","Middle East & North Africa","East Asia & Pacific")

#extracting iso2 codes to download data
library(tidyverse)
chosedcontries=infocontries %>% filter(region%in%chosedregion) %>% 
                select(iso2c) %>% unlist() 

# downloading selected data (country="ALL" for all contries)

#We use extra=T to also dowload informations position of contries (latitude, longitude, etc.)

data=WDI(country=chosedcontries, indicator= c("stockdetteext" = "DT.DOD.DECT.CD",
     "IndVA"= "NV.IND.TOTL.CD","MANUFVA"="NV.IND.MANF.CD"), start=2004, end=2018, extra=TRUE)

View(data)

#~~~~~~~~~~~~~ Export data into excel format ~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

library(openxlsx)

write.xlsx(data, "data_va.xlsx")

#########################################################
#follow on youtube with the link bellow for     tutorial#
#              https://youtu.be/dDmR-YCT5Ak             #
#########################################################
