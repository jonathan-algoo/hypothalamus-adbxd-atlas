library(callr)
library(knitr)
library(reticulate)

#produces a new r process for each Rmd
callr_run = function(rmd_path) {
  callr::r(
    function(rmd_path) {
      source(knitr::purl(rmd_path, output = tempfile(fileext = ".R"), quiet = T))
      NULL #return null
    },
    args = list(rmd_path = rmd_path),
    show = TRUE,
    spinner = F
  )
  print(paste0("Done with file: ", rmd_path))
}

callr_run("./1_marker genes.Rmd")
callr_run("./2_run gsea gls astrocytes.Rmd")
callr_run("./3_gsea gls astrocytes pathway vis.Rmd")
callr_run("./4_astrocyte consensus proportion plot.Rmd")


