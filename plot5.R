plot5 <- function(){
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
    plot5.data <- merged.data[fips == "24510"]
    plot5.data <- plot5.data[grepl("Vehicles", EI.Sector), sum(Emissions), by = .(year)]
    
    png(filename = "plot5.png")
    g <- ggplot(data = plot5.data, aes(year, V1))
    g <- g + geom_bar(stat = "identity") +
        xlab("Years") +
        ylab("Emissions in tonnes") +
        ggtitle("Yearwise emissions from vehicular sources")
    print(g)
    dev.off()
    invisible()
}