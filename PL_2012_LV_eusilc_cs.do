/* PL_2012_LV_eusilc_cs */


* LATVIA - 2012

* ELIGIBILITY
/*	-> all residents are eligible
	-> benefits differ based on the economic activity 
	-> leave benefits are family entitlement => assigned to women 	*/
	
replace pl_eli = 1 			if country == "LV" & year == 2012 
replace pl_eli =  0			if pl_eli == . & country == "LV" & year == 2012


* DURATION (weeks)
/*	-> employed, self-employed: until the child is 1		*/

* women	eligible for maternity leave
replace pl_dur =  52 - ml_dur2		if country == "LV" & year == 2012 & pl_eli == 1 ///
									& gender == 1
				
* single men, eligible for maternity leave
replace pl_dur = 52 - ml_dur2		if country == "LV" & year == 2012 & pl_eli == 1 ///
									& gender == 2 & parstat == 1

* BENEFIT (monthly)
/*	-> 70% earning
	-> minimum: €91/month */
	
* women, employed or self-employed
replace pl_ben1 = 0.7* earning 		if country == "LV" & year == 2012 & pl_eli == 1 ///
									& gender == 1
replace pl_ben1 = 91			if country == "LV" & year == 2013 & pl_eli == 1 ///
									& gender == 1 ///
									& pl_ben1 < 91
* single men, employed or self-employed
replace pl_ben1 = 0.7* earning 		if country == "LV" & year == 2012 & pl_eli == 1 ///
									& gender == 2 & parstat == 1							
replace pl_ben1 = 91			if country == "LV" & year == 2013 & pl_eli == 1 ///
									& gender == 2 & parstat == 1 ///
									& pl_ben1 < 91

											
replace pl_ben2 = pl_ben1 			if country == "LV" & year == 2012 & pl_eli == 1 ///
									

									

					
foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "LV" & year == 2012
}

replace pl_dur = 0 	if pl_eli == 0 & country == "LV" & year == 2012
