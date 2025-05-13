
#' a set of gene symbols used in the DESeq2 artifacts in ENCORE data resourceson AnVIL
#' @rawNamespace importFrom("utils", "data", "packageDescription", "sessionInfo")
#' @import curl
#' @docType data
#' @note This list of RBPs was derived from names of files in the AnVIL DUOS data snapshot for ENCORE.
#' @format character()
"rbp_cands"

#' a DESeq2 result for ZNF317-BGRSDLV02-RS293_DESeq2
#' @docType data
#' @format data.frame
"demoDE"

#' an excerpt from GENCODE v40 catalog limited to "gene" entries for the `rbp_cands`, as GRanges instance
#' @docType data
#' @format GRanges
#' @note GRCh38 coordinates; a token "NT" in `rbp_cands` is not matched
"rbp_cands_gr"

#' an excerpt from GENCODE v40 catalog with `gene_name` matching `rbp_cands`; all types (transcripts, exons, ...), as GRanges instance
#' @docType data
#' @format GRanges
#' @note GRCh38 coordinates; a token "NT" in `rbp_cands` is not matched
"rbp_cands_txex"

#' an excerpt from GENCODE v40 catalog limited to type "gene" 
#' @docType data
#' @format GRanges
#' @note GRCh38 coordinates; a token "NT" in `rbp_cands` is not matched
"gencode.v40.fullgene"

# https://genomebiology.biomedcentral.com/articles/10.1186/s13059-020-01982-9#MOESM1
#' RNA binding protein function annotations, localization patterns, and predicted RNA binding domains.
#' @note Table S2 of PMID 32252787
#' @docType data
#' @note there is a mix of types even though data are 0/1 ... because of excel NA token.
#' @format data.frame
"annoRBP"
