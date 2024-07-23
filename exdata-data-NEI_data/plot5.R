# Load data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Identify motor vehicle sources
motor_vehicle <- scc[grep("vehicle", scc$Short.Name, ignore.case = TRUE), ]

# Filter NEI data for Baltimore City and motor vehicle sources
baltimore_vehicle_emissions <- nei %>%
  filter(fips == "24510" & SCC %in% motor_vehicle$SCC)

# Aggregate total emissions by year
total_vehicle_emissions <- baltimore_vehicle_emissions %>%
  group_by(year) %>%
  summarize(total = sum(Emissions))

# Create plot
png("plot5.png")
plot(total_vehicle_emissions$year, total_vehicle_emissions$total, type = "b", 
     xlab = "Year", ylab = "Total PM2.5 Emissions (tons)",
     main = "Emissions from Motor Vehicle Sources in Baltimore City (1999-2008)")
dev.off()