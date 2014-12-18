tl <- list.files("//mizazaycensql01/SCMBIR/Client Dashboard/DataIn")
tl <- tl[grep("PolicyCount", tl)]
tl <- tl[order(tl)]
tl <- tl[length(tl)]

PC <- read.csv(tl)
PC$Date <- as.Date(PC$Date, format = "%Y-%m-%d")
v <- input$select
if (v == "Myriad") {

M <- PC[which(PC$ProductHouseDesc == toupper("Myriad")),]
M$Date <- as.Date(M$Date, format = "%Y-%m-%d")
M <- M[order(M$Date),]
Mlatest <- M[nrow(M),] ###
d <- as.POSIXlt(Mlatest$Date)
d$year <- d$year - 1
d <- as.Date(d, format = "%Y-%m-%d")
Mlastyear <- M[M$Date == d,] ###
Mdifference <- paste(round((Mlatest$Count - Mlastyear$Count) / Mlastyear$Count* 100,1), "%", sep = "") ##

cat("No of Policies as of ", format(Mlatest$Date, "%b-%y"), ": ", format(Mlatest$Count, big.mark = ",") , 
      "\nNo of Policies as of ", format(d, "%b-%y"), ": ",format(Mlastyear$Count, big.mark = ","),
    if(Mdifference > 0) "\nIncrease of "else "\nDecrease of ",
     Mdifference , sep = "")}



if (v == "Investo"){
L <- PC[which(PC$ProductHouseDesc == toupper("Investo")),]
L$Date <- as.Date(L$Date, format = "%Y-%m-%d")
L <- L[order(L$Date),]
Llatest <- L[nrow(L),] ###
d <- as.POSIXlt(Llatest$Date)
d$year <- d$year - 1
d <- as.Date(d, format = "%Y-%m-%d")
Llastyear <- L[L$Date == d,] ###
Ldifference <- paste(round((Llatest$Count - Llastyear$Count) / Llastyear$Count* 100,1), "%", sep = " ") ##

cat("No of Policies as of ", format(Llatest$Date, "%b-%y"), ": ", format(Llatest$Count, big.mark = ",") , 
    "\nNo of Policies as of ", format(d, "%b-%y"), ": ",format(Llastyear$Count, big.mark = ","),
    if(Ldifference > 0) "\nIncrease of "else "\nDecrease of ",
    Ldifference , sep = "")}


#else return()

