# Vorschau, Staging, Produktion: so kommt eine Änderung live

Jede Änderung durchläuft drei Stufen, bevor die Öffentlichkeit sie sieht. Alles läuft kostenlos auf GitHub.

```text
 Änderung (Pull Request)  ──►  VORSCHAU      nur diese Änderung, zum Anschauen und Testen
          │ Merge
          ▼
 Hauptzweig "main"        ──►  STAGING       alle fertigen Änderungen zusammen, letzte Kontrolle
          │ Release-PR mergen + Freigabe klicken
          ▼
 Version vX.Y.Z           ──►  PRODUKTION    die "echte" Version für alle
```

## Was wird wo veröffentlicht?

| Stufe          | Webseite (Stack „web“, GitHub Pages)          | Server-Programm (Stacks mit Dockerfile)              |
| -------------- | --------------------------------------------- | ---------------------------------------------------- |
| **Vorschau**   | `https://<name>.github.io/<repo>/pr-<Nr>/`    | Image `ghcr.io/<name>/<repo>:pr-<Nr>`                |
| **Staging**    | `https://<name>.github.io/<repo>/staging/`    | Image `ghcr.io/<name>/<repo>:main`                   |
| **Produktion** | `https://<name>.github.io/<repo>/`            | Image `ghcr.io/<name>/<repo>:vX.Y.Z` und `:latest`   |

- **Webseiten** sind sofort im Browser erreichbar. Den Link zur Vorschau schreibt GitHub automatisch
  als Kommentar in den Pull Request. Wird der PR geschlossen, verschwindet die Vorschau wieder.
- **Server-Programme** kann GitHub nicht dauerhaft betreiben. Deshalb wird jede Stufe als fertiges
  Paket (Container-Image) gespeichert und einmal testweise gestartet, um zu prüfen, ob es antwortet.
  Ausprobieren kannst du jede Stufe mit einem Befehl, der ebenfalls im PR-Kommentar steht:
  `docker run --rm -p 8080:8080 ghcr.io/<name>/<repo>:pr-12` → <http://localhost:8080>

## Ablauf im Alltag

1. **Änderung machen** (selbst oder per KI-Assistent) in einem eigenen Branch und einen Pull Request öffnen.
2. **Vorschau ansehen:** Den Link findest du im PR-Kommentar. Gleichzeitig prüft die CI automatisch Tests und Qualität.
3. **Mergen**, wenn alles passt. Die Änderung landet in **Staging**.
4. **Release:** GitHub hält automatisch einen „Release-PR“ bereit, der alle Änderungen seit der letzten
   Version sammelt. Mergst du ihn, entsteht eine neue Version.
   Beim Release-PR laufen keine Prüfungen (GitHub startet sie bei automatisch erstellten PRs nicht).
   Das ist in Ordnung, weil er nur Versionsnummer und Changelog ändert. Zum Mergen setzt du den Haken
   **„Merge without waiting for requirements to be met (bypass rules)“**.
5. **Freigabe:** Bevor die Version in **Produktion** geht, fragt GitHub nach deiner Bestätigung
   (*Actions → Deploy production → Review deployments → Approve*).

**Zurückrollen:** *Actions → Deploy production → Run workflow* und eine ältere Version (z. B. `v1.2.0`) eintragen.

## Einmalige Einrichtung

1. Repo **öffentlich** anlegen. Nur dann sind Pages, Freigaben und Schutzregeln im kostenlosen Plan enthalten.
2. `./scripts/setup-github.sh` ausführen. Das Skript schaltet GitHub Pages ein und legt die Stufen
   `preview`, `staging` und `production` an; für Produktion bist du als Freigebende Person eingetragen.
3. Einen Stack wählen (`./scripts/init-stack.sh …`). Ohne Stack gibt es nichts zu veröffentlichen.

Optional: Mit einer eigenen Domain setzt du die Repository-Variable `PAGES_URL` (z. B. `https://meine-domain.de`).

## Kosten

Für öffentliche Repositories ist alles kostenlos: GitHub Actions, GitHub Pages, die GitHub Container
Registry und die Umgebungen mit Freigabe.
