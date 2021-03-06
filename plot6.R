plot6 <- function(){
    library(ggplot2)
    data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(data_url, destfile = "exdatap2.zip", method = "curl")
    
    unzip("~/exdatap2.zip")
    NEI <- data.table(readRDS("summarySCC_PM25.rds"))
    SCC <- data.table(readRDS("Source_Classification_Code.rds"))
    
    setkey(NEI, "SCC")
    setkey(SCC, "SCC")
    
    merged.data <- merge(NEI, SCC)
    
    plot6.data <- merged.data[(fips == "24510" | fips == "06037") & grepl("Vehicles", EI.Sector)]
    plot6.data <- plot6.data[order(fips, year), sum(Emissions), by = .(fips, year)]
    
    png(filename = "plot6.png")
    grossEm <- ggplot(plot6.data, aes(year, V1, fill = fips)) +
        geom_bar(position="dodge", stat = "identity") +
        ylab("Emissions in Tonnes") +
        xlab("Years") +
        ggtitle("Vehicular Emission in LA and Baltimore")
    
    print(grossEm)
    dev.off()
    invisible()
}