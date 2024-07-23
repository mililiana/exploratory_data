# Load data
nei <- readRDS("summarySCC_PM25.rds")

# Aggregate total emissions by year
total_emissions <- nei %>%
  group_by(year) %>%
  summarize(total = sum(Emissions))

# Create plot
png("plot1.png")
plot(total_emissions$year, total_emissions$total, type = "b", 
     xlab = "Year", ylab = "Total PM2.5 Emissions (tons)",
     main = "Total PM2.5 Emissions in the United States (1999-2008)")
dev.off()