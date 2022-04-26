plot_models <- function(data, cost_funs, alpha) {
  # Plots the models for a given alpha
  preds <- model_preds(data = data, cost_funs = cost_funs, alpha = alpha)
  preds_m <- melt(preds, id.vars = "x", measure.vars = -c(1, 2))
  
  ggplot() +
    geom_line(data = preds, aes(x, y)) + 
    geom_line(data = preds_m, aes(x = x, y = value, col = variable)) +
    labs(title = paste("Dataset ", comment(data),", alpha = ", alpha, sep = ""), col = "Method")
}
