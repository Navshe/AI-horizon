# Project decision log

This file records consequential decisions and unresolved questions for future agents. It is not a transcript or a record of every command. Update it when an important decision changes; distinguish agreed decisions from proposals.

## Agreed decisions

### Analysis tools and execution
- The user works on a Mac with Stata 17 and does not know Python.
- Use Stata .do files for data processing and analysis. Do not require the user to learn Python.
- The initial workflow is for the user to run .do files in Stata on their Mac. Cloud execution of Stata has not been established and would require an installed, licensed copy.
- Build a reproducible Stata analysis before adding an agent interface. An agent should use the verified analysis rather than invent calculations.

### Project instructions and storage
- AGENTS.md belongs at the top level of the project folder and contains instructions for agents that can access that folder.
- This log.md records important decisions, reasons, and unresolved issues. Stata execution logs are separate files.
- Preserve original IPUMS .dta files and Excel crosswalks; save generated results separately.
- GitHub may hold .do files, project instructions, and this decision log. Keep IPUMS microdata out of GitHub.
- Local files, GitHub, and the cloud workspace are separate copies. Uploading files to this chat does not upload them to GitHub or synchronize the Mac folder.
- The selected GitHub repository is Navshe/AI-horizon. It had no commits or remote branches when inspected during onboarding; recheck before assuming its current contents.

### Data and geography
- The analysis uses IPUMS ACS data in Stata format and an Excel PUMA-to-county crosswalk.
- The uploaded geocorr2022_2628705917.xlsx includes geographic allocation factors and existing worked analyses. Preserve these as reference inputs.
- The uploaded Numbers file is an example of the extract structure, not an established complete analysis dataset. Prefer the original .dta file for execution because displayed labels and numeric formatting can obscure codes.
- Identify PUMAs using state and PUMA codes together. Preserve leading zeros in geographic identifiers.
- Use county identifiers and names from the crosswalk for allocation. The example extract includes zero county codes, so county identification in the microdata is incomplete.
- Match the ACS sample's PUMA vintage to the crosswalk. Do not assume a crosswalk is valid for every sample year.

### County estimation method
- Follow the user's existing population-weighted allocation method.
- For a PUMA proportion, first allocate its relevant weighted population to each county:
  allocated population = PUMA weighted population × PUMA-to-county allocation factor.
- Then calculate the allocated qualifying population:
  allocated qualifying population = allocated population × PUMA proportion.
- Sum both quantities within county. County proportion = summed qualifying population / summed allocated population. The summed qualifying population is the estimated county count.
- Do not average PUMA proportions using geographic allocation factors alone; use the allocated relevant population as the averaging weight.
- Label county outputs as allocated estimates. The method assumes the relevant subgroup is distributed within each PUMA according to the crosswalk shares; it does not recover exact individual county locations.
- Use person weights for person estimates. Household analyses require household weights and one record per household; do not count repeated household records as separate households.

## Evidence and limits

- The user reports having checked the crosswalk weights, counts, and calculation.
- One independent workbook spot check reproduced Madison County, Alabama's Social Security dependence proportion: approximately 0.4007141791 (40.0714%), from allocated population 77,239.7909 and qualifying population 30,951.0794.
- This was one spot check, not validation of the entire workbook, original microdata, or Stata implementation.
- No complete Stata analysis or operational agent has been built or validated in this conversation.

## Unresolved before implementing the Social Security example

- Confirm the first analysis target. Social Security dependence is a candidate based on the existing workbook, not a final user selection.
- Confirm whether “at least 50% dependent on Social Security” means incss / inctot >= 0.50, and specify treatment of zero and negative total income.
- The workbook notes age >= 62, inctot < 9999999, and incss < 99999. Confirm these against the intended universe and the original extract's codebook before implementing them.
- Confirm the complete extract's sample year(s), sample type, PUMA vintage, variable coding, and local file paths. The example shows 2022 ACS records but does not establish the scope of the full extract.
- Confirm the crosswalk allocation basis is suitable for each measure, especially household measures and age-specific subgroups.
- Decide how to handle unmatched geography, missing inputs, zero denominators, and any out-of-scope territories. Do not silently drop them or treat missing values as zero.

## Updating this log

Record new consequential decisions here with a brief reason. Do not record credentials, individual microdata records, routine command output, or unsupported claims of validation.

## Subsequent confirmed decisions

- The user selected the weighted proportion of individuals with incss / inctot >= 0.50, restricted to age >= 62. This supersedes the earlier open question about a ratio of income totals.
- Produce separate 2022, 2023, and 2024 results and a combined 2022–2024 result. Zero/negative income handling remains unresolved. See project.md for the proposed pooling convention.

- The user confirmed excluding zero or negative total income from the analysis denominator and numerator.
- The user confirmed pooling 2022–2024 using person weights rather than averaging annual percentages. These decisions supersede the earlier pending questions.

## Full-data analysis completed

- Full file obtained through user-authorized iCloud sharing. Analysis executed in Python; supplied Stata 17 code remains unexecuted in Stata.
- Output comparison workbook retains original sheets and adds NEW sheets with annual and pooled county estimates, PUMA estimates, crosswalk allocations, and validation details.
- Crosswalk rounding retained exactly; pooled weighted counts divided by three to represent average annual populations. All PUMA matches succeeded.
- Keep full dataset and signed download metadata outside GitHub.

## State estimates added

- User requested 50 states, with 2022, 2023, 2024 and pooled proportions. Exclude DC from these state sheets only.
- Sum unallocated PUMA qualifying and eligible weighted counts within state, then divide. Do not use county crosswalk shares or average PUMA percentages.
- Updated the existing GitHub comparison workbook with NEW - State estimates and NEW - State supporting counts.

- Expanded analysis requested for age 50+, with person, household and state tabs and shaded four-period measure groups. Household age-universe and categorical reporting questions remain open. Utility special codes need codebook verification; HINSPUR and DIFFMOB labels must not be misrepresented.

- User confirmed household age universe is at least one member aged 50+, not householder age. Report all categories separately for categorical measures. User needs help obtaining extract codebook.

- Received extract codebook and documented expanded workbook definitions in project.md: utility no-charge codes recoded to zero, embedded costs excluded, nominal dollar means; YRSUSA1 mean explicitly limited to reported >=1 year because zero is ambiguous; citizenship code0 labeled N/A; applicable-universe denominators for categorical measures. Existing Social Security age62+ results retained separately.

## Expanded workbook completed

- Added three primary age50+ sheets, four columns per measure/category and per-variable shading. Preserved original sheets and age62+ Social Security results.
- Used 4,405,759 eligible person records and 2,673,222 qualifying households. Household weighted estimates count each household once. State estimates bypass county allocation.
- Supplied a separate Stata17 numeric reproduction do-file; cloud calculations executed in Python. Limitations are explicit in project.md and Expanded methods 50plus.
