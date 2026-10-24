version 17.0
clear all
set more off
* Edit these paths for your Mac. Original input files are never overwritten.
local datafile "~/Desktop/AI-horizon/data/usa_00014.dta"
local crosswalk "~/Desktop/AI-horizon/data/geocorr2022_2628705917.xlsx"
local out "~/Desktop/AI-horizon/output"
capture mkdir "`out'"
log using "`out'/expanded_age50_stata.log", text replace
* Read Expanded methods 50plus / project.md for all denominator restrictions.
* This do-file has NOT been executed in licensed Stata in the cloud.
tempfile person households states cross allmeasures
use year sample serial pernum relate statefip puma age perwt hhwt gq costelec costgas costwatr costfuel foodstmp lingisol multgend yrsusa1 citizen hinspur hinscaid diffhear diffmob gcrespon using "`datafile'", clear
keep if inlist(sample,202201,202301,202401) & inlist(year,2022,2023,2024)
isid sample serial pernum
bysort sample serial: egen byte any50 = max(age>=50 & age<999)
preserve
keep if age>=50 & age<999 & perwt>0 & perwt<.
gen double analysis_wt = perwt
save `person'
restore
keep if relate==1 & inlist(gq,1,2) & any50==1 & hhwt>0 & hhwt<.
isid sample serial
gen double analysis_wt = hhwt
save `households'

