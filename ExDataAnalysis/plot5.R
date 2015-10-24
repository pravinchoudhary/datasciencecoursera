plot5 <- function() {
    library(ggplot2)
    
    # load input data sets
    NEI <- readRDS("./summarySCC_PM25.rds")
    SCC <- readRDS("./Source_Classification_Code.rds")
    
    # Merge NEI adn SCC data based on Short.Name
    #Join_NEI_SCC = merge(NEI, SCC, by = "SCC")
    
    # Filter rows for "Coal" source
    NEI_Motor_Source <- subset(NEI, type == "ON-ROAD")
    
    # Filter out Motor Sources from Baltimore City
    NEI_Motor_Source_Baltimore = subset(NEI_Motor_Source, fips == "24510")
    
    # Aggregate Emissions by year
    NEI_Motor_Emissions_Baltimore <- aggregate(Emissions ~ year, NEI_Motor_Source_Baltimore, sum)
    NEI_Motor_Emissions_Baltimore <- transform(NEI_Motor_Emissions_Baltimore, year = factor(year))
    
    #Open plotting device
    png("./plot5.png")
    
    # Plot Total emissions from Coal sources by year
    g <- ggplot(data = NEI_Motor_Emissions_Baltimore, aes(x=year, y=Emissions, group=1)) + 
        geom_bar(stat = "identity") + 
        geom_line(color = "red", size = 2) + 
        geom_point(color = "orange", size = 6, pch = 18)  +
        labs(title = "Total Emissions from Motor Vehicle by year - Baltimore City")
    
    print(g)
    
    # save plot as png file
    #dev.copy(png, file = "./plot5.png")
    dev.off()
}