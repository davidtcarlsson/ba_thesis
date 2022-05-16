ols <- function() {
  list(
    name = "Squared loss", 
    loss = function(error, alpha) error^2,
    cost = function(data, par, alpha) mean((data$y - prediction(data, par))^2),
    metric = function(preds, alpha) colMeans((preds$y - preds[-c(1, 2)])^2)
  )
}

lad <- function() {
  list(
    name = "Absolute loss", 
    loss = function(error, alpha) abs(error),
    cost = function(data, par, alpha) mean(abs(data$y - prediction(data, par))),
    metric = function(preds, alpha) colMeans(abs(preds$y - preds[-c(1, 2)]))
  )
}

linlin <- function() {
  list(
    name = "LinLin loss",
    loss = function(error, alpha) {
      ifelse(error > 0, alpha * error, abs(error))
    },
    cost = function(data, par, alpha) {
      resids <- data$y - prediction(data, par)
      mean(abs(ifelse(resids > 0, alpha * resids, resids)))
    },
    metric = function(preds, alpha) {
      resids <- as.matrix(preds$y - preds[-c(1, 2)])
      colMeans(abs(ifelse(resids > 0, alpha * resids, resids)))
    }
  )
}

quadquad <- function() {
  list(
    name = "QuadQuad loss",
    loss = function(error, alpha) {
      ifelse(error > 0, alpha * error^2, error^2)
    },
    cost = function(data, par, alpha) {
      resids <- data$y - prediction(data, par)
      mean(ifelse(resids > 0, alpha * resids^2, resids^2))
    },
    metric = function(preds, alpha) {
      resids <- as.matrix(preds$y - preds[-c(1, 2)])
      colMeans(ifelse(resids > 0, alpha * resids^2, resids^2))
    }
  )
}