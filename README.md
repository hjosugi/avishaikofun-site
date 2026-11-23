# avishaikofun-site

The Avishai Kofun company site: one static page, served at
[www.avishaikofun.com](https://www.avishaikofun.com).

There is no build step. `site/` is exactly what gets deployed — edit
the HTML and CSS directly and open `site/index.html` in a browser to
check it.

```
site/
  index.html
  _headers
  assets/
    company.css
    company/kofun-friends-group.png
    work/<product>.png
```

## Adding a product

The page lists two kinds of work, and they are written differently on
purpose.

**In the stores** is for things a store has reviewed and published. Each
card has a 128px icon in `site/assets/work/`, copied from the product's
own repository, and one filled button that goes to the store listing.
Check the listing is public before adding it: a listing still in review
is a dead link for everyone but its owner.

**Open source** is one `<li>` per released project, no icon, linking out
to that project's own site or repository.

## What is deliberately not here

The Mail Lookout product pages — `support.html`, `privacy.html`,
`terms.html` — and the add-in manifest live in
[hjosugi/mail-lookout](https://github.com/hjosugi/mail-lookout) and are
served from the apex, `avishaikofun.com`.

That split is not arbitrary. Outlook loads the add-in from the apex on
every send, the add-in manifest hard-codes `SupportUrl` there, and the
Microsoft Marketplace listing points at those same URLs. Moving them
here would mean re-submitting the add-in for certification. So this repo
owns the company page and nothing else, and links to those pages
absolutely.

## Deploy

Pushing to `main` publishes `site/` to Cloudflare Pages via
`.github/workflows/deploy.yml`. It needs two repository secrets:

- `CLOUDFLARE_API_TOKEN` — a token with **Cloudflare Pages — Edit**
- `CLOUDFLARE_ACCOUNT_ID`

The deploy also needs `www.avishaikofun.com` attached as a custom
domain on the **`avishaikofun-site`** Pages project. That binding is not
in this repo and nothing here recreates it: without it the upload still
succeeds, `avishaikofun-site.pages.dev` still serves the page, and only
the live check at the end of the deploy — and the heartbeat — notice
that the domain itself is dead.

Note there is a second, older Pages project, `avishai-kofun`, which
serves the apex. Only the apex belongs to it; `www` pointing there is a
misconfiguration, not a fallback.

To deploy by hand instead:

```sh
bunx wrangler pages deploy site --project-name=avishaikofun-site
```

## License

[0BSD](./LICENSE). The artwork (`kofun-friends`) is by hjosugi under
CC BY 4.0.
