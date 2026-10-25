# Decision log

## Project initialized

- The user requested a new project named Similar Web Retrieval in the existing GitHub repository.
- Created a separate similar-web-retrieval/ folder with its own project.md, AGENTS.md, and decision log.
- Existing IPUMS/Stata work remains separate.
- Retrieval scope, sources, outputs, and implementation language remain undecided.

## Initial Similarweb scope agreed

- The project concerns Similarweb data retrieval and analysis for AARP, not generic discovery of similar websites.
- Start with share-of-voice analysis and audience interests/other websites visited; add use cases as useful opportunities are identified.
- User is willing to provide access. No working secure Similarweb connection or browser exists in the current tools; do not request credentials in chat or claim access has been established.
- Use explicit share-of-voice denominators and distinguish audience overlap, referrals, and journeys. Audience findings are aggregate estimates; no automatic AARP-member or age50+ interpretation.
- Proposed US/aarp.org/latest12-complete-month scope is a starting assumption, not a confirmed user requirement. Competitors and reporting format remain to be defined.

## Audience discovery scope clarified

- User does not want a preselected website/competitor comparison.
- Primary question: for visitors to aarp.org in a seven-day period, what are the top100 other websites they visited in those same seven days?
- Rank by common audience reach/overlap if supported, not by affinity alone. No before/after sequence or referral relationship is implied.
- User believes no API access is available. Verify audience-report time granularity, domain/export limits and secure access before promising retrieval. Weekly traffic metrics do not prove weekly overlap availability.
- This supersedes the proposed twelve-month starting scope and comparator-list requirement. Share of voice is deferred.
