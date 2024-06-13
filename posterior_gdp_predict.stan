// data {
//   int<lower=0> N_predict;              
//   array[N_predict] real gdp_per_capita_predict;
//   real alpha_predict;
//   real beta_gdp_predict;
//   real<lower=0> shape;
//   real<lower=0> rate;
// }

// generated quantities {
//   array[N_predict] real y_pred;
//   for (j in 1:N_predict) {
//     real shape_adjusted = shape + alpha_predict + beta_gdp_predict * gdp_per_capita_predict[j];
//     y_pred[j] = gamma_rng(shape_adjusted, rate);
//   }
// }

data {
  int<lower=0> N_predict;              
  array[N_predict] real gdp_per_capita_predict;
  real alpha_predict;
  real beta_gdp_predict;
  real<lower=0> shape;
  real<lower=0> rate;
}

generated quantities {
  array[N_predict] real y_pred;
  for (j in 1:N_predict) {
    real shape_adjusted = shape + alpha_predict + beta_gdp_predict * 10000/gdp_per_capita_predict[j];
    y_pred[j] = gamma_rng(shape_adjusted, rate);
  }
}