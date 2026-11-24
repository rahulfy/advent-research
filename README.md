# Advent Research — research.adventfa.com

Static site for Advent Financial's research tools. Landing page at `/`, SIF Tracker at `/sif/`.

- **`sif/index.html` is generated.** Rahul's nightly job (weekdays 11:40 PM IST, a Claude routine) rebuilds it from Finsharpe data and commits it here. Hand edits are overwritten the next night; design changes go to Rahul for the generator.
- **Everything else is ours** (landing page, 404, icons, robots, sitemap). Keep the SEBI regulatory footer and disclaimer on every page.
- **Deploy:** Cloudflare Worker `advent-research` (static assets only) on the Rahul@adventfa.com account (c0664a4), custom domain `research.adventfa.com` (also https://advent-research.rahul-c06.workers.dev). Every push to `main` runs `.github/workflows/deploy.yml`: `./build.sh` copies the site files (everything not in `.deployignore`) into `dist/`, then `wrangler deploy`. Needs the repo secret `CLOUDFLARE_API_TOKEN` (Workers Scripts: Edit on that account, Workers Routes: Edit on the adventfa.com zone). Manual deploy: `./build.sh && npx wrangler deploy`.
- **Rollback:** revert the commit on `main`, or `npx wrangler rollback`.
- **New tool:** add a folder (e.g. `pms/index.html`), a card on the landing page and a `<loc>` in `sitemap.xml`.
