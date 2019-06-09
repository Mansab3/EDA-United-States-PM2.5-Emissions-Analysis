# EPA course assigment
# exdata_data_NEI_data
# Plot  for PM2.5 level for Baltimore city, Maryland
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds") 
SC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

colSums(is.na(NEI)) # Ensure output isn't impacted by NA's
colSums(is.na(SCC)) # Ensure output isn't impacted by NA's


# Group dataset by year and source type after filtering only baltimore city records
NEIP <- NEI %>% filter(fips == "24510") %>% group_by(year,type)

# Summarize data by emission mean
PLT <- data.frame(summarise(NEIP, emis = mean(Emissions, na.rm = TRUE)))

# Plot ggplot for 4 source type for baltimore city
graphics.off()

ggplot(data = PLT,aes(x = PLT$year,y = PLT$emis)) +
    geom_line() +
    facet_wrap(PLT$type ~ ., nrow = 2, ncol =2) +
    geom_smooth(method = "lm" , se = FALSE , col = "steelblue") +
    labs(x = " Year") +
    labs(y = " PM2.5") +
    ggtitle("Baltimore PM2.5 level, by type")

# copy graph into png file
dev.copy(png, file = "plotpm_baltcat.png")

#close plot device
dev.off()
