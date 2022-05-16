plot_models <- function(data, cost_funs, alpha) {
  # Plots the models for a given alpha
  preds <- model_preds(data = data, cost_funs = cost_funs, alpha = alpha)
  preds_m <- melt(preds, id.vars = "x", measure.vars = -c(1, 2))
  
  ggplot() +
    geom_line(data = preds, aes(x, y)) + 
    geom_line(data = preds_m, aes(x = x, y = value, col = variable)) +
    labs(title = paste("Dataset ", comment(data),", alpha = ", alpha, sep = ""), x = "t", col = "Loss function")
}

plot_loss_funs <- function(xlim, alpha) {
  Error <- seq(xlim[1], xlim[2], by = 0.01)
  df <- data.frame(
    Error,
    "Squared loss" = Error^2,
    "Absolute loss" = abs(Error),
    "QuadQuad loss" = ifelse(Error > 0, alpha * Error^2, Error^2),
    "LinLin loss" = ifelse(Error > 0, alpha * Error, abs(Error))
  )
  
  df_m <- melt(df, id.vars = "Error", measure.vars = c(-1))
  
  ggplot() +
    geom_line(data = df_m, aes(x = Error, y = value, col = variable)) +
    labs(title = paste("Shape of the different loss functions,", "alpha =", alpha), y = "Loss", col = "Loss function") +
    scale_colour_discrete(labels = c("Squared loss", 
                                     "Absolute loss", 
                                     "QuadQuad loss", 
                                     "LinLin loss"))
}

plot_a_loss <- function(xlim, loss_fun, alphas) {
  Error <- seq(xlim[1], xlim[2], by = 0.5)
  df <- data.frame(Error)
  
  if (identical(loss_fun, lad) || identical(loss_fun, ols)) {
    df["0"] <- loss_fun()$loss(df$Error, alpha)
    df_m <- melt(df, id.vars = "Error", measure.vars = c(-1))
    ggplot() +
      geom_line(data = df_m, aes(x = Error, y = value), alpha = 0.7, lwd = 1) +
      labs(title = loss_fun()$name, y = "Loss")
  } else {
    for (alpha in rev(alphas)) {
      df[paste(alpha)] <- loss_fun()$loss(df$Error, alpha)  
    }
    df_m <- melt(df, id.vars = "Error", measure.vars = c(-1))
    ggplot() +
      geom_line(data = df_m, aes(x = Error, y = value, col = variable), alpha = 0.7, lwd = 1) +
      labs(title = loss_fun()$name, y = "Loss", col = "Alpha")
  }
  
}

plot_loss_alpha <- function(data, xlim, cost_funs, metric) {
  alphas <- seq(xlim[1], xlim[2], by = 1)
  create_table(data = data, 
               cost_funs = cost_funs, 
               alphas = alphas, 
               metric = metric
  ) -> df
  # Now lets change the dataframe so that we are able to plot it
  df %>% 
    t %>% 
    as.data.frame %>% 
    mutate(alpha = alphas) %>%
    melt(., id.vars = "alpha") -> df_m
  
  ggplot() +
    geom_line(data = df_m, aes(x = alpha, y = value, col = variable)) +
    labs(title = paste("Dataset ", comment(data), ": Mean ", tolower(strsplit(metric()$name, " ")[[1]][1]), " error ", "vs alpha", sep = ""), 
         y = paste("Mean", tolower(strsplit(metric()$name, " ")[[1]][1]), "error"), 
         x = "Alpha", col = "Loss function")
}


