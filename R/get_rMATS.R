#' retrieve path to an rMATS gzipped tar archive after retrieving from DRS Hub
#' @importFrom dplyr filter pull select
#' @param target character(1) a symbol for a gene coding for an RNA binding protein, defaults to "CTCF",
#' which likely needs to be combined with a disambiguating string regexp"
#' @param outputBasename character(1) string to which .tgz will be appended after retrieval
#' @return characer(1) path to .tgz result
#' @examples
#' ex = "ZNF800-BGRSLV02-RS293"
#' path = get_rMATS_tgz(ex)
#' path
#' tf = tempfile()
#' untar(path, exdir=tf)
#' lkd = dir(tf, recursive=TRUE, full=TRUE)
#' a3SS = grep("A3SS", lkd, value=TRUE)
#' z = data.table::fread(a3SS)
#' length(unique(z$geneSymbol[z$PValue < .001]))
#' @export
get_rMATS_tgz = function(target = "CTCF", outputBasename=tempfile()) {
 avf = avtable("anvil_file")
 target = paste0(target, ".*rMATS")
 allrm = avf |> dplyr::filter(grepl(target, file_name)) |> as.data.frame() 
 if (nrow(allrm)>1) {
   warning(sprintf("you must provide unique target for rMATS extraction, filter produced %d rows", nrow(allrm)))
   return(invisible(allrm))
   }
 outputFile = paste0(outputBasename, ".tgz")
 allrm$file_ref |> AnVILGCP::drs_hub() |> dplyr::select(accessUrl) |> dplyr::pull() |> curl::curl_fetch_disk(path=outputFile) 
 outputFile
}
