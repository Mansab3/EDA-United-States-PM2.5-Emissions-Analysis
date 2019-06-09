# EPA course assigment
# exdata_data_NEI_data
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds") 
SC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

colSums(is.na(NEI)) # Ensure output isn't impacted by NA's
colSums(is.na(SCC)) # Ensure output isn't impacted by NA's

# Selecting only coal combustion related emission source data
SCCF <- SCC[grepl("Coal", SCC[["EI.Sector"]]) & grepl("Comb", SCC[["EI.Sector"]]), ]

#Merging Emission and Source classification data based on SCC code
MergeData <- inner_join(NEI,SCCF, by = 'SCC')

#Group data by year and source type
MergeDataF <- MergeData %>% group_by(year, EI.Sector) %>%  
    summarise(emis = mean(Emissions, na.rm = TRUE))

# plot coal combustion pm2.5 emission source graphs.
graphics.off()
ggplot(MergeDataF,aes(factor(MergeDataF$year),MergeDataF$emis,fill=EI.Sector)) +
    geom_bar(stat="identity") +
    facet_grid(.~EI.Sector,scales = "free",space="free") + 
    labs(x="year", y="Total PM2.5 Emission (Tons)") + 
    labs(title="PM2.5 Emissions, Baltimore City 1999-2008 by Source Type")

# copy graph into png file
dev.copy(png, file = "plotpm_coal.png")

#close plot device
dev.off()