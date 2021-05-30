#' @title Sigmoid Activation Unit
#' @description Activation functin based on a half-rectifier.
#' @param inputs An array.
#' @author Eduardo Kapp
#' @returns An array with the same size of the inputs.
sigmoid <- function(inputs) {
  return(1.0 / (1.0 + exp(-inputs)))
}

#' @title Sigmoid Activation Unit Derivative
#' @description This is a recursive implementation of the sigmoid derivative.
#' @param inputs An array.
#' @author Eduardo Kapp
#' @returns An array with the same size of the inputs.
sigmoid_prime <- function(inputs) {
  return(sigmoid(inputs) * (1 - sigmoid(inputs)))
}
