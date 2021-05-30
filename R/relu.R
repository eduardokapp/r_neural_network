#' @title Rectified Linear Unit
#' @description Activation functin based on a half-rectifier.
#' @param inputs An array
#' @author Eduardo Kapp
#' @returns An array with the same size of the input array.
relu <- function(inputs) {
  inputs[inputs <= 0] <- 0
  return(inputs)
}
