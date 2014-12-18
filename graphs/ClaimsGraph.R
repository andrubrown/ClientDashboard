tl <- list.files("//mizazaycensql01/SCMBIR/Client Dashboard/DataIn")
tl <- tl[grep("Claims", tl)]
tl <- tl[order(tl)]
tl <- tl[length(tl)]

Claims <- read.csv(tl)
Claims$Date <- as.Date(Claims$Date, format = "%Y-%m-%d")

tsC <- setNames(aggregate(x = Claims$TotalPaidOut, by = list(Claims$Date), FUN = sum), c("Date", "TotalPaidOut"))


tsC$Date <- as.Date(tsC$Date, format = "%Y-%m-%d")


tsC <- ts(data = tsC$TotalPaidOut, 
          start = c(as.integer(format(min(tsC$Date), "%Y")), as.integer(format(min(tsC$Date), "%m"))),
          end = c(as.integer(format(max(tsC$Date), "%Y")), as.integer(format(max(tsC$Date), "%m"))),
          frequency = 12)

tsCfc <- forecast(auto.arima(tsC), 12)

tsC <- funggcast(tsC, tsCfc)

p1a <- ggplot(data = tsC, aes(x = date, y = observed)) + geom_line(lwd = 1, alpha = .5, col = "#dc291e",na.rm=F) + 
geom_smooth(method = "loess",  col = "#dc291e", fill = "#dc291e", lwd=1.25, alpha = .375,na.rm=TRUE)+
scale_y_continuous(labels = comma)
p1a <- p1a + geom_ribbon(data = tsC,aes(x=date, ymin = lo80, ymax = hi80), fill = "#dc291e", alpha = .125)
p1a <- p1a + geom_ribbon(data = tsC,aes(x=date, ymin = lo95, ymax =hi95), fill = "#dc291e", alpha = .125)
p1a <- p1a + geom_line(data = tsC,aes(x= date, y = forecast), lty = "dotted", col = "#dc291e", lwd = 1)
p1a <- p1a + xlab("Date") + ylab("Amount paid out in Rand") 
p1a <- p1a + labs(title = "Amount paid out per month for Myriad Policies\nDotted line: Forecasted value with 80% and 95% confidence intervals")

p1a

