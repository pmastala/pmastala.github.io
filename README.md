# Personal website of Precious Innocent Mastala

Quarto website, edited in RStudio and published with GitHub Pages at https://pmastala.github.io

## Publish a change

In the RStudio **Terminal**:

```
quarto render
```

Then in the **Git** tab: **Commit** (tick all changed files, write a message) and **Push**.
The site updates about a minute later. Press Cmd + Shift + R in the browser to see it.

## What to edit

| To change… | Edit this |
|---|---|
| About page (photo, bio, interests, education) | `index.qmd` |
| Research themes | `research.qmd` |
| Publications | `data/publications.yml` (under review: `data/under-review.yml`) |
| CV page entries | `data/cv/*.yml` (education, experience, awards, presentations, service, training) |
| Skills and languages | bottom of `cv.qmd` |
| Downloadable CV | replace `files/Mastala_CV.pdf` (keep the name) |
| Headshot | replace `images/headshot.jpg` (square, about 640 × 640 px) |
| Menu and footer links | `_quarto.yml` |
| Colours and fonts | `theme.scss` |
| Layout | `styles.css` |

### Add a publication

Copy a block in `data/publications.yml`, paste it at the top, edit it, render, commit and push.
Wrap your own name in `<strong></strong>`.

The cover thumbnail is filled in automatically from the DOI for BMC/Springer and MDPI journals.
For other journals add `cover: "image link"` (for example the journal cover image from its website).
Without a cover, a navy tile with the journal name is shown.

`R/check_orcid.R` lists any paper on your ORCID record that is missing from the site:
run `source("R/check_orcid.R")` in the Console.

### Add a CV entry

Copy a block in the right file under `data/cv/`, paste it in date order (newest first), and edit it.
