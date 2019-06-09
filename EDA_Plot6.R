# EPA course assigment
# exdata_data_NEI_data
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California fips=="06037"). Which city has seen greater changes over time in motor vehicle emissions?

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

# Filter only LA and Baltimore data , group and summarize by year/city
MergeCDataF <- MergeCData %>% filter(fips == "06037" | fips == "24510") %>% 
    group_by(year,fips) %>%  
    summarise(emis = mean(Emissions, na.rm = TRUE)) %>% 
    # replacing city codes with names
    mutate(fips = ifelse(fips == "06037", "Los Angeles", "Baltimore City")) %>% 
    as.data.frame()

#plot graph
graphics.off()
ggplot(MergeCDataF,aes(factor(year),emis,fill=fips)) +
    geom_bar(stat="identity") +
    facet_grid(.~fips,scales = "free",space="free") + 
    labs(x="Year", y="Total PM2.5 Emission (Tons)") + 
    labs(title="PM2.5 Emissions, Baltimore and Los Angeles County 1999-2008")

# copy graph into png file
dev.copy(png, file = "plotpm_Balt_LA.png")

#close plot device
dev.off()


