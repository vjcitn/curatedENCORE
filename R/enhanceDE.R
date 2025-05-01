#' convert a data.frame with DESeq2 results from an ENCORE experiment to an annotated GRanges
#' @importFrom S4Vectors mcols "mcols<-" metadata metadata<-
#' @param deframe a data.frame instance with DESeq2 results
#' @param knockdown character(1) name of gene knocked down
#' @examples
#' data(demoDE)
#' dat = enhanceDE(demoDE, "ZNF317")
#' dat[order(dat$padj)]
#' @export
enhanceDE = function(deframe, knockdown) {
   if (missing(knockdown)) stop("must supply name of knocked-down RBP gene")
   data("gencode.v40.fullgene", package="curatedENCORE")
   names(gencode.v40.fullgene) = gencode.v40.fullgene$gene_id
   newgr = gencode.v40.fullgene[rownames(deframe)]
   stopifnot(all.equal(names(newgr), rownames(deframe)))
   mcols(newgr) = cbind(mcols(newgr), deframe)
   metadata(newgr) = list(knockdown=knockdown)
   newgr
}
