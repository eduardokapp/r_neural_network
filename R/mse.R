#' @title Mean Squared Error
#' @description An alternative MSE implementation where
#' the mean is halved. That is done in order to make the
#' derivative easier to calculate in the backpropagation
#' algorithm, as the derivative of 1/2n*(sum(y-h)^2) is then
#' simply (h-y).
#' @details Note that y and h need to have the same
#' dimensions.
#' @param y An array (matrix)
#' @param h An array (matrix)
#' @author Eduardo Kapp
mse <- function(y, h) {
  return(mean((y - h)^2) / 2)
}

#' @title Derivative of the Mean Squared Error
#' @description This implementation is the derivative of the alternate MSE.
#' @param y An array (matrix)
#' @param h An array (matrix)
#' @details Note that y and h need to have the same
#' dimensions.
#' @author Eduardo Kapp
mse_prime <- function(y, h) {
  return(h - y)
}
