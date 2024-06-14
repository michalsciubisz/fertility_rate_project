// data {
//   int<lower=0> N;               
//   array[N] real gdp_per_capita;
//   array[N] real labor_force;
//   array[N] real contaceptive_prevalence;
//   real mu_alpha;
//   real sig_alpha;
//   real mu_beta;
//   real sig_beta;
//   real<lower=0> shape;
//   real<lower=0> rate;
// }

// generated quantities {
//   real alpha = normal_rng(mu_alpha, sig_alpha);
//   real beta_var = normal_rng(mu_beta, sig_beta);
//   real scale_factor = normal_rng(1, 0.1);

//   array[N] real y_pred;
//   for (j in 1:N) {
//     real percentage_labor_abs = scale_factor * labor_force[j];
//     real percentage_contra_abs = scale_factor * contaceptive_prevalence[j];
//     real shape_adjusted = (shape + alpha + beta_var * (gdp_per_capita[j] + percentage_labor_abs + percentage_contra_abs));
//     y_pred[j] = gamma_rng(shape_adjusted, rate);
//   }
// }

data {
  int<lower=0> N;               
  array[N] real gdp_per_capita;
  array[N] real labor_force;
  array[N] real contaceptive_prevalence;
  real mu_alpha;
  real sig_alpha;
  real mu_beta;
  real sig_beta;
  real<lower=0> shape;
  real<lower=0> rate;
}

generated quantities {
  real alpha = normal_rng(mu_alpha, sig_alpha);
  real beta_var = normal_rng(mu_beta, sig_beta);

  array[N] real y_pred;
  for (j in 1:N) {
    real shape_adjusted = (shape + alpha + beta_var * (gdp_per_capita[j] + labor_force[j] + contaceptive_prevalence[j]));
    y_pred[j] = gamma_rng(shape_adjusted, rate);
  }
}