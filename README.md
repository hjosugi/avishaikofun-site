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
```

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

To deploy by hand instead:

```sh
bunx wrangler pages deploy site --project-name=avishaikofun-site
```

## License

[0BSD](./LICENSE). The artwork (`kofun-friends`) is by hjosugi under
CC BY 4.0.
