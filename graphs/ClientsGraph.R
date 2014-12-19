dataRead <- "//mizazaycensql01/SCMBIR/Client Dashboard/DataIn"
setwd(dataRead)



tl <- list.files(getwd())
tl <- tl[grep("Clients", tl)]
tl <- tl[order(tl)]
tl <- tl[length(tl)]

Clients <- read.csv(tl)
Clients$Date <- as.Date(Clients$Date, format = "%Y-%m-%d")
Clients$ProductHouseDesc <- toupper(Clients$ProductHouseDesc)



ClientInfo <- function(products, s, e){
to.plot <- products
to.plot <- toupper(to.plot)

plotdata <- Clients[which(Clients$Date >= s , Clients$Date <= e),]
plotdata <- plotdata[which(plotdata$ProductHouseDesc %in% to.plot ),]

p1a <- ggplot(data = plotdata, aes(x= Date, y = Clientcount, col = ProductHouseDesc)) + geom_line(lwd = .5 ,alpha = .375) + scale_color_manual(values = c("#dc291e", "#003366", "#747679")) + geom_smooth(method = "loess", lwd = 1.1)+
  xlab("Date")+
  ylab("Number of new Clients")+
  ggtitle("Number of new clients per PH")
return(p1a)

}
  
  
  
