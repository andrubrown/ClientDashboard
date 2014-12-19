# Multiply plot

require(ggplot2)
dataRead <- "//mizazaycensql01/SCMBIR/Client Dashboard/DataIn"
setwd(dataRead)

tl <- list.files(getwd())
tl <- tl[grep("Multiply", tl)]
tl <- tl[order(tl)]
tl <- tl[length(tl)]

M <- read.csv(tl)

M$Date <- as.Date(M$Date , format = "%d-%B-%Y")

p1a <- qplot(data = M, 
             x = factor(format(M$Date, format = "%Y-%m")),  
             y = M$Count, 
             stat = "identity", 
             ylim= c(0, NA),
             geom = "bar", fill = factor(M$MultiplyMemberStatusDesc),
             xlab = "",
             ylab = "Member Count",
             main = "Multuply Member Count by Status",
             position = 'fill',
             environment = environment())
p1a <- p1a + theme(legend.title = element_blank(), axis.text.x = element_text(angle = 90))
p1a <- p1a + scale_fill_manual(values = c("#A77A4F", "#FBB040", "#58585B", "#BE2228", "#A7A9AB"))

p1a

#cast(df, year ~ group, mean, value = 'income')
