library(foreign)

jph <- read.spss("../Data/SPSS of RCT dataset.sav", to.data.frame=TRUE)

# A function to calculate the standard deviation of change using sd of baseline and follow-up measures
sd_change <- function(base, final) {
  base_final_comp <- complete.cases(base, final)
  corr <- cor(base, final, use="pairwise.complete.obs")
  sd_base <- sd(base[base_final_comp==TRUE])
  sd_final <- sd(final[base_final_comp==TRUE])
  sd_change <- (sd_base^2 + sd_final^2 - (2 * corr * sd_base * sd_final))^0.5
  return(sd_change)
}

# Calculate the correlation coefficient of sd change, sd baseline and sd follow-up
cor_change <- function(sd_base, sd_follow, sd_change){
  cor_change<-(sd_base^2 + sd_follow^2 - sd_change^2)/(2*sd_base*sd_follow)
  return(cor_change)
}

bmisds_change_sd <- sd_change(jph$bmisds1, jph$bmisds2)

b_f_c_comp <- complete.cases(jph$bmisds1, jph$bmisds2, jph$changebmisds)
bmisds_change_cor <- cor_change(sd(jph$bmisds1[b_f_c_comp==TRUE]), sd(jph$bmisds2[b_f_c_comp==TRUE]), sd(jph$changebmisds[b_f_c_comp==TRUE]))