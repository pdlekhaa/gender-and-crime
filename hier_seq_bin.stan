data {
  int<lower=0> J;         // number of clusters (24 time blocks)
  int y[J];               // number of "1"s in each cluster
  int N[J];               // sample size for each cluster
  vector<lower=0, upper=1>[J] mus;  // prior mean per block
}
parameters {
  vector<lower=0, upper=1>[J] theta;   // cluster-specific probabilities
//  real<lower=0, upper=1> mu;     // overall mean probability
  real<lower=0> kappa;           // overall concentration
}
model {
  y ~ binomial(N, theta);              // each observation is binomial
  theta ~ beta_proportion(mus, kappa);  // prior; Beta2 dist
//  mu ~ beta(2, 7);           // weak prior
  kappa ~ gamma(.01, .01);       // prior recommended by Kruschke
}
generated quantities {
  vector[J] log_lik; // 24 hours = 24 data points

  for (j in 1:J) {
    log_lik[j] = binomial_lpmf(y[j] | N[j], theta[j]);
  }
}


