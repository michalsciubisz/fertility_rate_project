data {
  int<lower=0> N;               
  array[N] real gdp_per_capita;
  array[N] real labor_force;
  array[N] real contaceptive_prevalence;
  real mu_alpha;
  real sig_alpha;
  real mu_beta;
  real sig_beta;
  real<lower=0> rate;
}

generated quantities {
  real alpha = normal_rng(mu_alpha, sig_alpha);
  real beta_var = normal_rng(mu_beta, sig_beta);

  array[N] real y_pred;
  for (j in 1:N) {
    real shape_adjusted = (alpha + beta_var * (gdp_per_capita[j] + labor_force[j] + contaceptive_prevalence[j]));
    y_pred[j] = gamma_rng(shape_adjusted, rate);
  }
}