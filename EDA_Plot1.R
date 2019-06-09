# EPA course assigment
# exdata_data_NEI_data
# Plot1 USA PM2.5 data for years 1999,2002, 2005 and 2008
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")


NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds") 
SC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

colSums(is.na(NEI)) # Ensure output isn't impacted by NA's
colSums(is.na(SCC)) # Ensure output isn't impacted by NA's

# Plot for overall PM2.5 levels across country

NEIP <- NEI %>% group_by(year) %>% filter(year %in% c("1999","2002","2005", "2008"))

PLT <- summarise(NEIP, emis = mean(Emissions, na.rm = TRUE))

graphics.off()
# Plot graph
plot(PLT$emis ~ PLT$year, type="l", xlab = "Year", ylab = "PM2.5")

# copy graph into png file
dev.copy(png, file = "plotpm_year.png")

#close plot device
dev.off()

################################