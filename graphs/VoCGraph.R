dataRead <- "//mizazaycensql01/SCMBIR/Client Dashboard/DataIn"
setwd(dataRead)

tl <- list.files(getwd())
tl <- tl[grep("VoC", tl)]
tl <- tl[order(tl)]
tl <- tl[length(tl)]

VoC <- read.csv(tl)


FUNVOC <- function(PH, Metric){
  
VoC <- VoC[which(VoC$Product == PH),] ###
VoC$Date <- as.Date(VoC$Date, format = "%Y-%m-%d")
Score <- VoC[which(VoC$SurveyDescription == Metric),]###
Score <- Score[order(Score$Date, Score$Sentiment),]

a <-qplot(factor(format(Score$Date,format = "%Y-%m")), data = Score, 
      geom = "bar", fill = factor(Score$Sentiment),
      y =Score$Count,stat="identity",
      xlab = "Months",
      ylab= "Service Ratings",
      main = paste(PH,"VoC Ratings"))
a <- a + scale_fill_manual(values=c("#747679", "#003366", "#dc291e"),
                           labels = c("Negative \n 0-6 Rating","Neutral \n 7-8 Rating", "Positive \n 9-10 Rating"))
a <- a + theme(legend.title=element_blank())

return(a)

}
