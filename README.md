# Advent Research — research.adventfa.com

Static site for Advent Financial's research tools. Landing page at `/`, SIF Tracker at `/sif/`.

- **`sif/index.html` is generated.** Rahul's nightly job (weekdays 11:40 PM IST, a Claude routine) rebuilds it from Finsharpe data and commits it here. Hand edits are overwritten the next night; design changes go to Rahul for the generator.
- **Everything else is ours** (landing page, 404, icons, robots, sitemap). Keep the SEBI regulatory footer and disclaimer on every page.
- **Deploy:** Cloudflare Pages project `advent-research` (direct upload, production branch `main`) on the Rahul@adventfa.com account (c0664a4). Every push to `main` runs `.github/workflows/deploy.yml`: `./build.sh` copies the site files (everything not in `.deployignore`) into `dist/`, then `wrangler pages deploy`. Needs the repo secret `CLOUDFLARE_API_TOKEN` (Cloudflare Pages: Edit on that account). Manual deploy: `./build.sh && CLOUDFLARE_ACCOUNT_ID=c0664a4ca5349453c8372469fe2e5c4a npx wrangler pages deploy --branch main`.
- **Rollback:** revert the commit on `main`, or roll back to an earlier deployment in the Pages dashboard.
- **New tool:** add a folder (e.g. `pms/index.html`), a card on the landing page and a `<loc>` in `sitemap.xml`.
