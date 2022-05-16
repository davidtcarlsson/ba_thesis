generate_rw <- function(N, step_size) {
  t <- seq(0, N, by = step_size)
  y <- c(0, cumsum(rnorm(N / step_size))) * sqrt(step_size)

  data.frame(
    x = t,
    y
  )
}



