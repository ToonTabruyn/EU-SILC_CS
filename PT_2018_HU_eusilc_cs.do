/* PT_2018_HU_eusilc_cs

date created: 26/03/2021

*/

* HUNGARY - 2018

* ELIGIBILITY
/*	-> employed
	Source: LP&R 2018 */
	
replace pt_eli = 1 		if country == "HU" & year == 2018 & gender == 2 ///
						& econ_status == 1 & duremp >= 12
						
						
replace pt_eli = 0 		if pt_eli == . & country == "HU" & year == 2018 & gender == 2

* DURATION (weeks)
/*	-> 5 working days (LP&R 2018)
	-> 7 working days for twins (not coded; MISSOC 2018)*/
	
replace pt_dur = 5/5 	if country == "HU" & year == 2018 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% earning
	-> no ceiling 		*/ 
replace pt_ben1 = earning 	if country == "HU" & year == 2018 & pt_eli == 1
replace pt_ben2 = earning 	if country == "HU" & year == 2018 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "HU" & year == 2018
}

replace pt_dur = 0 if pt_eli == 0 & country == "HU" & year == 2018
