library(tidyverse)
library(reshape2)
source("R/utilities.R")
source("R/generate_data.R")
source("R/cost_functions.R")
source("R/create_plots.R")

set.seed(2022)

# Lets create a dataset
sample_size <- 50
df1 <- random_walk(N = sample_size, x0 = 0, mu = 1, variance = 5)

preds_1 <- model_preds(data = df1, list(ols, lad, linlin), alpha = 2)
preds_2 <- model_preds(data = df1, list(ols, lad, linlin), alpha = 5)
preds_3 <- model_preds(data = df1, list(ols, lad, linlin), alpha = 10)

plot_models(preds_1)
plot_models(preds_2)
plot_models(preds_3)

model_eval(preds_1, list(linlin))
model_eval(preds_2, list(linlin))
model_eval(preds_3, list(linlin))
