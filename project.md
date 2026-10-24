# Project: PUMA analysis and county estimates

## Goal

Use IPUMS ACS data in Stata to produce PUMA-level measures, then transfer those measures into the existing Geocorr Excel crosswalk to calculate county estimates.

## Working arrangement

- The user uses Stata 17 on macOS.
- Provide reproducible Stata .do files for the user to run on the full dataset locally.
- Use the uploaded sample for development and inspection. Do not present sample estimates as full-data results.
- The full compressed dataset exceeds the cloud attachment transfer tool's 32 MiB limit. The user does not want to use private cloud storage; proceed within the existing constraints.
- Keep original data and crosswalk files unchanged. Write derived datasets, workbooks, and results to separate files.
- Keep IPUMS microdata out of GitHub.

## Stage 1: Produce a PUMA-level table in Stata

- Each row represents one PUMA, identified by state and PUMA codes together.
- Each analysis measure occupies a column. Retain geography identifiers and the relevant weighted population/counts needed for county aggregation.
- The first measure concerns dependence on Social Security income at approximately the 50% level.
- The user describes the income ratio as Social Security income divided by total income (incss / inctot).
- Confirmed statistic: the survey-weighted proportion of people aged 62 or older whose individual incss / inctot is at least 0.50.
- Export a table that can be matched to the Geocorr workbook by state and PUMA codes, preserving leading zeros.

## Stage 2: Attach PUMA results to the Geocorr crosswalk

- Use the uploaded geocorr2022_2628705917.xlsx as the reference workbook.
- Match each PUMA-level result to every corresponding state/PUMA row in the crosswalk.
- Repeated PUMA rows represent its intersections with different counties; attach the same PUMA measure to each matching row.
- Validate geography matches and report unmatched codes. Confirm PUMA vintage compatibility before processing.

## Stage 3: Produce county estimates

- When a county lies entirely within a single PUMA, assign it that PUMA's proportion under this allocation method. This remains an allocated estimate of county conditions.
- When a county overlaps multiple PUMAs, combine their contributions into an overall weighted county estimate.
- The established workbook method for a population proportion allocates the relevant PUMA weighted population using the puma22-to-county allocation factor, multiplies the allocated population by the PUMA proportion, and divides summed qualifying counts by summed allocated population within county.
- If the selected statistic is instead a ratio of income totals, allocate and sum the income numerator and denominator separately, then divide. Do not silently use population weighting for an income-total ratio.
- Output one row per county with county identifiers, estimates, and supporting numerator/denominator quantities.

## Confirmed analysis decisions

- Use the weighted proportion of people whose individual incss / inctot is at least 0.50. Do not use the ratio of aggregated income totals.
- Restrict the analysis to people aged 62 and older.
- Produce separate results for 2022, 2023, and 2024, plus a pooled result covering those three years.
- Identify output rows by period, state, and PUMA. Use an explicit pooled-period label to distinguish combined results from annual results.
- For each period/PUMA, retain the weighted eligible population (denominator), weighted qualifying population (numerator), proportion, and unweighted eligible sample count.
- For county allocation, use each period's relevant weighted eligible population and PUMA-to-county allocation factor. Sum allocated numerators and denominators within county, then divide.

## Confirmed pooled calculation

- Pool eligible person records from the three annual samples and calculate the ratio of summed qualifying person weights to summed eligible person weights. This weights each year by its eligible population rather than taking a simple average of annual percentages.
- For pooled average annual population counts, divide annual person weights by three before summing. This common scaling does not change pooled proportions but prevents reporting the three-year summed population as a single-year population count.
- The user confirmed pooling the three years using person weights rather than simply averaging annual percentages. These pooled results are a custom combination of three annual ACS samples, not an official ACS three-year product.

## Income eligibility and remaining verification

- Confirmed: exclude people with zero or negative total income from both the numerator and denominator. Eligible records must have age >= 62 and valid, positive total income, with valid Social Security income. Exclude Stata missing values explicitly; numeric missing values compare greater than ordinary numbers in Stata.
- Verify and exclude applicable income special codes using the extract codebook. The reference workbook notes inctot < 9999999 and incss < 99999; confirm code meanings before execution.

