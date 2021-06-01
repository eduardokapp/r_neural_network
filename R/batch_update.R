batch_update <- function(x, y, eta, network) {
  # Initialize nabla_b and nabla_w
  nabla_b <- lapply(seq_len(network$n_layers), function(layer) {
    return(
      matrix(
        0,
        nrow = network$layers[[layer]]$n_neurons,
        ncol = 1
      )
    )
  })
  nabla_w <- lapply(seq_len(network$n_layers), function(layer) {
    return(
      matrix(
        0,
        nrow = network$layers[[layer]]$n_neurons,
        ncol = network$layers[[layer]]$n_inputs
      )
    )
  })

  # For every input/output case in the batch, we'll backpropagate errors
  # and update the adjustments to the weights and biases with nabla_w and
  # nabla_b
  for (case in seq_len(ncol(x))) {
    adjustments <- backpropagate(
      input = x[, case],
      output = y[, case],
      network
    )
    delta_nb <- adjustments$nabla_b
    delta_nw <- adjustments$nabla_w
    nabla_b <- mapply(sum, nabla_b, delta_nb)
    nabla_w <- mapply(sum, nabla_w, delta_nw)
  }

  # Update every layer weights and biases with nabla_w and nabla_b
  for (layer in seq_len(network$n_layers)) {
    network$layers[[layer]]$weights <- network$layers[[layer]]$weights -
      (eta / ncol(x)) * nabla_w[[layer]]
    network$layers[[layer]]$biases <- network$layers[[layer]]$biases -
      (eta / ncol(x)) * nabla_b[[layer]]
  }

  return(network)
}
