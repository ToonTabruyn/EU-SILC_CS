/* PT_2016_FR_eusilc_cs */

* FRANCE - 2016

* ELIGIBILITY
/*	-> employed
	-> self-employed 
*/

replace pt_eli = 1 		if country == "FR" & year == 2016 & gender == 2 ///
						& inlist(econ_status,1,2) 
replace pt_eli = 0 		if pt_eli == . & country == "FR" & year == 2016 & gender == 2


* DURATION (weeks)
/*	-> 11 days
	-> multiple births: 18 days  (not coded)
	-> must be taken within 4 months after childbirth (not coded)	*/ 
	
replace pt_dur = 11/5 	if country == "FR" & year == 2016 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100%
	-> 100%
	-> minimum: €9.39/day
	-> ceiling: €86/ day
	-> no ceiling in public sector (not coded; LP&R 2016)
	-> source: MISSOC 01/07/2016	*/ 

replace pt_ben1 = earning 		if country == "FR" & year == 2016 & pt_eli == 1 ///
								& pt_ben1 == .
	
* ceiling
replace pt_ben1 = ((86*5)* pt_dur) + (earning*(4.3-pt_dur)) ///
											if country == "FR" & year == 2016  ///
											& pt_eli == 1 & pt_ben1/4.3 >= (86*5)
	

* minimum
replace pt_ben1 = ((9.39*5)* pt_dur) + (earning*(4.3-pt_dur)) ///
											if country == "FR" & year == 2016  ///
											& pt_eli == 1 & pt_ben1/4.3 < (9.39*5)

											

replace pt_ben2 = pt_ben1 		if country == "FR" & year == 2016 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "FR" & year == 2016
}

replace pt_dur = 0 if pt_eli == 0 & country == "FR" & year == 2016
	
	
