#' @title Sigmoid Activation Unit
#' @description Activation functin based on a half-rectifier.
#' @param inputs A matrix of size (1, n) (matrix)
#' @author Eduardo Kapp
#' @returns A matrix of size (1, n) (matrix)
sigmoid <- function(inputs) {
  return(1.0 / (1.0 + exp(-inputs)))
}
