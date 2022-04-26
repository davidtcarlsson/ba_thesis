ols <- function() {
  list(
    name = "OLS", 
    cost = function(data, par, alpha) sum((data$y - prediction(data, par))^2),
    metric = function(preds, alpha) colMeans((preds$y - preds[-c(1, 2)])^2)
  )
}

lad <- function() {
  list(
    name = "LAD", 
    cost = function(data, par, alpha) sum(abs(data$y - prediction(data, par))),
    metric = function(preds, alpha) colMeans(abs(preds$y - preds[-c(1, 2)]))
  )
}

linlin <- function() {
  list(
    name = "LinLin",
    cost = function(data, par, alpha) {
      resids <- data$y - prediction(data, par)
      sum(abs(ifelse(resids > 0, alpha * resids, resids)))
    },
    metric = function(preds, alpha) {
      resids <- as.matrix(preds$y - preds[-c(1, 2)])
      colMeans(abs(ifelse(resids > 0, alpha * resids, resids)))
    }
  )
}

quadquad <- function() {
  list(
    name = "QuadQuad",
    cost = function(data, par, alpha) {
      resids <- data$y - prediction(data, par)
      sum(ifelse(resids > 0, alpha * resids^2, resids^2))
    },
    metric = function(preds, alpha) {
      resids <- as.matrix(preds$y - preds[-c(1, 2)])
      colMeans(ifelse(resids > 0, alpha * resids^2, resids^2))
    }
  )
}