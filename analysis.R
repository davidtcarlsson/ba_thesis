library(tidyverse)
library(reshape2)
source("R/utilities.R")
source("R/generate_data.R")
source("R/cost_functions.R")
source("R/create_plots.R")

set.seed(2022)

# Lets create a two datasets
# - df1: Random walk 
# - df2: Linear with normal error
sample_size <- 50
df1 <- generate_rw(N = sample_size, x0 = 0, mu = 1, variance = 5)
df2 <- generate_lin(N = sample_size, x0 = 0, mu = 0, variance = 5)

ggplot() +
  geom_line(data = df1, aes(x, y, col = "Dataset 1")) +
  geom_line(data = df2, aes(x, y, col = "Dataset 2")) +
  labs(title = "Simulated datasets", col = "")

# Parameters used for the first dataset
data <- df1
cost_funs <- c(ols, lad, linlin, quadquad)

# Table where we use the linlin as the evaluation metric
create_table(data = data, 
             cost_funs = cost_funs, 
             alphas = c(1, 2, 5, 10, 50), 
             metric = linlin)

# Table where we use the quadquad as the evaluation metric
create_table(data = data, 
             cost_funs = cost_funs, 
             alphas = c(1, 2, 5, 10, 50), 
             metric = quadquad)

# We can also plot the models for a given alpha
plot_models(data = data,
            cost_funs = cost_funs,
            alpha = 50)

# Parameters used for the second dataset
data <- df2
cost_funs <- c(ols, lad, linlin, quadquad)

# Table where we use the linlin as the evaluation metric
create_table(data = data, 
             cost_funs = cost_funs, 
             alphas = c(1, 2, 5, 10, 50), 
             metric = linlin)

# Table where we use the quadquad as the evaluation metric
create_table(data = data, 
             cost_funs = cost_funs, 
             alphas = c(1, 2, 5, 10, 50), 
             metric = quadquad)

# We can also plot the models for a given alpha
plot_models(data = data,
            cost_funs = cost_funs,
            alpha = 5)
