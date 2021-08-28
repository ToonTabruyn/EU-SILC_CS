clear	
set more off

* original data
global sourcepath "/Users/temery/Documents/EuroSym/to merge 2018/Cross/Cross"
* temporary data folder
global datapath "/Users/temery/Documents/EuroSym/EUSILC"
* merged EU-SILC data folder
global outpath "/Users/temery/Documents/EuroSym"
cd "${datapath}" // Selecteer een working directory waar de files opgeslagen worden

**IS UK to be added with 2019 data
local countries "AT BE BG CH CY CZ DE DK EE EL ES FI FR HR HU IE IS IT LT LU LV MT NL NO PL PT RO SE SI SK UK"
local countries_x "BE BG CH CY CZ DE DK EE EL ES FI FR HR HU IE IS IT LT LU LV MT NL NO PL PT RO SE SI SK UK"
local time "18 19"


foreach x in D H P R {
	foreach t of local time {
		foreach c of local countries {
			insheet using "$sourcepath/`c'/20`t'/UDB_c`c'`t'`x'.csv", names clear
			save "$datapath/UDB_`c'`x'`t'.dta", replace
		}	
	}
}


foreach x in D H P R {
	foreach t of local time {
		use "$datapath/UDB_AT`x'`t'.dta", clear
		foreach c of local countries_x {
			append using "$datapath/UDB_`c'`x'`t'.dta", force
		}
		save "$datapath/UDB_C`t'`x'.dta", replace
	}
}


local time "18 19"

quietly foreach t of local time {
noisily: display "Preparing EU-SILC 20`t'" 

	
	local prefix "UDB_C`t'"
	local suffix ""
	local year 20`t'
	global versdat 1

	*link R and P files
			
	use "${datapath}/`prefix'R`suffix'", clear 
				
	foreach var of varlist _all {
		local newname = lower("`var'")
		cap rename `var' `newname'
		}

	cap rename rb010 year
	cap rename rb020 country
	cap rename rb030 pid
	cap rename rx030 hid

	sort year country pid
	compress
	save "r-file`year'.dta", replace

	use "${datapath}/`prefix'P`suffix'", clear

	foreach var of varlist _all {
		local newname = lower("`var'")
		cap rename `var' `newname'
		}
		
	cap rename pb010 year
	cap rename pb020 country
	cap rename pb030 pid

	cap sort year country pid
	compress
	save "p-file`year'.dta", replace

	merge 1:1 year country pid using "r-file`year'.dta"

	cap rename _merge _mergeRP
	sort country hid
	save "rp-file`year'.dta", replace

	*link H file and D file

	use "${datapath}/`prefix'H`suffix'" , clear 

	foreach var of varlist _all {
		local newname = lower("`var'")
		cap rename `var' `newname'
	}

	cap rename hb010 year
	cap rename hb020 country
	cap rename hb030 hid

	sort year country hid
	compress
	save "h-file`year'.dta", replace

	use "${datapath}/`prefix'D`suffix'", clear
	compress
	foreach var of varlist _all {
		local newname = lower("`var'")
		cap rename `var' `newname'
		}
		
	cap rename db010 year
	cap rename db020 country
	cap rename db030 hid

	sort year country hid
	save "d-file`year'.dta", replace
				
	merge 1:1 year country hid using "h-file`year'.dta"
	cap rename _merge _mergeDH
	sort country hid

	save "hd-file`year'.dta", replace

	*link RP file and HD file

	merge 1:m year country hid using "rp-file`year'.dta"

	cap drop __*
	compress
	save "${outpath}/SILC`year'.dta", replace

	erase "r-file`year'.dta"
	erase "p-file`year'.dta"
	erase "rp-file`year'.dta"
	erase "d-file`year'.dta"
	erase "h-file`year'.dta"
	erase "hd-file`year'.dta"
}
