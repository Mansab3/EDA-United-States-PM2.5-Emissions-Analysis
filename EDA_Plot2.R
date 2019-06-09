# EPA course assigment
# exdata_data_NEI_data
# Plot  for PM2.5 level for Baltimore city, Maryland
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds") 
SC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

colSums(is.na(NEI)) # Ensure output isn't impacted by NA's
colSums(is.na(SCC)) # Ensure output isn't impacted by NA's

# Group by year and filter only Baltimore county records
NEIP <- NEI %>% group_by(year) %>% filter(fips == "24510")

# Summarize Baltimore and calculate mean
PLT <- summarise(NEIP, emis = mean(Emissions, na.rm = TRUE))
graphics.off()
# Plot graph for PM2.5 level for Baltimore city, Maryland
plot(PLT$emis ~ PLT$year, type="l", xlab = "Year", ylab = "PM2.5", main = "PM2.5 Emission Baltimore City")

# copy graph into png file
dev.copy(png, file = "plotpm_balt.png")

#close plot device
dev.off()
