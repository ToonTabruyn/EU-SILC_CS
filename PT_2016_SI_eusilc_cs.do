/* PT_2016_SI_eusilc_cs */

* SLOVENIA - 2016

* ELIGIBILITY
/*	-> employed
	-> self-employed
	-> unemployed, inactive if they were compulsorily insured for at least 12 months (coded)
		over the past 3 years (not coded; LP&R 2016)
	-> benefits for unemployed and inactive people are not clearly specified in the sources => not coded
	
*/

replace pt_eli = 1 			if country == "SI" & year == 2016 & gender == 2 ///
							& inlist(econ_status,1,2) 
replace pt_eli = 1 			if country == "SI" & year == 2016 & gender == 2 ///
							& inlist(econ_status,3,4) & duremp + dursemp >= 12	
	

* DURATION (weeks)
/*	-> 30 calendar days */

replace pt_dur = 30/7 	if country == "SI" & year == 2016 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 90% earnings
	-> ceiling: E 2,863/month (LP&R 2016) 	
	-> minimum: E 842.79/month (LP&R 2016)		*/

replace pt_ben1 = 0.9*earning 	 	if country == "SI" & year == 2016 & pt_eli == 1 
replace pt_ben1 = 842.79	 	 	if country == "SI" & year == 2016 & pt_eli == 1 ///
									& pt_ben1 < 842.79
replace pt_ben1 = 2863		 	 	if country == "SI" & year == 2016 & pt_eli == 1 ///
									& pt_ben1 >= 2863


replace pt_ben2 = pt_ben1 	if country == "SI" & year == 2016 & pt_eli == 1

foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "SI" & year == 2016
}

replace pt_dur = 0 if pt_eli == 0 & country == "SI" & year == 2016
