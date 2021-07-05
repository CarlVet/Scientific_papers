####################################
# Carlo Andrea Cossu               #
# http://github.com/CarlVet        #
####################################

#Load R packages for meta-analysis
library(dmetar)
library(metafor)
library(meta)

#Load data from Mendeley Data
library(readxl)
"Pathogenname_test"_dat <- read_excel("Mendeley data", 
                               +     sheet = "Pathogenname_test")

#Function for meta-analysis
"Pathogenname_test"_meta <- metaprop(event = Ee, n = Ne, studlab = Reference, 
                              data = "Pathogenname_test"_dat, method.ci = "CP", 
                              method.tau = "SJ", hakn = TRUE, sm = "PFT", 
                              backtransf = TRUE, method = "Inverse", 
                              comb.random = TRUE, comb.fixed = FALSE, 
                              prediction = TRUE)
         
#Function for forest plot
forest.meta("Pathogenname_test"_meta, sortvar = w.random, overall = TRUE, 
            text.random = "Test pooled estimate", xlim = c(0, 1), 
            leftlabs = c("Study", "Positive", "Tested"), 
            rightlabs = c("Prevalence", "95% CI", "Weight"), 
            print.I2.ci = TRUE, col.diamond = "blue", col.predict = "black", 
            col.by = "black", print.tau2 = FALSE, 
            pooled.totals = TRUE, text.subgroup.nohet = FALSE)

#Functions to evaluate publication bias
funnel("Pathogenname_test"_meta, xlab = "Freeman-Tukey Transformed Proportion", 
       studlab = TRUE)
eggers.test(x = "Pathogenname_test"_meta)
trimfill.meta("Pathogenname_test"_meta)
