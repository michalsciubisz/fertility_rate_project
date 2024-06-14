// data {
//   int<lower=0> N;               
//   array[N] real gdp_per_capita;
//   real mu_alpha;
//   real sig_alpha;
//   real mu_beta;
//   real sig_beta;
//   real<lower=0> shape;
//   real<lower=0> rate;
// }

// generated quantities {
//   real<lower=0> alpha = normal_rng(mu_alpha, sig_alpha);
//   real<lower=0> beta_gdp = normal_rng(mu_beta, sig_beta);

//   array[N] real y_pred;
//   for (j in 1:N) {
//     real shape_adjusted = (shape + alpha + beta_gdp * gdp_per_capita[j]);
//     y_pred[j] = gamma_rng(shape_adjusted, rate);
//   }
// }

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

generated quantities {
  real<lower=0> alpha = normal_rng(mu_alpha, sig_alpha);
  real<lower=0> beta_gdp = normal_rng(mu_beta, sig_beta);

  array[N] real y_pred;
  for (j in 1:N) {
    real shape_adjusted = (shape + alpha + beta_gdp * gdp_per_capita[j]);
    y_pred[j] = gamma_rng(shape_adjusted, rate);
  }
}