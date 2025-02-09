% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{annotate_specific_panel}
\alias{annotate_specific_panel}
\title{Utility function  to insert NA's According to Panel}
\usage{
annotate_specific_panel(
  binary_matrix,
  panel_id,
  samples_in_panel,
  na_genes,
  ...
)
}
\arguments{
\item{binary_matrix}{a processed binary matrix}

\item{panel_id}{name of gene panel}

\item{samples_in_panel}{samples to be annotated for each panel}

\item{na_genes}{genes to make NA}

\item{...}{other args passed}
}
\value{
an annotated data frame
}
\description{
Utility function  to insert NA's According to Panel
}
