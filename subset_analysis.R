# Getting the step 5 tidy set.
library(data.table)

data <- fread('clean/data.csv', header=F)
data[, lapply(.SD, mean), .(activity, subject)]

write.csv(data, file='clean/subset.csv', sep=',', row.names=F)
