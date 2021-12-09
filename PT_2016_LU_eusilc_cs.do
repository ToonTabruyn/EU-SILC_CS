/* PT_2018_LU_eusilc_cs */


* LUXEMBOURG - 2018

* ELIGIBILITY
/*	-> employed  (LP&R 2018) */

replace pt_eli = 1 		if country == "LU" & year == 2018 & gender == 2 & econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "LU" & year == 2018 & gender == 2


* DURATION (weeks)
/*	-> 10 days */
replace pt_dur = 10/5 	if country == "LU" & year == 2018 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% 
	-> ceiling: €9992.95/month	(LP&R 2018)	*/
	
replace pt_ben1 = earning 	if country == "LU" & year == 2018 & pt_eli == 1

* ceiling
replace pt_ben1 = (9992.05 * (pt_dur/4.3)) + (earning * ((4.3-pt_dur)/4.3)) ///
							if country == "LU" & year == 2018 & pt_eli == 1 ///
							& earning >= 9992.95

replace pt_ben2 = pt_ben1 	if country == "LU" & year == 2018 & pt_eli == 1

foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "LU" & year == 2018
}

replace pt_dur = 0 if pt_eli == 0 & country == "LU" & year == 2018
