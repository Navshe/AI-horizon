# Similar Web Retrieval

## Purpose and organization

Use Similarweb data to identify findings relevant to AARP. Start with two use cases and expand as useful opportunities emerge. The user referenced prior Resonate work as a model; its methods and outputs have not been supplied here, so do not assume they are known.

Keep this project in similar-web-retrieval/ within Navshe/AI-horizon, separate from the existing IPUMS/Stata analysis. No implementation language is selected. The user does not need to learn a programming language.

## Primary use case: top 100 other websites visited by AARP's audience

- Seed domain: aarp.org (the user's spoken “arp.org” refers to AARP.org in this project).
- Audience: people who visited aarp.org during a selected seven-day period.
- Desired output: the top 100 other website domains visited by that same audience during the same seven days. Exclude aarp.org itself and document treatment of subdomains/related AARP properties.
- Discover websites from audience behavior; do not require a preselected competitor list.
- Prefer ranking by estimated unique audience overlap: the number or percentage of AARP's audience also visiting each other domain. The percentage denominator must be AARP's audience, not the other site's audience.
- Do not substitute affinity/lift for overlap reach without explicit labeling and user discussion; highly distinctive sites need not be the most commonly visited.
- This is a same-window co-visitation question, not necessarily websites visited immediately before or after AARP, or referrals to/from AARP. Sequence is not requested.
- Seven days is the requested analysis window; its availability in Similarweb audience reports is unverified. Daily traffic availability does not establish daily audience-overlap availability.
- If only monthly audience data, fewer than 100 domains, or another metric is available, report that limitation and agree on a fallback. Do not relabel monthly data as weekly or claim a top100 list from a truncated source.
- Treat findings as aggregate modeled estimates, not identified individuals or proof of an individual's browsing history. Do not infer AARP membership or age50+.

## Starting scope and deliverable

- Geography: United States proposed, pending confirmation.
- Period: seven days; prefer the latest complete seven days for which the requested audience metric exists. Exact dates, timezone and data lag must be stated.
- Devices: all available web devices, with actual coverage documented.
- Proposed Excel table: rank, other domain, website category, overlap count and/or percentage (whichever the report actually provides), affinity if available, period, geography, device scope and source metric definition.
- Identify meaningful audience-interest patterns from the resulting list. General portals, search engines and social platforms may dominate reach rankings; retain the primary ranking and optionally provide a separate thematic interpretation.
- Keep open-ended audience discovery separate from the competitive benchmarking scope below.

## Access and source handling

- The user is willing to provide Similarweb access and believes the subscription does not include API access. Do not request passwords, MFA codes or session cookies in chat or commit them to GitHub.
- No Similarweb connector or interactive browser is currently available in this workspace. Direct login access has not been established. An account login does not establish API entitlement.
- Establish a supported secure access mechanism before promising direct platform exploration. If unavailable, analyze user-provided Similarweb exports, or use an API if the subscription provides it and credentials can be supplied securely.
- Never copy credentials into code, project instructions, logs, or reports. Keep licensed/private exports out of GitHub unless publication is explicitly authorized and permitted.
- Record unavailable reports and subscription limits. Never invent results or treat absent data as zero.

## Competitive benchmarking

- User-defined competitive set: Amazon, AAA, Costco, USAA, and AMAC.
- Include AARP as the benchmark, for six organizations in total.
- This fixed set applies to competitive benchmarking. It does not replace discovery of other websites visited by AARP.org's audience.
- Compare six demographic reporting measures: age distribution, audience share by website, competitive share, average visit duration, pages per visit, and bounce rate.
- Summarize competitive values in two PowerPoint slides: audience composition/share on the first slide and engagement on the second. Append these to the previous ten-slide audience deck to make one twelve-slide presentation.
- Focus on age 55+ where supported. Age distribution uses adult unique visitors. The audience-share traffic metric may use a different basis, so verify and label its denominator rather than treating the two as independent unique-audience reach measures.
- The current Demographics interface supports selecting 55–64 and 65+ together and applying the combined cohort. Use that native combined 55+ output for engagement. Do not add or simply average age-specific durations, pages per visit, bounce rates, or competitive shares.
- Current competitive extraction: September 2026, United States, Total desktop and mobile web, all genders, Include Subdomains checked. Domains: aarp.org, amazon.com, aaa.com, costco.com, usaa.com and amac.us. AAA covers aaa.com and its subdomains, not every independently hosted regional club.
- Competitive share must use one denominator covering all six organizations. The interface supports five sites per comparison and truncates a six-site selection. The current presentation derives an approximate six-site share from two views that share an Amazon anchor: convert the sixth site's share to the first view's units using its ratio to Amazon, then normalize all six weights together. Label this approximation and disclose that displayed source shares are rounded. Do not compare unadjusted shares normalized within different subsets.

## Additional use cases to explore later

- Search topics and content gaps relevant to AARP audiences.
- Potential referral/partnership sites with relevant audience overlap.
- Acquisition-channel trends and changes in competitor visibility.
- Audience differences across AARP sections, where the available data supports that granularity.

## Current status

Similarweb access has been established during this conversation. September 2026 U.S. monthly audience data were used as the user-approved fallback. The existing workbook and presentation distinguish all-age same-day AARP.org cross-visitation from each listed site's own adult 55+ audience share. The user has now defined a separate six-organization competitive benchmark. Competitive demographic and combined 55+ engagement values have now been collected for all six organizations. The populated two-slide benchmark is appended to the earlier ten-slide audience presentation. Age data use native full-precision chart exports, engagement uses the native combined 55+ selection, and the six-site competitive share is an explicitly labeled approximation derived from two five-site views.
