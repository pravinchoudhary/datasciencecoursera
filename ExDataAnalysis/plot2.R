plot2 <- function() {
    # load input data sets
    NEI <- readRDS("./summarySCC_PM25.rds")
    SCC <- readRDS("./Source_Classification_Code.rds")
    
    # Filter out data for Baltimore City, Maryland
    NEI_Baltimore = subset(NEI, fips == "24510")    
    
    # Aggregate emission data over year
    emission_by_year <- aggregate(Emissions ~ year, NEI_Baltimore, sum)
    
    # Plot Emission by Year 
    with(emission_by_year, plot(year, Emissions, pch = "_", cex = 3, xlab = "Year",
                                ylab = "Emissions from P2.5",
                                main = "Total emissions by year - Baltimore City"))
    points(emission_by_year$year, emission_by_year$Emissions, type = "l", 
           col = "red", lwd = 3)

    
    # save plot as png file
    dev.copy(png, file = "./plot2.png")
    dev.off()
}