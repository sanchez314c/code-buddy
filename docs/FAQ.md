# FAQ

**Q: Why not build this as a web app?**
A: Because it needs to run where your repos are, on your local machine, with zero network calls. A web app adds complexity that doesn't serve the use case.

**Q: Can I use this without Claude Code?**
A: Yes. The hook integration is optional. The CLI works standalone.

**Q: What happens if I exceed the ACTIVE cap?**
A: `code-buddy status` warns you. `code-buddy move` blocks adding to ACTIVE until you move something out. It's enforcement, not a suggestion.

**Q: Does this modify my repos?**
A: No. Code Buddy only reads repos (git log, file existence checks). It never writes to your project directories. It only writes MANIFEST.md and RECENT-ACTIVITY.md to the portfolio root.

**Q: Can I change the folder names?**
A: Yes. Edit `~/.code-buddy/config.json` and update the `folders` mapping.
