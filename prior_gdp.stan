data {
  int<lower=0> N;               
  array[N] real gdp_per_capita;
  real mu_alpha;
  real sig_alpha;
  real mu_beta;
  real sig_beta;
  real<lower=0> shape;
  real<lower=0> rate;
}

parameters {
  real<lower=0> alpha;
  real<lower=0> beta_gdp;
}

model {
  alpha ~ normal(mu_alpha, sig_alpha); ##based on fertility rate
  beta_gdp ~ normal(mu_beta, sig_beta);
}

generated quantities {
  array[N] real y_pred;
  for (j in 1:N) {
    real shape_adjusted = (shape + alpha + beta_gdp * gdp_per_capita[j]);
    y_pred[j] = gamma_rng(shape_adjusted, rate);
  }
}