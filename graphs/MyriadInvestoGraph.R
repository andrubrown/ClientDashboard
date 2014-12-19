# Myriad & Investo plot



dataRead <- "//mizazaycensql01/SCMBIR/Client Dashboard/DataIn"
setwd(dataRead)
funggcast<-function(dn,fcast){ 
  require(zoo) #needed for the 'as.yearmon()' function
  
  en<-max(time(fcast$mean)) #extract the max date used in the forecast
  
  #Extract Source and Training Data
  ds<-as.data.frame(window(dn,end=en, extend = TRUE))
  names(ds)<-'observed'
  ds$date<-as.Date(time(window(dn,end=en, extend = TRUE)))
  
  #Extract the Fitted Values (need to figure out how to grab confidence intervals)
  dfit<-as.data.frame(fcast$fitted)
  dfit$date<-as.Date(time(fcast$fitted))
  names(dfit)[1]<-'fitted'
  
  ds<-merge(ds,dfit,all.x=T) #Merge fitted values with source and training data
  
  #Exract the Forecast values and confidence intervals
  dfcastn<-as.data.frame(fcast)
  dfcastn$date<-as.Date(as.yearmon(row.names(dfcastn)))
  names(dfcastn)<-c('forecast','lo80','hi80','lo95','hi95','date')
  
  pd<-merge(ds,dfcastn,all.x=T) #final data.frame for use in ggplot
  return(pd)
  
}
tl <- list.files(getwd())
tl <- tl[grep("MyriadInvesto", tl)]
tl <- tl[order(tl)]
tl <- tl[length(tl)]

NLC <- read.csv(tl)
NLC$Date <- as.Date(NLC$Date, format = "%Y-%m-%d")


#Graphing----

#PH <- "Myriad"
PHG <- function(PH, s, e, fc){


Pol <- NLC[which(NLC$ProductHouse == PH & NLC$Date > s & NLC$Date < e),]

tsLC <- ts(data = Pol$LC, 
           start = c(as.integer(format(min(Pol$Date), "%Y")), as.integer(format(min(Pol$Date), "%m"))), 
           end = c(as.integer(format(max(Pol$Date), "%Y")), as.integer(format(max(Pol$Date), "%m"))), 
           frequency = 12)
tsNB <- ts(data = Pol$NB, 
           start = c(as.integer(format(min(Pol$Date), "%Y")), as.integer(format(min(Pol$Date), "%m"))), 
           end = c(as.integer(format(max(Pol$Date), "%Y")), as.integer(format(max(Pol$Date), "%m"))), 
           frequency = 12)

tsLCfc <- forecast(auto.arima(tsLC) ,fc)
tsNBfc <- forecast(auto.arima(tsNB) ,fc)

LC <- funggcast(tsLC,tsLCfc)
NB <- funggcast(tsNB,tsNBfc)

#observed LC
p1 <- ggplot(data = LC, aes(x = date, y = observed), type = "line", col = "#dc291e", lwd = 1, alpha = .125) +
  geom_line(data = LC, col = "#dc291e", alpha = .5)+
  geom_smooth(data = LC, aes(x=date, y =observed), method = "loess",  col = "#dc291e", fill = "#dc291e", lwd=1.25, alpha = .375)
#forecast LC
p1 <- p1 + geom_ribbon(data = LC, aes(x = date, ymin = lo80, ymax= hi80), fill = "#dc291e", alpha = .125)+
  geom_ribbon(data = LC, aes(x = date, ymin = lo95, ymax= hi95), fill = "#dc291e", alpha = .125)+
  geom_line(data = LC, aes(x= date, y = forecast), lty = "dotted", col = "#dc291e", lwd = 1)
#observed NB
p1 <- p1 + geom_line(data = NB, aes(x = date, y = observed), col = "#003366", alpha = .33) +
  geom_smooth(data = NB, aes(x=date, y =observed), method = "loess",  col = "#003366", fill = "#003366", lwd=1.25, alpha = .375)
#forecast NB
p1 <- p1 + geom_ribbon(data = NB, aes(x = date, ymin = lo80, ymax= hi80), fill = "#003366", alpha = .125)+
  geom_ribbon(data = NB, aes(x = date, ymin = lo95, ymax= hi95), fill = "#003366", alpha = .125)+
  geom_line(data = NB, aes(x= date, y = forecast), lty = "dotted", col = "#003366", lwd = 1)+
  #Lables  
  ylab("Policy Count")+
  xlab("Date")+
  ggtitle(paste(PH, "policy history\n\nBlue: New Business | Red: ",
                if ( PH == "Myriad") {"Cancelled and Lapsed Policies\n"
                } else {
                  "External section 14s and Surrenders\n"},
                "Dotted Line: Forecasted values with 80% and 95% confidence intervals"))+
  theme(plot.title = element_text(lineheight=1, face="bold"))
p1



return(p1)
}

