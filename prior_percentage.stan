// data {
//   int<lower=0> N;               
//   array[N] real percentage_values;
//   real mu_alpha;
//   real sig_alpha;
//   real mu_beta;
//   real sig_beta;
//   real<lower=0> shape;
//   real<lower=0> rate;
// }

// parameters {
//   real<lower=0> alpha;
//   real<lower=0> beta_labor;
//   real<lower=0> scale_factor;
// }

// model {
//   alpha ~ normal(mu_alpha, sig_alpha);
//   beta_labor ~ normal(mu_beta, sig_beta);
//   scale_factor ~ normal(1, 0.1);
// }

// generated quantities {
//   array[N] real y_pred;
//   for (j in 1:N) {
//     real percentage_force_abs = scale_factor * percentage_values[j] / 100;
//     y_pred[j] = gamma_rng(shape, 1 / rate) + alpha + beta_labor * percentage_force_abs;
//   }
// }

data {
  int<lower=0> N;               
  array[N] real percentage_values;
  real mu_alpha;
  real sig_alpha;
  real mu_beta;
  real sig_beta;
  real<lower=0> shape;
  real<lower=0> rate;
}

parameters {
  real<lower=0> alpha;
  real<lower=0> beta_labor;
  real<lower=0> scale_factor;
}

model {
  alpha ~ normal(mu_alpha, sig_alpha);
  beta_labor ~ normal(mu_beta, sig_beta);
  scale_factor ~ normal(1, 0.1);
}

generated quantities {
  array[N] real y_pred;
  for (j in 1:N) {
    real percentage_force_abs = scale_factor * percentage_values[j] / 100;
    real shape_adjusted = (shape + alpha + beta_labor * percentage_force_abs);
    y_pred[j] = gamma_rng(shape_adjusted, rate);
  }
}