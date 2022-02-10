/* ML_2012_LV_eusilc_cs */

* LATVIA - 2012

* ELIGIBILITY
/*	-> incapacity for work certified by doctor (not coded, MISSOC 2012)			*/
	
replace ml_eli = 1 			if country == "LV" & year == 2012 & gender == 1 ///
							& inlist(econ_status,1,2) 

* single men
replace ml_eli = 1 			if country == "LV" & year == 2012 & gender == 2 ///
							& inlist(econ_status,1,2) & parstat == 1
							
replace ml_eli = 0 			if ml_eli == . & country == "LV" & year == 2012 & gender == 1


* DURATION (weeks)
/*	-> total: 112 calendar days
	-> father who takes ML from mother: 42 calendar days (coded) within 70 calendar days since birth (not 		
		coded)	*/

replace ml_dur1 = 0		if country == "LV" & year == 2012 & ml_eli == 1

replace ml_dur2 = 112/7 		if country == "LV" & year == 2012 & ml_eli == 1 & gender == 1
replace ml_dur2 = 42/7					if country == "LV" & year == 2012 & ml_eli == 1 & gender == 2


* BENEFIT (monthly)
/*	-> 80% gross earnings, no ceiling */

replace ml_ben1 = 0.8*earning 		if country == "LV" & year == 2012 & ml_eli == 1
replace ml_ben2 = ml_ben1 			if country == "LV" & year == 2012 & ml_eli == 1


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "LV" & year == 2012
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "LV" & year == 2012
}

