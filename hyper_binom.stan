// Binomial model with beta(1,1) prior
data {
  int<lower=0> N; // number of experiments
  int<lower=0> y; // number of successes
  int<lower=0> alpha; //hyperparameter
  int<lower=0> beta; //hyperparameter
}
parameters {
  real<lower=0, upper=1> theta; // probability of success in range (0,1)
}
model {
  // model block creates the log density to be sampled
  theta ~ beta(alpha, beta); // prior
  y ~ binomial(N, theta); // observation model / likelihood
}
generated quantities {
  real log_lik;

  log_lik = binomial_lpmf(y | N, theta);
}

