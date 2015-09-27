# Getting the step 5 tidy set.
library(data.table)

cleandata <- fread('clean/data.csv', header=F, colClasses=c(rep('numeric', 66), rep('factor', 2)))

cleandata$V67 <- as.factor(cleandata$V67)
cleandata$V68 <- as.factor(cleandata$V68)

subset <- cleandata[, lapply(.SD, mean), .(V67, V68)]

write.table(subset, file='clean/subset.csv', sep=',', col.names=F, row.names=F)
