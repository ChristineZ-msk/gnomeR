% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/oncoprint.R
\name{dat_oncoprint}
\alias{dat_oncoprint}
\title{Enables creation of a matrix used to generate an OncoPrint heatmap.}
\usage{
dat_oncoprint(gen_dat, clin_dat = NULL)
}
\arguments{
\item{gen_dat}{A binary matrix or dataframe, with samples as rows and features as columns. Note that the names of the
columns must end in ".Del" or ".Amp" to recognize copy number alterations. (see create.bin.matrix for more details on this format).}

\item{clin_dat}{An optional clinical file, including only the features the user wishes to add to the plot. Default is NULL.}
}
\value{
mat : a matrix ready to be plotted using plot.Oncoprint().
}
\description{
Enables creation of a matrix used to generate an OncoPrint heatmap.
}
\examples{
library(gnomeR)
library(dplyr)
library(dtplyr)
samples <- as.character(unique(mut$Tumor_Sample_Barcode))
bin.mut <- binary_matrix(samples = samples, mutation = mut,
mut_type = "SOMATIC",
snp_only = FALSE, include_silent = FALSE, specify_panel = "no")
gen_dat <- bin.mut[1:500,
names(sort(apply(bin.mut,2, sum), decreasing = TRUE))[1:15]]
dat <- dat_oncoprint(gen_dat)

## adding clinical ##
clin.patients.dat <-
clin.patients[match(abbreviate(rownames(gen_dat),
strict = TRUE, minlength = 9),
clin.patients$X.Patient.Identifier),] \%>\%
dplyr::rename(DMPID = X.Patient.Identifier,
 Smoker = Smoking.History) \%>\%
  dplyr::select(DMPID, Sex,Smoker) \%>\%
  dplyr::filter(!is.na(DMPID)) \%>\%
  dplyr::distinct(DMPID,.keep_all = TRUE)
gen_dat <- gen_dat[match(clin.patients.dat$DMPID,
abbreviate(rownames(gen_dat),strict = TRUE, minlength = 9)),]
clin.patients.dat <- clin.patients.dat \%>\%
dplyr::mutate(DMPID = as.character(DMPID)) \%>\%
  tibble::rownames_to_column("to_rm") \%>\%
  select(-one_of("to_rm")) \%>\%
  tibble::column_to_rownames('DMPID')
rownames(gen_dat) <- rownames(clin.patients.dat)
dat <- dat_oncoprint(gen_dat = gen_dat, clin_dat = clin.patients.dat)
}
