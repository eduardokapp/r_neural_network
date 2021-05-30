predict <- function(network, inputs) {
  outputs <- apply(inputs, MARGIN = 2, function(x) {forward_pass(x, network)})
  return(outputs)
}
