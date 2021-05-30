#' @title Create a network layer
#' @description This function generates a layer object
#' represented as a list. The list contains all the
#' information about the layer, such as number of inputs,
#' weights and biases for every neuron in it.
#' @param size The layer size, which is the number of neurons (integer)
#' @param n_inputs The number of inputs to each neuron in the layer (integer)
#' @param weights A weight array associated with each neuron. Note that
#' the size of this array should be (size, n_inputs), where size is the
#' number of neurons and n_inputs is the number of inputs to this
#' layer. (matrix)
#' @param biases A bias array associated with each neuron. Note that
#' the size of this array should be (size, 1), where size is the number
#' of neurons. (matrix)
#' @param activation What activation function should be used. Default: sigmoid
#' (function)
#' @author Eduardo Kapp
#' @returns A network layer object represented as a list.
create_layer <- function(
  size,
  n_inputs,
  weights,
  biases,
  activation = sigmoid
) {
  # Arg check
  if (!is.numeric(size))
    stop("'size' should be an integer")
  if (!is.integer(size))
    stop("'size' should be an integer")
  if (!is.numeric(n_inputs))
    stop("'n_inputs' should be an integer")
  if (!is.integer(n_inputs))
    stop("'n_inputs' should be an integer")
  if (!is.matrix(weights))
    stop("'weights' should be a matrix")
  if (!is.matrix(biases))
    stop("'biases' should be a matrix")
  if (nrow(weights) != size)
    stop("The number of rows in weights should be equal to 'size'")
  if (ncol(weights) != n_inputs)
    stop("The number of columns in weights should be equal to 'n_inputs'")
  if (nrow(biases) != size)
    stop("The number of columns in biases should be equal to 'size'")
  layer <- list(
    n_neurons = size,
    n_inputs = n_inputs,
    weights = weights,
    biases = biases,
    activation = activation
  )
  return(layer)
}
