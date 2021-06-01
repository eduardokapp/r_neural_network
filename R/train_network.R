#' @title Train a Network using Stochastic Gradient Descent
#' @description This function updates the network's weights and biases
#' by using the Stochastic Gradient Descent, a faster approach to the regular
#' Gradient Descent. The idea is that, for every iteration, training data is
#' shuffled and a number of batches are generated according to batch_size.
#' Then, the cost function is evaluated for every batch, thus updating the
#' weights and biases. This process is repeated for the number of iterations.
#' @param network A kappnet network object. (list)
#' @param train_x A matrix with inputs for the training examples. Its
#' dimensions are expected to be (input_size, number_of_observations)(matrix).
#' @param train_y A matrix with outputs for the training examples. Its
#' dimensions are expected to be (output_size, number_of_observations)(matrix).
#' @param batch_size The batch size. Note that batch size does not mean input
#' size, but number of examples or observations that are used to calculate
#' a round of weights and biases adjustment. (integer)
#' @param iters Number of iterations. Default: 1000 (integer)
#' @param eta The learning rate for the gradient descent.
#' Default: 0.1 (numeric)
#' @param verbose Whether or not the algorithm should print out
#' information during its run time. Default: TRUE (logical)
#' @details Note that train_x and train_y must be "aligned", that is, the first
#' column of train_x should relate to the first column of train_y, given that
#' the columns represent observations.
#' @author Eduardo Kapp
#' @return A trained network.
#' @export
train_network <- function(
  network,
  train_x,
  train_y,
  batch_size,
  iters = 1000,
  eta = 0.1,
  verbose = TRUE
) {
  if (!is.matrix(train_x))
    stop("'train_x' should be a matrix.")
  if (!is.matrix(train_y))
    stop("'train_y' should be a matrix.")
  if (ncol(train_x) != ncol(train_y))
    stop("Expected an output for every input on training data.")
  if (!is.list(network))
    stop("Invalid 'network' object passed.")
  if (!all(c("input_size", "output_size", "n_layers") %in% names(network)))
    stop("Invalid 'network' object passed.")
  if (!is.numeric(iters))
    stop("'iters' should be an integer.")
  if (!is.numeric(eta))
    stop("'eta' should be numeric.")
  if (eta <= 0)
    stop("'eta' should be greater than zero.")
  if (!is.logical(verbose))
    stop("'verbose' should be logical.")

  # Training process
  for (iter in seq_len(iters)) {
    # for every iteration, we need to shuffle data and select a few
    # batches according to batch_size
    shuffle_cols <- sample(ncol(train_x), ncol(train_x), replace = TRUE)
    train_x <- matrix(
      train_x[, shuffle_cols],
      nrow = nrow(train_x),
      ncol = ncol(train_x)
    )
    train_y <- matrix(
      train_y[, shuffle_cols],
      nrow = nrow(train_y),
      ncol = ncol(train_y)
    )
    batches <- seq(from = 1, to = ncol(train_x), by = batch_size)
    start <- 1
    end <- batch_size
    # Start adjustments process
    for (batch in batches) {
      # Determine batch indexes
      batch_x <- matrix(
        train_x[, start:end],
        nrow = nrow(train_x),
        ncol = batch_size
      )
      batch_y <- matrix(
        train_y[, start:end],
        nrow = nrow(train_y),
        ncol = batch_size
      )

      # Now perform backpropagation for this specific batch
      network <- batch_update(batch_x, batch_y, eta, network)

      start <- end + 1
      end <- end + batch_size
    }
    # Print out current MSE for train data
    if ((iter %% 10 == 0) && (verbose)) {
      train_outs <- apply(
        X = train_x,
        MARGIN = 2,
        FUN = function(x) {forward_pass(x, network)}
      )
      errors <- mapply(mse, as.data.frame(train_y), as.data.frame(train_outs))
      train_mse <- mean(errors)
      print(paste0("Iteration ", iter, " done."))
      print(paste0("Train MSE: ", train_mse))
    }

  }
  return(network)

}
