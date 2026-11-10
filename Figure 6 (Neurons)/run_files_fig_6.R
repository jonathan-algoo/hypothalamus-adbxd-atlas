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

callr_run("./1_dreamlet neuronal alterations and foxb1 plot.Rmd")
callr_run("./2_pathway level canonical neuron analysis.Rmd")
callr_run("./3_Pathway level neuronal vis.Rmd")
callr_run("./4_deg correlation transcriptome phenome.Rmd")