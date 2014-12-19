

dataRead <- "DataIn"
setwd(dataRead)

tl <- list.files(getwd())
tl <- tl[grep("Claims", tl)]
tl <- tl[order(tl)]
tl <- tl[length(tl)]

Claims <- read.csv(tl)
Claims$Date <- as.Date(Claims$Date, format = "%Y-%m-%d")
CLAIMSFUNCTION <- function(cdr){

cdr <- as.Date(paste(format(as.Date(cdr), "%Y-%m"), "-01", sep = ""))


cl <- Claims[which(Claims$Date==cdr),]
cl <- cl[order(cl$TotalPaidOut, decreasing = TRUE),]
cl <- cl[1:10,]


p1a <- ggplot(cl, aes(x = PrimaryCauseDescription, y= TotalPaidOut, fill = PrimaryCauseDescription)) + 
  geom_bar(width = 1, stat = "identity")+
  scale_fill_manual(values = c("#5B9BD5","#ED8D31","#A5A5A5","#FFC000","#4472C4",
                               "#70AD47","#255E91","#9E480E","#636363","#664300"),
                    breaks=cl$PrimaryCauseDescription)+

  labs(title = paste("Top 10 Primary Casues for claims during", format(cdr, "%B-%Y")))+
  #labs(title ="Top 10 Primary Casues for claims during")+
  scale_y_continuous(labels = comma) +
  scale_x_discrete(limits=cl$PrimaryCauseDescription)+
  theme(axis.text.x = element_text(angle = 90))+
  xlab( "Causes")+
  ylab("Paid Out in Rand")
p1a
 return(p1a) 
}

