# Load data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Identify coal combustion-related sources
coal_combustion <- scc[grep("coal", scc$Short.Name, ignore.case = TRUE), ]

# Filter NEI data for coal combustion-related sources
coal_emissions <- nei %>%
  filter(SCC %in% coal_combustion$SCC)

# Aggregate total emissions by year
total_coal_emissions <- coal_emissions %>%
  group_by(year) %>%
  summarize(total = sum(Emissions))

# Create plot
png("plot4.png")
plot(total_coal_emissions$year, total_coal_emissions$total, type = "b", 
     xlab = "Year", ylab = "Total PM2.5 Emissions (tons)",
     main = "Emissions from Coal Combustion-related Sources (1999-2008)")
dev.off()