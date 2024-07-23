# Load data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Identify motor vehicle sources
motor_vehicle <- scc[grep("vehicle", scc$Short.Name, ignore.case = TRUE), ]

# Filter NEI data for Baltimore City and Los Angeles County for motor vehicle sources
baltimore_la_vehicle_emissions <- nei %>%
  filter(fips %in% c("24510", "06037") & SCC %in% motor_vehicle$SCC)

# Aggregate total emissions by year and fips
vehicle_emissions_comparison <- baltimore_la_vehicle_emissions %>%
  group_by(year, fips) %>%
  summarize(total = sum(Emissions))

# Create plot
png("plot6.png")
ggplot(vehicle_emissions_comparison, aes(x = year, y = total, color = fips)) +
  geom_line() +
  geom_point() +
  scale_color_manual(labels = c("Baltimore City", "Los Angeles County"), 
                     values = c("blue", "red")) +
  labs(title = "Motor Vehicle Emissions: Baltimore City vs Los Angeles County (1999-2008)",
       x = "Year", y = "Total PM2.5 Emissions (tons)") +
  theme_minimal()
dev.off()