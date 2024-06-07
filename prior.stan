// data {
//   int<lower=0> N;
//   real gdp_per_capita[N];
// }

// parameters {
//   real alpha;
//   real beta_gdp;
//   real<lower=0> sigma;
// }

// model {
//   alpha ~ normal(0, 2.5);
//   beta_gdp ~ lognormal(0, 0.1);
//   sigma ~ normal(0, 2);
// }

// generated quantities {
//   real y_prior_pred[N];
//   for (n in 1:N){
//     y_prior_pred[n] = normal_rng(alpha + beta_gdp * gdp_per_capita[n], sigma);
//     }
// }

data {
  int N;
  real gdp_per_capita[N];
  real mu_alpha;
  real sig_alpha;
  real mu_beta;
  real sig_beta;
}

generated quantities {
  real alpha ~ normal(mu_alpha, sig_alpha);
  real beta_gdp ~ lognormal(mu_beta, sig_beta);
  real sigma ~ normal(0, 2);

  real<lower=0> y_pred[N];
  for (j in 1:N){
    y_pred[j] = normal_rng(alpha + beta_gdp * gdp_per_capita[j], sigma);
  }
}