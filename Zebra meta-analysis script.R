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
Pathogenname <- c("AHSV","AKAV","Anaplasma","B_anthracis","B.caballi","BPV1",
                  "BPV2","CCHFV","Cryptosporidium","EAV","EEV","EHV1","EHV2",
                  "EHV4","EHV9","N.caninum","Rickettsia","T.equi","WSLV")
Pathogenname_dat <- read_excel("your data", 
                               +     sheet = Pathogenname)

#Function for meta-analysis
Pathogenname_meta <- metaprop(event = Ee, n = Ne, studlab = Reference, 
                              data = Pathogenname_dat, method.ci = "CP", 
                              method.tau = "SJ", hakn = TRUE, sm = "PFT", 
                              backtransf = TRUE, method = "Inverse", 
                              comb.random = TRUE, comb.fixed = FALSE, 
                              prediction = TRUE)

#Function for subgroup analysis
Pathogenname_subgroup <- update.meta(Pathogenname_meta, 
                                     byvar = Diagnostic_method)
         
#Function for forest plot
forest.meta(Pathogenname_subgroup, sortvar = TE, overall = TRUE, 
            text.random.w = c("Ab tests pooled estimate", 
                              "Molecular tests pooled estimate", 
                              "Pathogen id pooled estimate"), 
            text.random = "Overall pooled estimate", xlim = c(0, 1), 
            leftlabs = c("Study", "Positive", "Sample size"), 
            rightlabs = c("Prevalence", "95% CI", "Weight"), 
            print.I2.ci = TRUE, col.diamond = "blue", col.predict = "black", 
            col.by = "black", print.subgroup.labels = TRUE, print.tau2 = FALSE, 
            pooled.totals = FALSE, text.subgroup.nohet = FALSE)

#Functions to evaluate publication bias
funnel(Pathogenname_meta, xlab = "Freeman-Tukey Transformed Proportion", 
       studlab = TRUE)
eggers.test(x = Pathogenname_meta)
pcurve(Pathogenname_meta)
