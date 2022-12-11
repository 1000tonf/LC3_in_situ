library(dplyr)

#Create Image, Mean Intensity table
columns = c("Image", "Cell_1", "Cell_2", "Cell_3", "Cell_4", "Cell_5", "BG")
AB159_LC3 <- data.frame(matrix(nrow =0, ncol=length(columns)))

n <- c(1:2, 4:7, 9:14, 17:29)

n <- c(1:2, 4:14, 17:29)

for (i in c(n)) {
  file_name = paste("AB159_LC3_", i, ".csv", sep="")
  read.csv(file_name) -> AB159_LC3_X
  AB159_LC3_X$Mean -> AB159_LC3_row_X
    if (length(AB159_LC3_row_X)< 6) {
    AB159_LC3_row_X <- c(NA, AB159_LC3_row_X)
  }
  AB159_LC3_row_X <- c(i, AB159_LC3_row_X)
  AB159_LC3 %>% rbind(AB159_LC3_row_X) -> AB159_LC3
}

colnames(AB159_LC3) = columns

AB159_LC3 %>% 
  mutate(Cell_1_no_BG = Cell_1 - BG,
                     Cell_2_no_BG = Cell_2 - BG,
                     Cell_3_no_BG = Cell_3 - BG,
                     Cell_4_no_BG = Cell_4 - BG,
                     Cell_5_no_BG = Cell_5 - BG,
                    ) %>%
  mutate(Mean_int = rowMeans(select(AB159_LC3, 8:12), na.rm = TRUE))-> AB159_LC3

hist(AB159_LC3$Mean_int)

write.csv(AB159_LC3, "AB159_LC3.csv")
