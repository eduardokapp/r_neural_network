#' @title Create a neural network base structure
#' @description This function generates a network object
#' represented as a list. The list contains all the
#' information about the network, such as input size, output size,
#' number of hidden layers, hidden layers sizes.
#' @param input_size The network input size (integer)
#' @param n_layers Number of hidden layers to be used. Note that this
#' includes the output layer. (integer)
#' @param layer_sizes An array with the number of neurons for each layer.
#' For example, if there are two layers, each with 30 neurons,
#' then layer_sizes must be c(30, 30). (integer array)
#' @param activations An array indicating what activation functions should be
#' used for each layer. By default, sigmoid functions are used. (character)
#' @author Eduardo Kapp
#' @returns A network layer object represented as a list.
create_network <- function(
  input_size,
  n_layers = 1,
  layer_sizes = c(1),
  activations = c("sigmoid")
) {
  # Arg check
  if (!is.numeric(input_size))
    stop("'input_size' should be an integer")
  if (!is.numeric(n_layers))
    stop("'n_layers' should be an integer")
  if (!is.numeric(layer_sizes))
    stop("'layer_sizes' should be a numeric array")
  if (length(layer_sizes) != n_layers)
    stop("'layer_sizes' should have length equal to 'n_layers'")
  if (length(activations) != n_layers)
    activations <- rep("sigmoid", n_layers)
  if (!all(activations %in% c("sigmoid", "relu")))
    stop("Invalid activation function used for some layer.")

  # Define activation functions
  activations <- rapply(as.list(activations), function(x) {
    if (x == "relu")
      return(kappnet::relu)
    else
      return(kappnet::sigmoid)
  })

  # Initialize network
  network <- list(
    input_size = input_size,
    output_size = layer_sizes[length(layer_sizes)],
    n_layers = n_layers,
    layers = list()
  )

  # Create hidden layers and output layer
  layer_sequence <- seq_len(n_layers)
  for (layer in layer_sequence) {
    # define weights and biases for the current layer being created
    # with the exception of the first layer, all layers
    # have as input size the number of neurons of the last layer
    layer_inputs <- ifelse(
      layer == 1,
      input_size,
      layer_sizes[layer - 1]
    )
    # the weights matrix objects have dimensions (size, n_inputs)
    weights <- matrix(
      data = 1,
      nrow = layer_sizes[layer],
      ncol = layer_inputs
    )
    # the biases matrix objects have dimensions (size, 1)
    biases <- matrix(
      data = 1,
      nrow = layer_sizes[layer],
      ncol = 1
    )
    # Create the layer now that we have everything we need
    network$layers[[layer]] <- create_layer(
      size = as.integer(layer_sizes[layer]),
      n_inputs = as.integer(layer_inputs),
      weights = weights,
      biases = biases,
      activation = activations[[layer]]
    )
  }
  return(network)
}
