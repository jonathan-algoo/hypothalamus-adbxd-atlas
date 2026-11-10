library(callr)
library(knitr)

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

callr_run("./1_cell class numbers by dataset.Rmd")
callr_run("./2_cell class numbers by age and transgene.Rmd")
callr_run("./3_phenotyping plots across animals.Rmd")
callr_run("./4_neuron cluster dotplots.Rmd")
callr_run("./5_supp figure - qc metrics by cell class.Rmd")
