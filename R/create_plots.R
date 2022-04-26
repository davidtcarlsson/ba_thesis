plot_models <- function(data, cost_funs, alpha) {
  # Plots the models for a given alpha
  preds <- model_preds(data = data, cost_funs = cost_funs, alpha = alpha)
  preds_m <- melt(preds, id.vars = "x", measure.vars = -c(1, 2))
  
  ggplot() +
    geom_line(data = preds, aes(x, y)) + 
    geom_line(data = preds_m, aes(x = x, y = value, col = variable)) +
    labs(title = paste("Dataset ", comment(data),", alpha = ", alpha, sep = ""), col = "Method")
}

plot_cost_funs <- function(xlim, alpha) {
  Error <- seq(xlim[1], xlim[2], by = 0.01)
  df <- data.frame(
    Error,
    OLS = Error^2,
    LAD = abs(Error),
    LinLin = ifelse(Error > 0, alpha * Error, abs(Error)),
    QuadQuad = ifelse(Error > 0, alpha * Error^2, Error^2)
  )
  
  df_m <- melt(df, id.vars = "Error", measure.vars = c(-1))
  
  ggplot() +
    geom_line(data = df_m, aes(x = Error, y = value, col = variable)) +
    labs(title = paste("Shape of the different loss functions,", "alpha =", alpha), y = "Loss", col = "Methods")
}