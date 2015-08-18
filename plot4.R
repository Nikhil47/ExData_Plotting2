plot4 <- function(){
    library(ggplot2)
    data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(data_url, destfile = "exdatap2.zip", method = "curl")
    
    unzip("~/exdatap2.zip")
    NEI <- data.table(readRDS("summarySCC_PM25.rds"))
    SCC <- data.table(readRDS("Source_Classification_Code.rds"))
    
    NEI[, type := factor(type)]
    NEI[, year := factor(year)]
    
    setkey(NEI, "SCC")
    setkey(SCC, "SCC")
    
    merged.data <- merge(NEI, SCC)
    plot4.data <- merged.data[grepl("Coal", EI.Sector), sum(Emissions)/10^6, by = .(year)]
    
    png(filename = "plot4.png")
    g <- ggplot(data = plot4.data, aes(year, V1))
    g <- g + geom_bar(stat = "identity") +
        xlab("Years") +
        ylab("Emissions in M.tonnes") +
        ggtitle("Yearwise emissions from coal combustion-related sources")
    print(g)
    dev.off()
    invisible()
}