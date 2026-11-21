# `io.balena.image.os-version`

The extension does **not** set this label. `balena-hostapp-extension.bbclass`
stamps it from `HOSTOS_VERSION`, producing the exact patch version (e.g. `7.9.3`).

That is the right value, and this note exists so nobody re-adds the narrowing that
used to be here.

## What the label does

`host-extensions.md` in meta-balena defines it as a comma-separated list of
shell-style globs (`filepath.Match` semantics) matched against `/etc/os-release`
`VERSION_ID`. At the post-HUP commit — the rollback-health boundary —
`balena-extension-manager cleanup --stale-os` removes extension images whose label
no longer satisfies the new OS version.

## Why an exact version is correct

The extension ships **inside** an OS release, declared in `<machine>.hostapp.yml`.
A HUP therefore delivers the matching rebuild alongside the new hostapp, and
cleaning up the previous version's image afterwards is correct behaviour, not data
loss.

The re-delivery is cheap: two independent builds of identical inputs differ in
**exactly one file out of 633** (`/etc/buildinfo`, which records layer revisions),
so the per-release delta is small.

## Why the minor-line glob was removed

An earlier revision rewrote `HOSTOS_VERSION` in an anonymous function to produce
`7.9.*`, on the reasoning that a patch HUP would otherwise discard the extension.

That only applies to an extension delivered **outside** a release — side-loading
during development, where a hand-placed image is removed on the next HUP with
nothing to replace it. It is a dev-path wrinkle, not a production one.

If you are side-loading for validation and a HUP eats your extension, that is why.
Re-load it rather than reintroducing the glob.
