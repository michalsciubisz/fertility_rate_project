// data {
//   int<lower=0> N_predict;               
//   array[N_predict] real gdp_per_capita;
//   array[N_predict] real labor_force;
//   array[N_predict] real contaceptive_prevalence;
//   real alpha_predict;
//   real beta_gdp_predict;
//   real scale_factor_predict;
//   real<lower=0> shape;
//   real<lower=0> rate;
// }

// generated quantities {
//   array[N_predict] real y_pred;
//   for (j in 1:N_predict) {
//     real percentage_labor_abs = scale_factor_predict * labor_force[j];
//     real percentage_contra_abs = scale_factor_predict * contaceptive_prevalence[j];
//     real shape_adjusted = (shape + alpha_predict + beta_gdp_predict * (gdp_per_capita[j] + percentage_labor_abs + percentage_contra_abs));
//     y_pred[j] = gamma_rng(shape_adjusted, rate);
//   }
// }

data {
  int<lower=0> N_predict;               
  array[N_predict] real gdp_per_capita;
  array[N_predict] real labor_force;
  array[N_predict] real contaceptive_prevalence;
  real alpha_predict;
  real beta_gdp_predict;
  real<lower=0> shape;
  real<lower=0> rate;
}

generated quantities {
  array[N_predict] real y_pred;
  for (j in 1:N_predict) {
    real shape_adjusted = (shape + alpha_predict + beta_gdp_predict * (10000/gdp_per_capita[j] + 100/labor_force[j] + 100/contaceptive_prevalence[j]));
    y_pred[j] = gamma_rng(shape_adjusted, rate);
  }
}