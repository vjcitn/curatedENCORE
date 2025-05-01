#' a set of gene symbols used in the DESeq2 artifacts in ENCORE data resourceson AnVIL
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

