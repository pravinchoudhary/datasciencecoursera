plot6 <- function() {
    library(ggplot2)
    
    # load input data sets
    NEI <- readRDS("./summarySCC_PM25.rds")
    SCC <- readRDS("./Source_Classification_Code.rds")
    
    # Merge NEI adn SCC data based on Short.Name
    #Join_NEI_SCC = merge(NEI, SCC, by = "SCC")
    
    # Filter rows for "Coal" source
    NEI_Motor_Source <- subset(NEI, type == "ON-ROAD")
    
    # Filter out Motor Sources from Baltimore City
    NEI_Motor_Source_City = subset(NEI_Motor_Source, fips == "24510" | fips == "06037")
    
    # Aggregate Emissions by year
    NEI_Motor_Emissions_City <- aggregate(Emissions ~ fips + year, NEI_Motor_Source_City, sum)
    NEI_Motor_Emissions_City <- transform(NEI_Motor_Emissions_City, year = factor(year))
    
    #Open plotting device
    png("./plot6.png")
    
    # Plot Total emissions from Coal sources by year
    g <- ggplot(data = NEI_Motor_Emissions_City, aes(year, Emissions, group = 1)) + geom_bar(stat = "identity") + 
        facet_grid(. ~ fips) + 
        geom_line(color = "red", size = 1.25) + 
        geom_point(color = "orange", size = 4, pch = 18)  +
        labs(title = "Total Emissions from Motor Vehicle Sources - Baltimore City Vs Los Angeles")
    
    print(g)
    
    # save plot as png file
    #dev.copy(png, file = "./plot5.png")
    dev.off()
}