capture program drop make_measure
program define make_measure
    syntax, Variable(name) Kind(string) Measure(string) Level(string) Saving(string) [Code(integer -1) Values(numlist)]
    preserve
    tempvar value
    if "`kind'"=="utility" {
        gen double `value' = `variable' if `variable'>0 & `variable'<99990
        replace `value' = 0 if `variable'==99993
    }
    else if "`kind'"=="positive_years" {
        gen double `value' = `variable' if `variable'>0 & `variable'<99
    }
    else {
        gen byte valid = 0
        foreach x of numlist `values' {
            replace valid=1 if `variable'==`x'
        }
        gen double `value' = (`variable'==`code') if valid
        drop valid
    }
    gen double denominator = cond(`value'<.,analysis_wt,0)
    gen double numerator = cond(`value'<.,analysis_wt*`value',0)
    gen long sample_n = (`value'<.)
    collapse (sum) numerator denominator sample_n, by(year statefip puma)
    gen str6 period = "y"+string(year)
    drop year
    tempfile annual
    save `annual'
    collapse (sum) numerator denominator sample_n, by(statefip puma)
    replace numerator=numerator/3
    replace denominator=denominator/3
    gen str6 period="pooled"
    append using `annual'
    gen str3 measure="`measure'"
    gen str9 level="`level'"
    save "`saving'", replace
    restore
end

* m01: yrsusa1 — Years in U.S. mean (reported >=1 year)
tempfile m01
use `person', clear
make_measure, variable(yrsusa1) kind(positive_years) measure(m01) level(Person) saving("`m01'")

* m02: citizen — Citizenship: N/A (code 0)
tempfile m02
use `person', clear
make_measure, variable(citizen) kind(indicator) measure(m02) level(Person) saving("`m02'") code(0) values(0 1 2 3)

* m03: citizen — Citizenship: Born abroad of American parents
tempfile m03
use `person', clear
make_measure, variable(citizen) kind(indicator) measure(m03) level(Person) saving("`m03'") code(1) values(0 1 2 3)

* m04: citizen — Citizenship: Naturalized citizen
tempfile m04
use `person', clear
make_measure, variable(citizen) kind(indicator) measure(m04) level(Person) saving("`m04'") code(2) values(0 1 2 3)

* m05: citizen — Citizenship: Not a citizen
tempfile m05
use `person', clear
make_measure, variable(citizen) kind(indicator) measure(m05) level(Person) saving("`m05'") code(3) values(0 1 2 3)

* m06: hinspur — Directly purchased health insurance
tempfile m06
use `person', clear
make_measure, variable(hinspur) kind(indicator) measure(m06) level(Person) saving("`m06'") code(2) values(1 2)

* m07: hinscaid — Medicaid / government assistance coverage
tempfile m07
use `person', clear
make_measure, variable(hinscaid) kind(indicator) measure(m07) level(Person) saving("`m07'") code(2) values(1 2)

* m08: diffhear — Hearing difficulty
tempfile m08
use `person', clear
make_measure, variable(diffhear) kind(indicator) measure(m08) level(Person) saving("`m08'") code(2) values(1 2)

* m09: diffmob — Independent living difficulty
tempfile m09
use `person', clear
make_measure, variable(diffmob) kind(indicator) measure(m09) level(Person) saving("`m09'") code(2) values(1 2)

* m10: gcrespon — Responsible for grandchildren (among applicable grandparents)
tempfile m10
use `person', clear
make_measure, variable(gcrespon) kind(indicator) measure(m10) level(Person) saving("`m10'") code(2) values(1 2)

* m11: costelec — Annual electricity cost mean
tempfile m11
use `households', clear
make_measure, variable(costelec) kind(utility) measure(m11) level(Household) saving("`m11'")

* m12: costgas — Annual gas cost mean
tempfile m12
use `households', clear
make_measure, variable(costgas) kind(utility) measure(m12) level(Household) saving("`m12'")

* m13: costwatr — Annual water cost mean
tempfile m13
use `households', clear
make_measure, variable(costwatr) kind(utility) measure(m13) level(Household) saving("`m13'")

* m14: costfuel — Annual other heating fuel cost mean
tempfile m14
use `households', clear
make_measure, variable(costfuel) kind(utility) measure(m14) level(Household) saving("`m14'")

* m15: foodstmp — SNAP / food-stamp receipt
tempfile m15
use `households', clear
make_measure, variable(foodstmp) kind(indicator) measure(m15) level(Household) saving("`m15'") code(2) values(1 2)

* m16: lingisol — Linguistically isolated household
tempfile m16
use `households', clear
make_measure, variable(lingisol) kind(indicator) measure(m16) level(Household) saving("`m16'") code(2) values(1 2)

* m17: multgend — Generations: 1 generation
tempfile m17
use `households', clear
make_measure, variable(multgend) kind(indicator) measure(m17) level(Household) saving("`m17'") code(10) values(10 20 21 22 23 24 31 32)

* m18: multgend — Generations: 1-2 generations (Census 2008 definition)
tempfile m18
use `households', clear
make_measure, variable(multgend) kind(indicator) measure(m18) level(Household) saving("`m18'") code(20) values(10 20 21 22 23 24 31 32)

* m19: multgend — Generations: 2 adjacent generations: adult-child
tempfile m19
use `households', clear
make_measure, variable(multgend) kind(indicator) measure(m19) level(Household) saving("`m19'") code(21) values(10 20 21 22 23 24 31 32)

* m20: multgend — Generations: 2 adjacent generations: adult-adult
tempfile m20
use `households', clear
make_measure, variable(multgend) kind(indicator) measure(m20) level(Household) saving("`m20'") code(22) values(10 20 21 22 23 24 31 32)

* m21: multgend — Generations: 2 nonadjacent generations
tempfile m21
use `households', clear
make_measure, variable(multgend) kind(indicator) measure(m21) level(Household) saving("`m21'") code(23) values(10 20 21 22 23 24 31 32)

* m22: multgend — Generations: 2 adjacent generations: no linking spouse
tempfile m22
use `households', clear
make_measure, variable(multgend) kind(indicator) measure(m22) level(Household) saving("`m22'") code(24) values(10 20 21 22 23 24 31 32)

* m23: multgend — Generations: 3+ generations (Census definition)
tempfile m23
use `households', clear
make_measure, variable(multgend) kind(indicator) measure(m23) level(Household) saving("`m23'") code(31) values(10 20 21 22 23 24 31 32)

* m24: multgend — Generations: 3+ generations (additional IPUMS definition)
tempfile m24
use `households', clear
make_measure, variable(multgend) kind(indicator) measure(m24) level(Household) saving("`m24'") code(32) values(10 20 21 22 23 24 31 32)

use `m01', clear
append using `m02'
append using `m03'
append using `m04'
append using `m05'
append using `m06'
append using `m07'
append using `m08'
append using `m09'
append using `m10'
append using `m11'
append using `m12'
append using `m13'
append using `m14'
append using `m15'
append using `m16'
append using `m17'
append using `m18'
append using `m19'
append using `m20'
append using `m21'
append using `m22'
append using `m23'
append using `m24'
isid measure period statefip puma
save `allmeasures'
* State estimates bypass the county allocation entirely.
preserve
keep if statefip!=11
collapse (sum) numerator denominator sample_n, by(level measure period statefip)
gen double estimate=numerator/denominator
export delimited using "`out'/expanded_state_support.csv", replace
gen str16 colid=measure+"_"+period
keep statefip colid estimate
reshape wide estimate, i(statefip) j(colid) string
assert _N==50
export excel using "`out'/expanded_age50_stata.xlsx", sheet("States 50plus") firstrow(variables) replace
restore

import excel using "`crosswalk'", sheet("geocorr- SS Dependence 50") cellrange(A3:I4613) allstring clear
rename (A B C D E F G H I) (statefip puma county state county_name puma_name pop2020 county_to_puma share)
destring statefip puma share, replace
isid statefip puma county
bysort statefip puma: egen double share_sum=total(share)
assert abs(share_sum-1)<.001
drop share_sum
joinby statefip puma using `allmeasures', unmatched(both)
assert _merge==3
drop _merge
replace numerator=numerator*share
replace denominator=denominator*share
collapse (sum) numerator denominator, by(level measure period county county_name)
gen double estimate=numerator/denominator
export delimited using "`out'/expanded_county_support.csv", replace
foreach unit in Person Household {
    preserve
    keep if level=="`unit'"
    gen str16 colid=measure+"_"+period
    keep county county_name colid estimate
    reshape wide estimate, i(county county_name) j(colid) string
    if "`unit'"=="Person" local sheet "County persons 50plus"
    else local sheet "County households 50plus"
    export excel using "`out'/expanded_age50_stata.xlsx", sheet("`sheet'") firstrow(variables) sheetreplace
    restore
}
* Column mapping follows. Each mXX has pooled,y2022,y2023,y2024 columns in Stata's export.
* estimatem01_*: Person | yrsusa1 | Years in U.S. mean (reported >=1 year)
* estimatem02_*: Person | citizen | Citizenship: N/A (code 0)
* estimatem03_*: Person | citizen | Citizenship: Born abroad of American parents
* estimatem04_*: Person | citizen | Citizenship: Naturalized citizen
* estimatem05_*: Person | citizen | Citizenship: Not a citizen
* estimatem06_*: Person | hinspur | Directly purchased health insurance
* estimatem07_*: Person | hinscaid | Medicaid / government assistance coverage
* estimatem08_*: Person | diffhear | Hearing difficulty
* estimatem09_*: Person | diffmob | Independent living difficulty
* estimatem10_*: Person | gcrespon | Responsible for grandchildren (among applicable grandparents)
* estimatem11_*: Household | costelec | Annual electricity cost mean
* estimatem12_*: Household | costgas | Annual gas cost mean
* estimatem13_*: Household | costwatr | Annual water cost mean
* estimatem14_*: Household | costfuel | Annual other heating fuel cost mean
* estimatem15_*: Household | foodstmp | SNAP / food-stamp receipt
* estimatem16_*: Household | lingisol | Linguistically isolated household
* estimatem17_*: Household | multgend | Generations: 1 generation
* estimatem18_*: Household | multgend | Generations: 1-2 generations (Census 2008 definition)
* estimatem19_*: Household | multgend | Generations: 2 adjacent generations: adult-child
* estimatem20_*: Household | multgend | Generations: 2 adjacent generations: adult-adult
* estimatem21_*: Household | multgend | Generations: 2 nonadjacent generations
* estimatem22_*: Household | multgend | Generations: 2 adjacent generations: no linking spouse
* estimatem23_*: Household | multgend | Generations: 3+ generations (Census definition)
* estimatem24_*: Household | multgend | Generations: 3+ generations (additional IPUMS definition)
log close
