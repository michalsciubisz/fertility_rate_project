data {
  int<lower=0> N_predict;               
  array[N_predict] real gdp_per_capita;
  array[N_predict] real labor_force;
  array[N_predict] real contaceptive_prevalence;
  array[N_predict] real alpha_predict;
  array[N_predict] real beta_gdp_predict;
  real<lower=0> rate;
}

generated quantities {
  array[N_predict] real y_pred;
  for (j in 1:N_predict) {
    real shape_adjusted = (alpha_predict[j] + beta_gdp_predict[j] * (gdp_per_capita[j] + labor_force[j] + contaceptive_prevalence[j]));
    y_pred[j] = gamma_rng(shape_adjusted, rate);
  }
}