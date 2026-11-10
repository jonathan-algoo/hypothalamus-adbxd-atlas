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
callr_run("./2_microglia umap coords.Rmd")
callr_run("./3_create h5ads for scired.Rmd")
system("/opt/miniconda3/bin/conda run -n scired jupyter execute ./4_scired.ipynb")
callr_run("./5_analyze factors microglia.Rmd")
callr_run("./6_microglia consensus proportion plot.Rmd")
callr_run("./7_merfish_validation_microglia.Rmd")