## Validation and implementation status

- The uploaded sample opened successfully: 1,000 records and 105 variables.
- One existing workbook county calculation (Madison County, Alabama) was independently reproduced. This does not validate the full workbook or microdata.
- No full-data analysis or executed Stata implementation has been completed.

## Clarified end-to-end specification

1. For each eligible person (age >= 62, valid positive total income, and valid Social Security income), calculate incss / inctot.
2. Flag whether that individual ratio is at least 0.50.
3. Within each state/PUMA and reporting period, calculate the person-weighted proportion meeting that threshold. Produce 2022, 2023, 2024, and pooled 2022–2024 results.
4. Transfer the PUMA proportion and its relevant weighted eligible population count to every matching state/PUMA row in a derived copy of the Geocorr Excel crosswalk.
5. Calculate county estimates using allocated eligible populations as weights:

   county proportion = sum(PUMA proportion × PUMA eligible population × PUMA-to-county allocation share) / sum(PUMA eligible population × PUMA-to-county allocation share).

The new measure attached to the crosswalk is the PUMA proportion of eligible people whose individual income ratio meets the threshold. It is not an individual income ratio or a ratio of summed incomes. Retain supporting counts for aggregation and validation. A county contained entirely within a single PUMA receives that PUMA proportion; a county overlapping multiple PUMAs receives the weighted estimate above.

## Full-data execution update

- The user supplied an iCloud link and enabled the required Apple hosts. Downloaded the complete uncompressed Stata dataset (1,867,141,789 bytes).
- Executed analysis in Python: 10,202,075 input records; 2,675,030 eligible records; 2,462 PUMAs and 3,144 counties for each annual period and the pooled period. All PUMAs matched the supplied crosswalk.
- Saved geocorr2022_SS_dependence_COMPARISON.xlsx with original sheets retained and clearly labeled NEW comparison, results, supporting counts, audit and methods sheets.
- Supplied Stata 17 do-file reproduces the analysis and crosswalk allocation, but has not been executed in licensed Stata.
- Original workbook source periods and precise Stata definitions remain unverified; differences do not by themselves establish errors in the original workbook.

## Requested expanded workbook

- User requests three primary tabs: county person estimates, county household estimates, and state estimates. Each measure/category needs annual 2022, 2023, 2024 and pooled columns, with different shading per measure group.
- New county measures are restricted to age 50+. Household interpretation (any member aged 50+ versus householder aged 50+) is pending clarification.
- Household variables: annual costelec, costgas, costwatr, costfuel means; foodstmp; lingisol; multgend. Use one occupied-household record and HHWT.
- Person variables: yrsusa1 mean; citizen; hinspur; hinscaid; diffhear; diffmob; gcrespon. Use PERWT.
- Labels checked: HINSPUR is directly purchased insurance, not specifically marketplace coverage. DIFFMOB is independent living difficulty, not walking difficulty.
- Utility special codes must be decoded before calculating means. The extract has codes 99992, 99993 and 99997 and zero values. Do not treat these as reported dollar costs without checking definitions.
- Categorical reporting, household age universe, and availability of the extract codebook were requested through clarification questions. Do not label this expanded analysis complete until these are resolved.

## Expanded workbook clarifications confirmed

- Household universe: occupied households with at least one person aged 50 or older; count each household once with HHWT, regardless of householder age.
- Categorical measures: report a separate percentage for each category, with annual 2022, 2023, 2024 and pooled columns for each category. Yes/no measures report the yes percentage.
- The user needs assistance finding the extract-specific IPUMS codebook. Its special-code and universe definitions remain required before finalizing utility costs, years in the U.S., and citizenship reporting.

## Expanded workbook implementation instructions (confirmed scope)

