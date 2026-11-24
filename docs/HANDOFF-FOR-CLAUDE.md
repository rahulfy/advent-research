# Advent Research: hosting details for the update job

**Site:** research.adventfa.com. Until the domain is attached it runs at https://advent-research.pages.dev.
**Purpose:** data pages on markets, products and similar topics that a scheduled job updates. Financial-planning concept articles stay on the blog at adventfa.com. Blog posts can link to research pages, and research pages can link back.

## Where to publish

- **Repository:** `github.com/ritik-design/advent-research`, branch `main`, private.
- **How it goes live:** every push to `main` triggers a GitHub Action that publishes the site to Cloudflare Pages in about a minute. The job only has to commit; it needs no Cloudflare access.
- **Access:** through the Claude GitHub app installed on this repository, with Rahul's GitHub account as a collaborator with write access. *(Our side is still setting this up. We need Rahul's GitHub username.)*

## Repository layout

```
/                    repo root = site root
  index.html         landing page (ours, see below)
  404.html           ours
  sitemap.xml        list of public URLs
  robots.txt         ours
  favicon.ico, favicon-96x96.png, apple-touch-icon.png
  sif/index.html     SIF Tracker, rebuilt by the job every weekday night
  <tool>/index.html  each future tool gets its own folder
```

**Files the job must not touch:** `.github/`, `build.sh`, `.deployignore`, `wrangler.jsonc`, `README.md`, `docs/`, `404.html`, `robots.txt`.

**Everything committed is published,** except the files listed in `.deployignore`. Do not commit generator code, API keys, raw vendor files or anything else that should stay private. Keep the generator and its credentials on the job's side. A `data.json` next to a page is fine only if the data licence allows it to be public (check Finsharpe's terms).

## Nightly update rules

1. Each run commits only its own folder, for example `sif/index.html`.
2. **If the data fetch fails or comes back incomplete, do not commit.** The last good page stays live. Never publish an empty or half-filled table.
3. If nothing changed (weekends, market holidays), make no commit.
4. Commit message: `<tool>: data as of <DD Mon YYYY>`. Never force-push and never rewrite history; rollback works by reverting a commit.
5. Each page shows its own "data as of" date and "Page built … IST" stamp, so readers and we can see when it is stale.

## Adding a new tool (markets, products, etc.)

A one-off commit when the tool launches:
- **Folder:** create `<slug>/index.html`. Use a short, lowercase, hyphenated slug, for example `/sif/`, `/index-valuations/`, `/fd-rates/`. URLs must never change once live, because links and search results depend on them.
- **Landing page card:** add one to `index.html`, inside `<div class="items">` and before the dashed "More research" card. Copy the markup of the SIF card: an `<a class="item">` with `h2`, `p` and `span.tag` for the update frequency. That is the only edit the job may make to the landing page.
- **Sitemap:** add `<url><loc>https://research.adventfa.com/<slug>/</loc></url>` to `sitemap.xml`.

## Rules for every page

- **Self-contained HTML:** styles, logo and scripts inline. The only external resource allowed is Google Fonts (Inter, Newsreader). It must work on phones at 390 px width with no sideways scroll.
- **Regulatory footer, exact text and unchanged on every page:** "Advent Financial | Rahul Agarwal, Proprietor | SEBI Registered Investment Adviser (Individual) | Registration No. INA300003616 | BSE Enlistment No. 1301 | Validity: Perpetual", plus the page's disclaimer and data source line.
- **Required `<head>` tags:**
  ```html
  <title>SIF Tracker | Advent Research</title>
  <meta name="description" content="…">
  <link rel="canonical" href="https://research.adventfa.com/sif/">
  <meta property="og:type" content="website">
  <meta property="og:site_name" content="Advent Financial">
  <meta property="og:title" content="SIF Tracker | Advent Research">
  <meta property="og:description" content="…">
  <meta property="og:url" content="https://research.adventfa.com/sif/">
  <link rel="icon" href="/favicon.ico" sizes="any">
  <link rel="icon" type="image/png" href="/favicon-96x96.png" sizes="96x96">
  <link rel="apple-touch-icon" href="/apple-touch-icon.png">
  ```
- **Links:** "All research" goes to `../`. The logo links to `https://adventfa.com/`. A "talk to us" link goes to `https://adventfa.com/fit`.
- **Colours:** use the tokens from the landing page `:root` (light and dark).

## Changes to make in the SIF generator now

`sif/index.html` is rebuilt every night, so these must go into the generator, not the file:
1. Add the `<head>` tags above. Right now there is no canonical, OG tags or favicon link, and the title is just "SIF Tracker".
2. Wrap the logo in `<a href="https://adventfa.com/">`.
3. Remove the `<metadata><c2pa:manifest>…</c2pa:manifest></metadata>` block inside the logo SVG. It is about 30 KB of signing data in every page and is not shown.

## Not set up yet (our side)

- Custom domain research.adventfa.com (it will be attached in Cloudflare)
- Cloudflare token for the publish Action. Until it is added, commits land in the repo but don't go live.
- Claude GitHub app on the repository, and Rahul as collaborator
- Analytics: none for now. Adding GA4 needs the privacy policy to cover this subdomain first.
