# Similar Web Retrieval: agent instructions

- This folder is a separate project from the parent repository's IPUMS/Stata analysis.
- The parent's Stata-only and PUMA-specific analysis instructions apply to that analysis, not to this project's implementation. No language has been selected for this project.
- Read project.md before implementation and record consequential decisions in this folder's log.md.
- Keep this project's files inside this folder; preserve other projects and user changes.
- Explain steps in plain language for a user who does not know Python.
- Never commit credentials, access tokens, or private source data.
- Define the intended retrieval task before implementing it; do not assume that the title establishes a particular service or data source.
- Prioritize discovery of the top100 other domains visited by AARP.org visitors in the same seven-day window, as detailed in project.md. Do not require a fixed competitor list or substitute a different time window/metric silently.
- Do not request passwords or MFA codes in chat. Establish supported secure access or use exported reports.
- Do not infer individual browsing histories, AARP membership, or age50+ status from aggregate Similarweb audience metrics.
