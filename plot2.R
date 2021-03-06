
plot2 <- function(){
    data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(data_url, destfile = "exdatap2.zip", method = "curl")
    
    unzip("~/exdatap2.zip")
    NEI <- data.table(readRDS("summarySCC_PM25.rds"))
    SCC <- data.table(readRDS("Source_Classification_Code.rds"))
    
    NEI[, year := factor(year)]
    plot2.data <- NEI[fips == "24510", sum(Emissions), by = year]
    
    png(filename = "plot2.png")
    barplot(plot2.data$V1 / 10^6, names.arg = seq(1999, 2008, 3),
            main = "PM2.5 emissions vs years in Baltimore",
            xlab = "Years", ylab = "PM2.5 Emmissions in M.tonnes",
            border = T)
    lines(plot2.data$V1 / 10^6, lwd = 4)
    dev.off()
    invisible()
    # Result: Yes, the emission quantities have decreased
}