data {
  int<lower=0> N;               
  array[N] real gdp_per_capita;
  array[N] real labor_force;
  array[N] real contaceptive_prevalence;
  array[N] real fertility_rate;
  real mu_alpha;
  real sig_alpha;
  real mu_beta;
  real sig_beta;
  real<lower=0> rate;
}

parameters {
  real<lower=0> alpha;
  real<lower=0> beta_var;
}

model {
  alpha ~ normal(mu_alpha, sig_alpha);
  beta_var ~ normal(mu_beta, sig_beta);

  for (j in 1:N) {
    real shape_adjust = (alpha + beta_var * (gdp_per_capita[j] + labor_force[j] + contaceptive_prevalence[j]));
    fertility_rate[j] ~ gamma(shape_adjust, rate);
  }
}

generated quantities {
  array[N] real y_pred;
  array[N] real log_likelihood;
  for (j in 1:N) {
    real shape_adjusted = (alpha + beta_var * (gdp_per_capita[j] + labor_force[j] + contaceptive_prevalence[j]));
    y_pred[j] = gamma_rng(shape_adjusted, rate);
    log_likelihood[j] = gamma_lpdf(fertility_rate[j] | shape_adjusted, rate);
  }
}