# Similar Web Retrieval

## Purpose and organization

Use Similarweb data to identify findings relevant to AARP. Start with two use cases and expand as useful opportunities emerge. The user referenced prior Resonate work as a model; its methods and outputs have not been supplied here, so do not assume they are known.

Keep this project in similar-web-retrieval/ within Navshe/AI-horizon, separate from the existing IPUMS/Stata analysis. No implementation language is selected. The user does not need to learn a programming language.

## Use case 1: Share of voice

- Compare AARP's visibility or traffic with a defined set of peer/competitor websites.
- Specify the market, time period, devices, channel, comparator domains, and metric for every comparison.
- Distinguish total traffic share from organic-search, paid-search, referral, and topic/keyword share of voice. These are different measures and depend on subscription availability.
- For a selected metric, calculate AARP's share as AARP's value divided by the total for the explicitly named comparison set. Label the denominator; do not present a selected-set share as share of the entire market.
- Look for monthly trends, topics where AARP leads or trails, and actionable opportunities.

## Use case 2: Audience interests and other websites

- Investigate interests/categories and other websites associated with the audience visiting AARP's website, using the features available in the subscription.
- Distinguish audience overlap or affinity from actual referral traffic and traffic journeys. Visiting another website does not establish the order of visits or a referral relationship.
- Report the metric provided (such as overlap, reach, or affinity), geography, period, device coverage and comparison baseline.
- Treat findings as aggregate modeled audience information, not identification of individual visitors or proof of an individual's interests.
- Do not label the audience as AARP members or age50+ unless a supported filter/data source establishes that definition. The Stata project's age restriction does not automatically apply here.

## Proposed starting scope, pending confirmation

- Domain: aarp.org. Confirm additional AARP domains/subdomains and product sites to include.
- Geography: United States.
- Period: most recent 12 complete months available, with monthly trends where supported.
- Devices: all available web devices, with coverage explicitly documented.
- Comparator set: to be defined with the user; do not invent a definitive list.
- Deliverables: a concise findings report and Excel tables, with source/report names, extraction dates, filters, metric definitions and caveats. Format and retrieval frequency remain open.

## Access and source handling

- The user is willing to provide Similarweb access. Do not request passwords, MFA codes or session cookies in chat or commit them to GitHub.
- No Similarweb connector or interactive browser is currently available in this workspace. Direct login access has not been established. An account login does not establish API entitlement.
- Establish a supported secure access mechanism before promising direct platform exploration. If unavailable, analyze user-provided Similarweb exports, or use an API if the subscription provides it and credentials can be supplied securely.
- Never copy credentials into code, project instructions, logs, or reports. Keep licensed/private exports out of GitHub unless publication is explicitly authorized and permitted.
- Record unavailable reports and subscription limits. Never invent results or treat absent data as zero.

## Additional use cases to explore later

- Search topics and content gaps relevant to AARP audiences.
- Potential referral/partnership sites with relevant audience overlap.
- Acquisition-channel trends and changes in competitor visibility.
- Audience differences across AARP sections, where the available data supports that granularity.

## Current status

Project scope documented. No Similarweb account has been accessed and no Similarweb findings have been collected. Next prerequisites are the access route, comparison domains, and confirmation of the proposed starting scope.
