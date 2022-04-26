generate_rw <- function(N, x0, mu, variance) {
  z <- cumsum(rnorm(n = N, mean = 0, sd = sqrt(variance)))
  t <- 1:N
  y <- x0 + t * mu + z
  
  data.frame(
    x = t,
    y
  )
}

generate_lin <- function(N, x0, mu, variance) {
  t <- 1:N
  y <- x0 + t + rnorm(N, mean = mu, sd = sqrt(variance))
  
  data.frame(
    x = t,
    y
  )
}

