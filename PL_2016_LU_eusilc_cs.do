/* PL_2016_LU_eusilc_cs */

* LUXEMBOURG - 2016

* ELIGIBILITY
/*	-> employed
	-> self-employed 	
	-> worked for at least 12 months (coded) before childbirth with the same employer (not coded) 	*/
	
replace pl_eli = 1 			if country == "LU" & year == 2016 & econ_status == 1 ///
							& duremp >= 12
replace pl_eli = 1 			if country == "LU" & year == 2016 & econ_status == 2 ///
							& dursemp >= 12							
replace pl_eli = 1 			if country == "LU" & year == 2016 & inlist(econ_status,1,2) ///
							& (duremp + dursemp) >= 12							

replace pl_eli =  0			if pl_eli == . & country == "LU" & year == 2016


* DURATION (weeks)
/*	-> parents can choose between 4 and 6 months of FT leave
		- the duration does not affect the monthly benefits => 6 months coded */
replace pl_dur = 6*4.3 		if country == "LU" & year == 2016 & pl_eli == 1


* BENEFIT (monthly)
/*	-> calculated using the average income over 12 month before birth and average working hours
		- this determines the ceiling on the benefits
		- the exact calculation is unclear => not coded  	*/
		
replace pl_ben1 = . 	if country == "LU" & year == 2016 & pl_eli == 1
replace pl_ben2 = .		if country == "LU" & year == 2016 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "LU" & year == 2016
}

replace pl_dur = 0 	if pl_eli == 0 & country == "LU" & year == 2016
