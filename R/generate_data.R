random_walk <- function(N, x0, mu, variance) {
  z <- cumsum(rnorm(n = N, mean = 0, sd = sqrt(variance)))
  t <- 1:N
  y <- x0 + t * mu + z
  
  data.frame(
    x = t,
    y = y
  )
}
