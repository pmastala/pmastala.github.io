# Personal website of Precious Innocent Mastala

A Quarto website, edited in RStudio and hosted free on GitHub Pages.

## 1. Before you start (one time)

Install, in this order:

1. **R** and **RStudio** (you likely have these already).
2. **Quarto**: <https://quarto.org/docs/get-started/> (RStudio may already include it; check with `quarto --version` in the RStudio **Terminal** tab).
3. **Git**: <https://git-scm.com/downloads>
4. A free **GitHub** account: <https://github.com>

Then, in RStudio's **Console**, connect Git to GitHub once:

```r
install.packages(c("usethis", "gitcreds"))
usethis::use_git_config(user.name = "Precious Innocent Mastala",
                        user.email = "you@example.com")   # the email on your GitHub account
usethis::create_github_token()   # opens GitHub; create the token and copy it
gitcreds::gitcreds_set()         # paste the token when asked
```

## 2. Open and preview the site

1. Unzip this folder somewhere permanent (for example `Documents/precious-mastala-website`).
2. Double-click **`precious-mastala-website.Rproj`**. RStudio opens the project.
3. Go to the **Build** tab and click **Render Website**, or in the **Terminal** tab run:

   ```
   quarto preview
   ```

   The site opens in your browser and refreshes as you save files.

## 3. Publish to GitHub Pages

The site renders into the `docs/` folder, and GitHub Pages serves that folder directly. No extra tools are needed.

**First time only**

1. On GitHub, create a new **public** repository.
   - Name it **`pmastala.github.io`** and the site lives at `https://pmastala.github.io`.
   - Any other name (for example `website`) gives `https://pmastala.github.io/website`.
   - Do **not** add a README, .gitignore or licence on GitHub.
2. `site-url` in `_quarto.yml` is already set to `https://pmastala.github.io`. If you give the repository another name (e.g. `website`), change it to `https://pmastala.github.io/website`.
3. In the RStudio **Terminal**, run these lines one at a time (change the repository name if you chose a different one):

   ```
   quarto render
   git init
   git add .
   git commit -m "First version of my website"
   git branch -M main
   git remote add origin https://github.com/pmastala/pmastala.github.io.git
   git push -u origin main
   ```

4. On GitHub, open the repository, then **Settings → Pages**. Under **Build and deployment** choose **Deploy from a branch**, branch **main**, folder **/docs**, and click **Save**.
5. After a minute or two the site is live. The address appears at the top of the Pages settings.

**Every update after that**

```
quarto render
git add .
git commit -m "Describe what you changed"
git push
```

Or use RStudio's **Git** tab: tick the changed files, click **Commit**, write a message, then **Push**.

Always run `quarto render` before committing. The preview server alone does not rebuild every page.

## 4. Updating content

| To change… | Edit this |
|---|---|
| Publications | `data/publications.yml` |
| Career timeline | `data/journey.yml` |
| Research projects | `projects/*.qmd` |
| News and blog posts | `posts/` |
| About page (current position, interests, education) | `about.qmd` |
| Contact details | `contact.qmd` |
| Homepage text | `index.qmd` |
| CV | replace `files/Mastala_CV.pdf` (keep the file name) |
| Colours and fonts | `theme.scss` (top of the file) |
| Layout and spacing | `styles.css` |
| Menu, site title, footer | `_quarto.yml` |

### Add a publication

Open `data/publications.yml`, copy an existing block (from `- title:` down), paste it at the **top** of the list, and edit it. Wrap your own name in `<strong>…</strong>` to bold it.

To check whether ORCID lists any paper the site is missing, run this in the RStudio Console:

```r
install.packages(c("jsonlite", "yaml"))   # first time only
source("R/check_orcid.R")
```

It prints a ready-to-paste block for each missing paper, using Crossref data. Review it before pasting.

### Add a news post

1. Copy the folder `posts/_TEMPLATE` and rename the copy, e.g. `posts/2027-03-15-conference-talk`.
2. Open its `index.qmd`, edit the title, date, categories and text, and **delete the `draft: true` line**.
3. Put the post's photo in `images/posts/` and update the `image:` path.

The newest three posts appear automatically on the homepage under **Latest**.

### Add or edit a research project

1. Copy any file in `projects/`, rename it (e.g. `projects/rabies-genomics.qmd`), and edit it.
2. In the front matter:
   - `status:` sets the tag (Published, Ongoing, Proposed, Completed). Change `categories:` to match.
   - `featured: true` shows the project on the homepage. Keep three featured.
   - `order:` sets the position on the Research page.
3. Put the project photo in `images/projects/` and update both image paths in the file.

### Add a career milestone

Copy a block in `data/journey.yml` and edit it. List newest first. Set `current: true` only for an ongoing role (it gets an orange marker). Add `image:` to show a photo beside the milestone.

### Replace photos

The site uses grey placeholder images that name the file to replace. Save your photo with **exactly the same file name** in the same folder and it appears everywhere that image is used:

| Placeholder | Where it appears |
|---|---|
| `images/headshot.jpg` | Homepage hero (square photo, at least 600 × 600 px) |
| `images/projects/*.jpg` | Project cards and pages (landscape, 1200 × 675 px works well) |
| `images/posts/*.jpg` | Update cards and posts |
| `images/gallery/*.jpg` | Photo row on the About page (edit captions in `about.qmd`) |
| `images/social-card.png` | Preview image when the site is shared on LinkedIn or X |

Keep photos under about 300 KB so pages load quickly on mobile data. Resize them before adding (for example with <https://squoosh.app>). Always update the `fig-alt` or `image-alt` text so screen-reader users know what the photo shows.

### Add an R figure or map

Any `.qmd` page can run R code. For example, in a project page:

````
```{r}
#| echo: false
#| fig-alt: "Map of reported rabies cases by district"
library(ggplot2)
# your plotting code here
```
````

Interactive maps (for example with the leaflet package) work the same way.

## 5. Things still to fill in

Search the project for `[` to find every placeholder. The main ones:

- Milestone years and descriptions in `data/journey.yml`
- Degree years in `about.qmd`
- Research questions, approach and collaborators in each `projects/*.qmd`
- Status of the PEP and Arizona mosquito projects (`status:` and `categories:`)
- Full author list for the *Antibiotics* 15(10):1028 paper, and a check of the later authors on *Antibiotics* 15(3):239
- Email in `contact.qmd`
- Your CV, headshot and photos


## Folder map

```
_quarto.yml            site settings, menu, footer
theme.scss             colours and fonts
styles.css             layout and components
index.qmd              homepage
about.qmd  research.qmd  publications.qmd  journey.qmd  updates.qmd  contact.qmd
projects/              one .qmd per research project
posts/                 one folder per update; _TEMPLATE is a starter
data/                  publications.yml, journey.yml
_templates/            card, list and timeline layouts (rarely need editing)
images/                photos and graphics
files/                 CV and other downloads
R/check_orcid.R        compares ORCID with your publications list
docs/                  the rendered website (created by quarto render)
```
