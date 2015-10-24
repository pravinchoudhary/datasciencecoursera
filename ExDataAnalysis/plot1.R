plot1 <- function() {
    # load input data sets
    NEI <- readRDS("./summarySCC_PM25.rds")
    SCC <- readRDS("./Source_Classification_Code.rds")
    
    # Aggregate emission data over year
    emission_by_year <- aggregate(Emissions ~ year, NEI, sum)
    emission_by_year <- transform(emission_by_year, year = factor(year))
    
    # open graphics device
    png("./plot1.png")
    
    # Plot Emission by Year 
    with(emission_by_year, plot(year, Emissions, pch = "_", cex = 3, xlab = "Year",
                                ylab = "Emissions from P2.5",
                                main = "Total Emisisons by year"))
    points(emission_by_year$year, emission_by_year$Emissions, type = "l", 
           col = "red", lwd = 3)
    
    # save plot as png file
    dev.off()
}