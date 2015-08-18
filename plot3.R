plot3 <- function(){
    library(ggplot2)
    data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(data_url, destfile = "exdatap2.zip", method = "curl")
    
    unzip("~/exdatap2.zip")
    NEI <- data.table(readRDS("summarySCC_PM25.rds"))
    SCC <- data.table(readRDS("Source_Classification_Code.rds"))
    
    NEI[, type := factor(type)]
    NEI[, year := factor(year)]

    plot3.data <- NEI[fips == "24510"]
    plot3.data <- NEI[order(year, type), sum(Emissions), by = .(year, type)]
    
    png(filename = "plot3.png")
    g <- ggplot(data = plot3.data, aes(year, V1))
    g <- g + geom_bar(stat = "identity")
    g <- g + facet_wrap(~type) +
        xlab("years") +
        ylab("Emissions in M.tonnes") +
        ggtitle("Emissions from different types")
    print(g)
    dev.off()
    invisible()
    # Result: All types of the emission quantities have decreased
}