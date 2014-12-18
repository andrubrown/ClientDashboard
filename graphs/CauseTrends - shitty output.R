# Cause trends
require(ggplot2)

source("//mizazaycensql01/SCMBIR/Client Dashboard/Shiny/graphs/ClaimsGraph2.R")

CL1 <- levels(Claims$PrimaryCauseDescription)[sample(1:24,1)]

CL1 <- c("Cardiovascular", "Cancer")
CL1 <- "Skin"
C <- Claims[which(Claims$PrimaryCauseDescription == CL1),]



 ggplot(data = C, aes(x = Date, y = TotalPaidOut, group = PrimaryCauseDescription, col = PrimaryCauseDescription)) + geom_line()
  geom_bar(stat = "identity", position="dodge", col = "black")





