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

setwd("./hypoad_prepro/")
callr_run("./1_hypoad qc from initial rds.Rmd")
setwd("./..")
callr_run("1_microglia validation hypoad.Rmd")
callr_run("2_create human astrocyte h5ad.Rmd")
callr_run("3_create mouse astrocyte h5ad.Rmd")
callr_run("4_astrocyte validation hypoad.Rmd")
