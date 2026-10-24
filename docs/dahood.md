# dahood fork

This fork of [CleanYourTV](https://github.com/lasharor/cleanyourtv-WebOS) keeps the service, the manager, the Input key and the debloat,
and replaces the launcher page with its own (`app/dahood.html`).

## The launcher

- **Landing:** three pinned tiles, sorted by when each was last used, plus *All apps* at the end of the row. A pin can be an app or an
  HDMI input (`com.webos.app.hdmiN`). The big title and the glow follow the focused tile; the line under the title says when it was last used.
- **All apps:** the inputs first (which are connected, from `hdmiPlugIn`), then every app sorted by last use. Back closes it; Home always
  lands on the landing row with the first tile focused.
- **Coming next:** the library (continue watching, recently added) below the row, with a full-screen backdrop view when you go down.

Settings in `/media/developer/cleanyourtv/config.json` (all optional):

| Key | Default | What |
|---|---|---|
| `pins` | `["li.dahood.media", "youtube.leanback.v4", "com.webos.app.hdmi3"]` | the three landing tiles |
| `pinNames` | `{"com.webos.app.hdmi3": "PlayStation 5"}` | names for pinned inputs |
| `hidden` | `[]` | app ids left out of All apps (LG's promo apps are always left out) |
| `launcher` | | `"classic"` brings back upstream's launcher page at the next staging |

## Service changes

- HDMI inputs count as used when they are in the foreground, so a pinned input sorts like an app.
- `/api/apps` also returns `lastUsed` (`{id: timestamp}`) and each app's `color` (its `iconColor`).
- `scripts/stage-home.sh` copies `app/dahood.html` over `index.html` in the staged Home, so the stock appinfo stays and no app-manager
  restart is needed.

## Releases and updates

Versions: upstream's `x.y.z` becomes `x.y.(z*100+n)` (service `1.5.16` → `1.5.1601`), so a fork release always sorts above the upstream
release it is based on. A push to `main` with a new `const VERSION` in `helper/helper.js` publishes release `v<version>`
(`.github/workflows/dahood-release.yml`, which also refuses anything that looks like a secret: the fork is public).

A TV follows this fork when `/media/developer/cleanyourtv/source` contains `d0dge-dev/cleanyourtv-dahood`; the manager app's update
then installs our releases.

No secrets belong in this repository. Anything private (tokens for the media server, addresses) lives only in the TV's `config.json`.
