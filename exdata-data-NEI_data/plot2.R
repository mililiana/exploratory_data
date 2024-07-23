# Load data
nei <- readRDS("summarySCC_PM25.rds")

# Filter data for Baltimore City
baltimore_data <- nei %>%
  filter(fips == "24510")

# Aggregate total emissions by year
baltimore_emissions <- baltimore_data %>%
  group_by(year) %>%
  summarize(total = sum(Emissions))

# Create plot
png("plot2.png")
plot(baltimore_emissions$year, baltimore_emissions$total, type = "b", 
     xlab = "Year", ylab = "Total PM2.5 Emissions (tons)",
     main = "Total PM2.5 Emissions in Baltimore City (1999-2008)")
dev.off()