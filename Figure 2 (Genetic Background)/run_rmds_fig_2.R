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

callr_run("./1_assess read percent to strain.Rmd")
callr_run("./2_consensus strain modeling - sccomp voomclr and ancombc .Rmd")
callr_run("./3_consensus strain modeling vis.Rmd")
callr_run("./4_variance partition analysis.Rmd")
callr_run("./5_variance partition vis.Rmd")
