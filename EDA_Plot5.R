# EPA course assigment
# exdata_data_NEI_data
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds") 
SC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

colSums(is.na(NEI)) # Ensure output isn't impacted by NA's
colSums(is.na(SCC)) # Ensure output isn't impacted by NA's

# Emission data SCC code as character
NEI$SCC  <- as.character(NEI$SCC) 
# Source classification data SCC code as character
SCCF$SCC <- as.character(SCCF$SCC) 

# Selecting only motor vehicle emission source data
SCCM <- SCC[grepl("Vehicle", SCC[["SCC.Level.Two"]]),] 

#Merging Emission and Source classification based on SCC code
MergeVData <- inner_join(NEI,SCCM, by = 'SCC')

#Filter data only for Baltimore and group data by year
MergeVDataF <- MergeVData %>% filter(fips == "24510") %>% group_by(year) %>%  
    summarise(emis = mean(Emissions, na.rm = TRUE))

#plot graph
graphics.off()

# Plot vehiclce source emission graph for Baltimore 
ggplot(MergeVDataF,aes(x = year,y = emis)) +
    geom_bar(stat="identity", width=0.60) +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission")) + 
    labs(title=expression("PM"[2.5]*" Motor Vehicles Source Emissions Baltimore City from 1999-2008"))
# copy graph into png file
dev.copy(png, file = "plotpm_vehicle.png")

#close plot device
dev.off()
