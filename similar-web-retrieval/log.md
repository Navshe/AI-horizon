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

## October 25, 2026: presentation precision

- User requested one decimal place throughout the Similarweb PowerPoint deck and asked to record the rule in AGENTS.md.
- Apply one decimal place to analytical presentation figures by default. Preserve original precision and round directly from source values, keeping summaries and table labels consistent.
- This changes presentation formatting, not the workbook's source values or the definitions of cross-visitation and 55+ audience composition.

## October 25, 2026: competitive set and demographic comparison

- User defined Amazon, AAA, Costco, USAA and AMAC as the competitive set, with AARP included as the benchmark.
- Requested a two-slide summary of six previously discussed measures: age distribution, audience share, competitive share, visit duration, pages per visit and bounce rate.
- Separate audience composition/share from engagement, and label this as a proposed comparison framework until values are collected.
- Verify traffic-versus-unique-visitor denominators, combined 55+ engagement support, exact domains and AAA regional coverage. Maintain one consistent six-site denominator for competitive share.

## October 25, 2026: populated competitive benchmark and merged deck

- User asked to populate the six metrics for AARP and all five competitors, then combine the two benchmark slides with the previous ten-slide presentation.
- Confirmed that selecting 55–64 and 65+ together and clicking Apply yields native combined 55+ engagement. This supersedes the earlier assumption that the interface only offered separate bands.
- Collected September 2026 U.S. Total web data, all genders, subdomains included, for aarp.org, amazon.com, aaa.com, costco.com, usaa.com and amac.us.
- AAA scope is the national domain and its subdomains, not separately hosted regional clubs.
- The interface limits each view to five sites. Rebased two overlapping views through a common Amazon anchor to produce approximate six-site competitive shares. Label the approximation and source rounding rather than presenting it as a native six-site export.
- Retain one decimal place throughout the twelve-slide combined presentation. Keep licensed source data and detailed values outside GitHub.

## October 26, 2026: monthly issue framework

- User approved three data-supported actions per issue: editorial, resource/service improvement, and distribution; report latest complete month, MoM, YoY where available and longer trend.
- Retain core Amazon/AAA/Costco/USAA/AMAC comparison plus five issue-specific groups of five advice providers, with AARP benchmarked throughout. Starting groups and domain rules are recorded in project.md.
- Selections reflect relevance and guidance breadth, not a verified traffic ranking. Compare issue-relevant content and keyword/prompt baskets; keep groups stable and review quarterly. Verify coverage and distinguish government, nonprofit, publisher and commercial roles.
