# Mitwirken

Danke, dass du beitragen möchtest! Dieser Leitfaden hält die Zusammenarbeit einfach und vorhersehbar.

## Setup

```bash
./scripts/bootstrap.sh
```

Das installiert die pre-commit-Hooks und, falls vorhanden, die graphify-Git-Hooks.

## Workflow

1. Für größere Änderungen zuerst ein Issue eröffnen und den Ansatz abstimmen.
2. Branch von `main` erstellen: `feat/<kurzbeschreibung>`, `fix/<kurzbeschreibung>`, `docs/…`, `chore/…`.
3. Kleine, in sich geschlossene Commits nach [Conventional Commits](https://www.conventionalcommits.org/):

   ```text
   feat(auth): add password reset flow
   fix: handle empty config file
   docs: explain local setup
   ```

4. Vor dem Push: `pre-commit run --all-files` und Tests lokal ausführen.
5. Pull Request gegen `main` öffnen und die PR-Vorlage ausfüllen.
6. Merge erst nach grüner CI und mindestens einem Review. Bevorzugt **Squash & Merge**.

## Code-Stil

- Formatierung wird über `.editorconfig` und pre-commit erzwungen – nicht von Hand diskutieren.
- Öffentliche Schnittstellen dokumentieren; nicht-offensichtliche Entscheidungen als ADR in `docs/adr/` festhalten.
- Neue Funktionalität bringt Tests mit.

## Releases & Changelog

Releases laufen automatisch über [release-please](https://github.com/googleapis/release-please):

1. Jeder Merge nach `main` aktualisiert einen Release-PR („chore(main): release x.y.z“).
2. Die Version ergibt sich aus den Commits nach [SemVer](https://semver.org/lang/de/):
   `fix` → Patch, `feat` → Minor, `!`/`BREAKING CHANGE` → Major (vor 1.0.0: Minor).
3. Wird der Release-PR gemergt, entstehen Tag `vX.Y.Z`, GitHub Release und `CHANGELOG.md`-Eintrag.

`CHANGELOG.md` daher nicht von Hand bearbeiten.

## Labels

Labels sind in `.github/labels.yml` definiert und werden automatisch synchronisiert.
Schema: `type: …`, `priority: …`, `status: …`, `area: …`. PRs werden anhand der geänderten
Pfade automatisch gelabelt (`.github/labeler.yml`).

## Verhaltenskodex

Es gilt der [Code of Conduct](CODE_OF_CONDUCT.md).
