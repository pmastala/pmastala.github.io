# ------------------------------------------------------------------
# check_orcid.R
#
# Lists every work on your public ORCID record and flags any DOI that
# is not yet in data/publications.yml. For each new DOI it prints a
# ready-to-paste YAML block built from Crossref metadata.
#
# Nothing is written to your site automatically: you review the output
# and paste what you want into data/publications.yml.
#
# Run in RStudio from the project folder:
#   source("R/check_orcid.R")
#
# Needs: install.packages(c("jsonlite", "yaml"))
# ------------------------------------------------------------------

orcid_id <- "0000-0001-9135-4856"

library(jsonlite)
library(yaml)

# 1. Works on ORCID -------------------------------------------------
works_url <- sprintf("https://pub.orcid.org/v3.0/%s/works", orcid_id)
con <- url(works_url, headers = c(Accept = "application/json"))
works <- fromJSON(paste(readLines(con, warn = FALSE), collapse = ""), simplifyVector = FALSE)
close(con)

get_doi <- function(group) {
  ids <- group$`external-ids`$`external-id`
  for (id in ids) {
    if (tolower(id$`external-id-type`) == "doi") return(tolower(id$`external-id-value`))
  }
  NA_character_
}

orcid_dois <- unique(na.omit(vapply(works$group, get_doi, character(1))))
cat(sprintf("ORCID lists %d works with a DOI.\n", length(orcid_dois)))

# 2. DOIs already on the site ---------------------------------------
site <- yaml::read_yaml("data/publications.yml")
site_dois <- tolower(vapply(site, function(x) if (is.null(x$doi)) NA_character_ else x$doi, character(1)))

new_dois <- setdiff(orcid_dois, site_dois)
if (length(new_dois) == 0) {
  cat("Your publications page is up to date with ORCID.\n")
} else {
  cat(sprintf("\n%d DOI(s) on ORCID are missing from data/publications.yml:\n\n", length(new_dois)))

  # 3. Draft YAML from Crossref for each new DOI ----------------------
  for (doi in new_dois) {
    meta <- tryCatch(
      fromJSON(sprintf("https://api.crossref.org/works/%s", utils::URLencode(doi, reserved = TRUE)))$message,
      error = function(e) NULL
    )
    if (is.null(meta)) {
      cat(sprintf("# Could not fetch Crossref record for %s\n\n", doi))
      next
    }
    authors <- if (!is.null(meta$author)) {
      paste(sprintf("%s %s", meta$author$family,
                    gsub("[^A-Z]", "", meta$author$given)), collapse = ", ")
    } else "[Authors]"
    year <- if (!is.null(meta$issued$`date-parts`)) meta$issued$`date-parts`[[1]][1] else "[Year]"

    cat("- title: \"", meta$title[[1]], "\"\n", sep = "")
    cat("  authors: \"", authors, "\"\n", sep = "")
    cat("  journal: \"", meta$`container-title`[[1]], "\"\n", sep = "")
    cat("  year: ", year, "\n", sep = "")
    if (!is.null(meta$volume)) cat("  volume: \"", meta$volume, "\"\n", sep = "")
    if (!is.null(meta$`article-number`)) cat("  article: \"", meta$`article-number`, "\"\n", sep = "")
    cat("  doi: \"", doi, "\"\n", sep = "")
    cat("  open-access: [true or false]\n")
    cat("  status: \"Published\"\n\n")
  }
  cat("Paste the blocks you want at the top of data/publications.yml,\n")
  cat("wrap your own name in <strong></strong>, then render the site.\n")
}
