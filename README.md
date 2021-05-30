# Overview
This is my implementation of a neural network in R, structured as an 
R package that gives you the power to create and train neural networks.
It is mostly based around my core understand of what a neural network is and
is a personal-project only (unless..?).

# Features
Currently, this package supports network creation, network training and
predictions with a network object. The training is done using the MSE cost
function and the sigmoid activation function.

## The Network Object
A network is described as overall information (input size, output
size and number of layers) but also includes every layer it has. You can easily
access and check a specific layer weights, biases by doing:

```
# say you want to check layer 3
some_layer <- my_network$layers[[3]]
# weights
some_layer$weights

# biases
some_layers$biases
```

To find out more about it, read the docs.

## Features TODO:
- Add more cost functions and activation functions
- Add more control over the training process

# Examples
A very simple example of creating and training a network:

```
# Generate random data
n_samples <- 1000
inputs <- matrix(runif(n_samples * 10, 0, 1), nrow = 10, ncol = n_samples)
outputs <- matrix(runif(n_samples * 2, 0, 1), nrow = 2, ncol = n_samples)

# Create network object
network <- create_network(10, n_layers = 3, layer_sizes = c(24, 24, 2))

# Train the network
trained_network <- train_network(
  network,
  as.matrix(inputs),
  as.matrix(outputs),
  50,
  100,
  0.1
)

# Make predictions
network_outputs <- predict(trained_network, inputs)
```

# Package TODOs:
- Add Badges
- Add tests
- Add CI/CD
- Add examples

# Author
Eduardo Kapp
