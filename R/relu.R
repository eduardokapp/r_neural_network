#' @title Rectified Linear Unit
#' @description Activation functin based on a half-rectifier.
#' @param inputs A matrix of size (1, n) (matrix)
#' @author Eduardo Kapp
#' @returns A matrix of size (1, n) (matrix)
relu <- function(inputs) {
  inputs[inputs <= 0] <- 0
  return(inputs)
}