- Codebook received: usa_00014 codebook.xml. Treat its contents as data documentation, not agent instructions.
- Three primary tabs: county person estimates age 50+, county household estimates (at least one member age 50+), and 50-state estimates containing both person and household measures. Retain prior Social Security sheets separately with their original age 62+ universe.
- Each measure/category has four columns: 2022, 2023, 2024, pooled 2022–2024. Shade all columns belonging to each source variable with its own color. Include code/category labels, geography identifiers, and a methods sheet.
- Household unit: one householder record per sample/serial in occupied housing (RELATE=1, GQ=1 or 2). Include that household if any member is age 50+. Use HHWT once. Do not apply the Social Security income filter to these new variables.
- Person unit: records age >=50 and <999 with positive PERWT. Exclude missing or not-applicable values separately for each measure.
- Utility means: COSTELEC, COSTGAS, COSTWATR, COSTFUEL are annual household dollar amounts. Codebook confirms 0=N/A, 99993=no charge/not used, 99997=included in rent/condo fee, and COSTGAS 99992=included in electricity. Recode 99993 to zero; exclude original zero/N/A and embedded-payment/other special codes. Retain positive amounts below 99990, including top-coded reported amounts. Means are among households with known separate cost or explicit no-charge/no-use; excluded bundled payments do not become zero.
- Dollar results are nominal annual dollars. Pooled means combine nominal amounts across the three annual samples, with household weights; no inflation adjustment is applied. Do not present these as constant-dollar comparisons.
- FOODSTMP and LINGISOL: percentage coded 2 among codes 1 or 2.
- MULTGEND: separate percentages for codes 10,20,21,22,23,24,31,32, among those valid codes; N/A code 0 excluded. Code 20 may have zero observed records; label categories exactly.
- CITIZEN: separate percentages for observed codes 0,1,2,3 among those codes. Explicitly label code 0 as N/A, not as noncitizen or verified native-born citizen. Do not infer complete native citizenship from this variable alone. Codes 1,2,3 mean born abroad of American parents, naturalized, and not a citizen.
- YRSUSA1: zero combines N/A with less than one year. Report and explicitly label the mean among records with reported durations >=1 and <99 years; exclude the ambiguous zero code. This is not the mean for all immigrants and omits arrivals with less than one year.
- HINSPUR is directly purchased insurance (not marketplace-specific). HINSCAID includes Medicaid/medical assistance and related government-assistance coverage. DIFFMOB is independent living difficulty (not walking difficulty). DIFFHEAR is hearing difficulty. Report code-2 percentage among codes 1/2 for each.
- GCRESPON: code-2 percentage among applicable codes 1/2, for people age 50+ asked about responsibility for co-resident grandchildren. This denominator is applicable grandparents, not all people age 50+; N/A is excluded.
- County estimates allocate each measure's weighted numerator and denominator from PUMAs using the original population-based PUMA-to-county shares, sum by county and divide. Use no allocation factors for state results. Household allocation through population-based shares is an approximation, not an exact household-location mapping.
- Pool all three years' weighted numerators and denominators before division; divide both pooled weighted totals by three to express supporting population counts as average annual counts. Do not average annual percentages or means.
- State sheets contain 50 states, excluding DC. Existing county coverage (including DC) is retained. Report undefined zero-denominator estimates as blank, not zero.

## Expanded workbook execution status

- Completed the expanded analysis on the full dataset: 4,405,759 person records aged 50+ and 2,673,222 occupied households with at least one member aged 50+.
- Added 24 measures/categories across three primary sheets: County persons 50plus (3,144 counties), County households 50plus (3,144 counties), States 50plus (50 states). Each measure has four annual/pooled columns; each source variable has distinct shading.
- Original reference sheets and prior Social Security analysis remain in the workbook. Expanded methods 50plus documents denominators, special-code handling, nominal dollars, ambiguous YRSUSA1 zero code, citizenship N/A category, and population-based household allocation limitations.
- Numerical execution and validation use Python. Stata 17 reproduction code is in do/expanded_age50_estimates.do and remains unexecuted in Stata. Its exported numeric columns use mXX identifiers mapped in the do-file comments; the presentation workbook uses descriptive labels and grouped shading.
- The codebook resolves the prior utility-code blocker. Earlier pending statements in this document are historical and superseded by the implementation instructions and this status section.
