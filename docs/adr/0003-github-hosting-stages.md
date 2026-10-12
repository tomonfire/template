# 0003. Vorschau, Staging und Produktion kostenlos auf GitHub

- Status: Accepted
- Datum: 2026-10-12

## Kontext

Änderungen sollen vor der Veröffentlichung sichtbar und prüfbar sein. Es dürfen keine Hosting-Kosten entstehen.

## Entscheidung

Projekte sind öffentlich und nutzen ausschließlich GitHub: Webseiten über GitHub Pages
(`/pr-<n>/`, `/staging/`, Root), Server-Programme als Container-Images in der GitHub Container Registry
(`:pr-<n>`, `:main`, `:vX.Y.Z`). Produktion braucht eine Freigabe über die GitHub-Umgebung `production`.

## Konsequenzen

Kostenlos und ohne zusätzliche Dienste. GitHub kann Server-Programme nicht dauerhaft betreiben; sie werden
pro Stufe gebaut, kurz getestet und als Image bereitgestellt. Soll ein Server dauerhaft laufen, wird
später ein Hosting-Anbieter ergänzt (neues ADR).
