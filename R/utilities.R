prediction <- function(data, par) {
  # Univariate linear model
  par[1] + par[2] * data$x
}

model_preds <- function(data, cost_funs, alpha) {
  for (fun in cost_funs) {
    coef <- optim(par = c(0, 0), fn = fun()$cost, alpha = alpha, data = data)$par
    data[fun()$name] <- list(prediction(data, coef))
  }

  comment(data) <- toString(alpha)
  data
}

model_eval <- function(preds, metric) {
  alpha <- as.numeric(attr(x = preds, which = "comment"))
  result <- data.frame(col_name = metric()$metric(preds, alpha))
  colnames(result) <- paste("a=", alpha, sep = "")
  result
}

create_table <- function(data, cost_funs, alphas, metric) {
  output_table <- matrix(nrow = length(cost_funs), ncol = 0)
  print(paste("Metric used:", metric()$name))
  for (a in alphas) {
    preds <- model_preds(data = data, cost_funs = cost_funs , alpha = a)
    eval <- model_eval(preds = preds, metric = metric)
    output_table <- cbind(output_table, eval)
  }
  
  output_table
}