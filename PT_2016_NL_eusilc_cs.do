/* PT_2016_NL_eusilc_cs */


* NETHERLANDS - 2016

* ELIGIBILITY 
/* -> employed (LP&R 2016) */

replace pt_eli = 1 		if country == "NL" & year == 2016 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "NL" & year == 2016 & gender == 2


* DURATION (weeks)
/* Can be up to 5 days long but 3 days have to be taken from parental leave 
=> coded as 2 days of leave */

replace pt_dur = 2/5 if country == "NL" & year == 2016 & pt_eli == 1  // LP&R 2016


* BENEFIT (monthly)
/*	-> 100% of earning
	-> ceiling: €203.85/day (not coded		
	(MISSOC 01/07/2016)		*/
	
replace pt_ben1 = earning 		if country == "NL" & year == 2016 & pt_eli == 1
replace pt_ben2 = 203,85 * 21.7		if country == "NL" & year == 2016 & pt_eli == 1 & earning >= 203.85 * 21.7


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "NL" & year == 2016
}

replace pt_dur = 0 if pt_eli == 0 & country == "NL" & year == 2016
