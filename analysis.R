library(tidyverse)
library(reshape2)
library(openxlsx)
source("R/utilities.R")
source("R/generate_data.R")
source("R/cost_functions.R")
source("R/create_plots.R")

set.seed(12)
theme_set(theme_classic(base_size = 16))

# Lets create a two datasets
# - df1: Random walk 
# - df2: Linear with normal error
sample_size <- 1000
step_size <- 1
df1 <- generate_rw(N = sample_size, step_size = step_size)
# Add a comment to the dataframe so that I can plot out its name
comment(df1) <- "1"

df2 <- generate_rw(N = sample_size, step_size = step_size)
comment(df2) <- "2"

# ggplot() +
#   geom_line(data = df1, aes(x, y, col = "Dataset 1")) +
#   geom_line(data = df2, aes(x, y, col = "Dataset 2")) +
#   labs(title = "Simulated datasets", col = "", x = "t")
#plot_save("simulated_datasets.png")

# Since we use the same cost functions throughout the analysis i will define them
# here
# cost_funs <- c(ols, lad, quadquad, linlin)
# alphas <- c(1, 2, 5, 10)
# 
# plot_loss_alpha(df1, cost_funs = cost_funs, c(1, tail(alphas, 1)), linlin) 
# plot_save("df1_loss_diff_alphas_linlin.png")
# 
# plot_loss_alpha(df1, cost_funs = cost_funs, c(1, tail(alphas, 1)), quadquad) 
# plot_save("df1_loss_diff_alphas_quadquad.png")
# 
# plot_loss_alpha(df2, cost_funs = cost_funs, c(1, tail(alphas, 1)), linlin) 
# plot_save("df2_loss_diff_alphas_linlin.png")
# 
# plot_loss_alpha(df2, cost_funs = cost_funs, c(1, tail(alphas, 1)), quadquad) 
# plot_save("df2_loss_diff_alphas_quadquad.png")
# 
# # Table where we use the linlin as the evaluation metric
# df1_eval_table_linlin <- create_table(data = df1, 
#                                   cost_funs = cost_funs, 
#                                   alphas = alphas, 
#                                   metric = linlin)
# write.xlsx(df1_eval_table_linlin, "output/df1_eval_table_linlin.xlsx", rowNames = TRUE)
# 
# # Table where we use the quadquad as the evaluation metric
# df1_eval_table_quadquad <- create_table(data = df1, 
#                                   cost_funs = cost_funs, 
#                                   alphas = alphas, 
#                                   metric = quadquad)
# write.xlsx(df1_eval_table_quadquad, "output/df1_eval_table_quadquad.xlsx", rowNames = TRUE)
# 
# # Table where we use the linlin as the evaluation metric
# df2_eval_table_linlin <- create_table(data = df2, 
#                                       cost_funs = cost_funs, 
#                                       alphas = alphas, 
#                                       metric = linlin)
# write.xlsx(df2_eval_table_linlin, "output/df2_eval_table_linlin.xlsx", rowNames = TRUE)
# 
# # Table where we use the quadquad as the evaluation metric
# df2_eval_table_quadquad <- create_table(data = df2, 
#                                         cost_funs = cost_funs, 
#                                         alphas = alphas, 
#                                         metric = quadquad)
# write.xlsx(df2_eval_table_quadquad, "output/df2_eval_table_quadquad.xlsx", rowNames = TRUE)
# 
# # We can also plot the models for a given alpha
# plot_models(data = df1,
#             cost_funs = cost_funs,
#             alpha = 1)
# plot_save("df1_alpha_1.png")
# 
# plot_models(data = df1,
#             cost_funs = cost_funs,
#             alpha = 2)
# plot_save("df1_alpha_2.png")
# 
# plot_models(data = df1,
#             cost_funs = cost_funs,
#             alpha = 5)
# plot_save("df1_alpha_5.png")
# 
# plot_models(data = df1,
#             cost_funs = cost_funs,
#             alpha = 10)
# plot_save("df1_alpha_10.png")
# 
# # Now lets do the same but for dataset 2
# plot_models(data = df2,
#             cost_funs = cost_funs,
#             alpha = 1)
# plot_save("df2_alpha_1.png")
# 
# plot_models(data = df2,
#             cost_funs = cost_funs,
#             alpha = 2)
# plot_save("df2_alpha_2.png")
# 
# plot_models(data = df2,
#             cost_funs = cost_funs,
#             alpha = 5)
# plot_save("df2_alpha_5.png")
# 
# plot_models(data = df2,
#             cost_funs = cost_funs,
#             alpha = 10)
# plot_save("df2_alpha_10.png")
# 
# # I also want to plot the different cost functions to get an idea of their shape
# plot_loss_funs(xlim = c(-5, 5), alpha = 2)
# plot_save("cost_funs_alpha_2.png")
# 
# plot_loss_funs(xlim = c(-5, 5), alpha = 5)
# plot_save("cost_funs_alpha_5.png")
# 
# plot_loss_funs(xlim = c(-5, 5), alpha = 10)
# plot_save("cost_funs_alpha_10.png")
# 
# plot_a_loss(c(-5, 5), ols, c(2, 5, 10))
# plot_save("ols_loss.png")
# 
# plot_a_loss(c(-5, 5), lad, c(2, 5, 10))
# plot_save("lad_loss.png")
# 
# plot_a_loss(c(-5, 5), linlin, c(2, 5, 10))
# plot_save("linlin_loss.png")
# 
# plot_a_loss(c(-5, 5), quadquad, c(2, 5, 10))
# plot_save("quadquad_loss.png")
# 
