#Run files shared dir
#path of output file returned by purl, which is why this works
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

callr_run("./1_aggregate ge and percent table creation.Rmd")

# Diff exp
setwd("diff exp")
callr_run("anndata dreamlet creation.Rmd")
callr_run("deg mixed models dreamlet.Rmd")

# Diff abundance
setwd("../diff abundance")
callr_run("1_consensus proportion modeling - ancombc2.Rmd")
callr_run("2_consensus proportion modeling - sccomp.Rmd")
callr_run("3_consensus proportion modeling - voomclr.Rmd")
callr_run("4_consensus proportion modeling - collect results.Rmd")