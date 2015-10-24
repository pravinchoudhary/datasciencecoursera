plot3 <- function() {
    library(ggplot2)
    
    # load input data sets
    NEI <- readRDS("./summarySCC_PM25.rds")
    SCC <- readRDS("./Source_Classification_Code.rds")
    
    NEI_Baltimore = subset(NEI, fips == "24510")    
    NEI_Baltimore <- transform(NEI_Baltimore, type = factor(type))
    
    # Aggregate emission data over year
    emission_by_year_type <- aggregate(Emissions ~ year+ type, NEI_Baltimore, sum)
    
    # Plot Emission by Year 
    g <- ggplot(emission_by_year_type, aes(year, Emissions, color = type)) + 
        geom_line(aes(group = type), size = 1.25) +
        ggtitle("Total Emissions in Baltimore City, Maryland, by Type")
    print(g)
    
    # save plot as png file
    dev.copy(png, file = "./plot3.png")
    dev.off()
}