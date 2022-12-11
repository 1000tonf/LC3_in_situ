library(dplyr)

#Create Image, Mean Intensity table
columns = c("Image", "Mean Intensity")
AB159_LC3 <- data.frame(matrix(nrow =0, ncol=length(columns)))

n <- c(1:2, 4:7, 9:14, 17:29)

for (i in n) {
  file_name = paste("AB159_LC3_", i, ".csv", sep="")
  read.csv(file_name) -> AB159_LC3_X
  AB159_LC3_X$Mean[6] -> BG
  AB159_LC3_X %>% select(X, Mean) %>%
    filter(X < 6) %>% 
    mutate(Mean_BG = Mean - BG) -> AB159_LC3_X
  AB159_LC3_row_X <- c(i, mean(AB159_LC3_X$Mean_BG))
  colnames(AB159_LC3) = columns
  AB159_LC3 %>% rbind(AB159_LC3_row_X) -> AB159_LC3
}

read.csv("AB159_LC3_8.csv") -> AB159_LC3_8
AB159_LC3_8$Mean[5] -> BG
AB159_LC3_8 %>% select(X, Mean) %>%
  filter(X < 5) %>% 
  mutate(Mean_BG = Mean - BG) -> AB159_LC3_8
AB159_LC3_row_X <- c(8, mean(AB159_LC3_X$Mean_BG))
AB159_LC3 %>% rbind(AB159_LC3_row_X) -> AB159_LC3
