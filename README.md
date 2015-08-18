# Exploratory Data Analysis Project 2

## Plot: 1

![Plot 1](https://github.com/Nikhil47/ExData_Plotting2/blob/master/plot1.png)

Result: Yes, the emissions show a decreasing trend.

## Plot: 2

![Plot 2](https://github.com/Nikhil47/ExData_Plotting2/blob/master/plot2.png)

Result: Yes, the emissions show a decreasing trend.

## Plot: 3

![Plot 3](https://github.com/Nikhil47/ExData_Plotting2/blob/master/plot3.png)

Result: All types of emissions show a decreasing trend in the Baltimore city.

## Plot: 4

![Plot 4](https://github.com/Nikhil47/ExData_Plotting2/blob/master/plot4.png)

Result: The emissions due to coal combustion have gone down across US in the period of 99 to 08.

## Plot: 5

![Plot 5](https://github.com/Nikhil47/ExData_Plotting2/blob/master/plot5.png)

Result: The emissions from motor vehicles show a decreasing trend in the Baltimore City area.

## Plot: 6

![Plot 6](https://github.com/Nikhil47/ExData_Plotting2/blob/master/plot6.png)

Result: From the plot, in absolute terms it can be seen that LA, California has witnessed the most change.

However, let us see what kind of vehicular traffic contributes to the pollution the most. For that the vehicular data was pulled for both LA and Baltimore and grouped according to 'fips', 'year' and 'EI.Sector'. And a pie chart was plotted using ggplot to see the results.

```R
vehicular.data <- merged.data[(fips == "24510" | fips == "06037") & grepl("Vehicles", EI.Sector)]
vehicular.data <- vehicular.data[order(fips, year, EI.Sector), sum(Emissions), by = .(fips, year, EI.Sector)]

VehicularEm <- ggplot(vehicular.data, aes(year, V1, fill = fips)) +
        geom_bar(width = 1, stat = "identity") +
        facet_wrap(~EI.Sector) + coord_polar() +
        ylab("Emission in Tonnes") +
        xlab("Years") +
        ggtitle("Vehicular Emissions")
    
print(vehicularEm)
```
![Vehicular Emissions by type](https://github.com/Nikhil47/ExData_Plotting2/blob/master/VehicularEm.png)

From this graph, I had only wanted to see which kind of traffic mostly contributes to the PM2.5 levels. And found out that the heavy duty diesel and light duty gasoline vehicles are the main contributors. I would therefore, give my attention to these both vehicle types. LA, California is significantly larger than Baltimore, Maryland, 1302/239 = 5.44 times larger area wise. And 3,884,000/622,104 = 6.24 times, population wise. 
