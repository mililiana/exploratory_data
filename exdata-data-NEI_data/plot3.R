# Load data
nei <- readRDS("summarySCC_PM25.rds")

# Filter data for Baltimore City
baltimore_data <- nei %>%
  filter(fips == "24510")

# Aggregate emissions by type and year
emissions_by_type <- baltimore_data %>%
  group_by(year, type) %>%
  summarize(total = sum(Emissions))

# Create plot
png("plot3.png")
ggplot(emissions_by_type, aes(x = year, y = total, color = type)) +
  geom_line() +
  geom_point() +
  labs(title = "PM2.5 Emissions by Source Type in Baltimore City (1999-2008)",
       x = "Year", y = "Total PM2.5 Emissions (tons)") +
  theme_minimal()
dev.off()