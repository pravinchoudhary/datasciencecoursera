plot4 <- function() {
    library(ggplot2)
    
    # load input data sets
    NEI <- readRDS("./summarySCC_PM25.rds")
    SCC <- readRDS("./Source_Classification_Code.rds")
    
    # Merge NEI adn SCC data based on Short.Name
    Join_NEI_SCC = merge(NEI, SCC, by = "SCC")
    
    # Filter rows for "Coal" source
    NEI_Coal_Source <- Join_NEI_SCC[(grepl("Coal", Join_NEI_SCC$Short.Name, ignore.case = TRUE)), ]
    NEI_Coal_Comb_Source <- NEI_Coal_Source[(grepl("Comb", NEI_Coal_Source$Short.Name, 
                                                ignore.case = TRUE)), ]
    NEI_Coal_Emissions <- aggregate(Emissions ~ year, NEI_Coal_Comb_Source, sum)
    NEI_Coal_Emissions <- transform(NEI_Coal_Emissions, year = factor(year))
    
    # Plot Total emissions from Coal sources by year
    with(NEI_Coal_Emissions, plot(year, Emissions, pch = "_", cex = 3,
                                  main = "Emissions from Coal combustion-related sources"))
    points(NEI_Coal_Emissions$year, NEI_Coal_Emissions$Emissions, type = "l", col = "red", lwd=2)
    
    # save plot as png file
    dev.copy(png, file = "./plot4.png")
    dev.off()
}