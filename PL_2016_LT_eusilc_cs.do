/* PL_2016_LT_eusilc_cs */

* LITHUANIA - 2016

* ELIGIBILITY
/*	-> employed, self-employed for 12 months (coded) in past 2 years (not coded)
	-> family entitlement => in couples assigned to women
*/

replace pl_eli = 1 			if country == "LT" & year == 2016 & econ_status == 1 ///
							& duremp >= 12
replace pl_eli = 1 			if country == "LT" & year == 2016 & econ_status == 2 ///
							& dursemp >= 12
replace pl_eli = 1 			if country == "LT" & year == 2016 & inlist(econ_status,1,2) ///
							& duremp + dursemp >= 12
							
replace pl_eli =  0			if pl_eli == . & country == "LT" & year == 2016


* DURATION (weeks)
/*	-> parents can choose the duration of leave => affects benefits
	-> more generous option coded (until child is 1)		*/

* women	
replace pl_dur = 52-ml_dur2 		if country == "LT" & year == 2016 & pl_eli == 1 ///
									& gender == 1

* single men
replace pl_dur = 52-pt_dur 			if country == "LT" & year == 2016 & pl_eli == 1 ///
									& gender == 2 & parstat == 1
									

									


* BENEFIT (monthly)
/* 	-> choice of leave until child is 1: 100%, ceiling: €1,617.40/month (coded)
	-> choice of leave until child is 2: not coded
		- 70% earnings until child is 1, ceiling: €1,132.18/month
		- 40% of earnings for the rest of the leave, ceiling: €646.98/month */
		
replace pl_ben1 = earning 		if country == "LT" & year == 2016 & pl_eli == 1
								
replace pl_ben1 = 1617.40 		if country == "LT" & year == 2016 & pl_eli == 1 ///
								& pl_ben1 >= 1617.40


replace pl_ben2 = pl_ben1		if country == "LT" & year == 2016 & pl_eli == 1

foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "LT" & year == 2016
}

replace pl_dur = 0 	if pl_eli == 0 & country == "LT" & year == 2016
