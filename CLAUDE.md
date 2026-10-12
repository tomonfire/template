# CLAUDE.md

@AGENTS.md

## Nur für Claude Code

- **Team:** `/team` führt ein Feature durch Anforderungen → Umsetzung → Review. Subagents in `.claude/agents/`:
  `anforderungen` (Opus), `senior-developer`, `ui-ux-experte`, `qa-reviewer` (Sonnet).
- Der Skill `/graphify` liegt in `.claude/skills/graphify/`; Hooks in `.claude/settings.json` erinnern an `graphify query`.
- Persönliche Einstellungen gehören in `.claude/settings.local.json` bzw. `CLAUDE.local.md` (beide gitignored).
