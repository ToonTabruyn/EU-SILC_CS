/* ML_2018_GB_eusilc_cs

date created: 02/04/2021

*/

* UK - 2018

* ELIGIBILITY
/*	-> employed, self-employed: 
		- for 26 weeks before childbirth 
		- earning at least E 34/week
	-> further restrictions for entitlement to cash benefits
	
	-> part of ML can be shared with the father (shared parental leave) if:
		- mother: 
			- employed by the same employer for at least 26 weeks 
		- father/partner:
			- employed or self-employed for at least 26 weeks
			- earned at least E 441 in total during 13 weeks within 66 weeks before the birth
	-> single fathers are not entitled to shared parental leave because it is 
	   dependent on the mother's economic status
*/

replace ml_eli = 1 			if country == "GB" & year == 2018 & gender == 1 ///
							& inlist(econ_status,1,2) & (earning/4.3) >= 34

* father's eligibility for shared parental leave 
replace ml_eli = 1 			if country == "GB" & year == 2018 & gender == 2 ///
							& inlist(econ_status,1,2) & (duremp+dursemp) >= 26/4.3 ///
							& (earning*(13/4.3)) >= 441 & p_econ_status == 1 ///
							& (p_duremp+p_dursemp) >= 26/4.3
							
replace ml_eli = 0 			if ml_eli == . & country == "GB" & year == 2018 & gender == 1

* DURATION (weeks)
/*	-> employed if:
		- employed by the same employer (not coded)
		- for 26 weeks 
		- average weekly earnings at least €131
		- duration: 52 weeks  
		
	-> self-employed and employed if
		- working for at least 26 weeks (coded) in the 66 weeks before birth (not coded)
		- average weekly earnings at least €34
		- duration: 39 weeks
		
	-> no compulsory prenatal leave (can take up to 11 weeks)
	
	-> shared parental leave: 50 weeks (without 2 compulsory weeks of ML)
		- not exclusive right of the father => not coded 
	
*/

replace ml_dur1 = 0 		if country == "GB" & year == 2018 & ml_eli == 1 & gender == 1

replace ml_dur2 = 52 		if country == "GB" & year == 2018 & ml_eli == 1 ///
							& econ_status == 1 & duremp >= 26/4.3 ///
							& (earning/4.3) >= 131 & gender == 1
							
replace ml_dur2 = 39		if country == "GB" & year == 2018 & ml_eli == 1 ///
							& inlist(econ_status,1,2) & ml_dur2 == . ///
							& (earning/4.3) >= 34 & gender == 1



* BENEFIT (monthly)
/*	->  employed women who fulfil the stricter conditions (see "Duration"):
			- 6 weeks: 90% earnings (taxed)
			- 33 weeks: 90% earnings (taxed)
				- ceiling: €164/week 
			- 13 weeks: unpaid
			
	-> employed and self-employed:
			-39 weeks: 90% earning (not taxed)
				- ceiling: €164/week 
*/

gen ceiling = 0.9*earning

replace ml_ben1 = (((0.9 * earning) * (6/52)) + ((0.9 * earning) * (33/52))) / 12		/// 
							if country == "GB" & year == 2018 & ml_eli == 1 ///
							& econ_status == 1 & duremp >= 26/4.3 ///
							& (earning/4.3) >= 131 
							
replace ml_ben1 = (((0.9*earning) * (6/52)) + ((164 * 4.3) * 33/52)) / 12		/// 
							if country == "GB" & year == 2018 & ml_eli == 1 ///
							& econ_status == 1 & duremp >= 26/4.3 ///
							& (earning/4.3) >= 131 & ml_ben1 >= (164*4.3)
							
replace ml_ben1 = 0.9 * earning 		if country == "GB" & year == 2018 & ml_eli == 1 ///
										& inlist(econ_status,1,2) & ml_ben1 == . ///
										& (earning/4.3) >= 34

replace ml_ben1 = 164*4.3 				if country == "GB" & year == 2018 & ml_eli == 1 ///
										& inlist(econ_status,1,2)  ///
										& (earning/4.3) >= 34 & ml_ben1 >= (164*4.3)


										
										
replace ml_ben2 = 0.9 * earning 		if country == "GB" & year == 2018 & ml_eli == 1 ///
										& econ_status == 1 & duremp >= 26/4.3 ///
										& (earning/4.3) >= 131

replace ml_ben2 = 0.9 * earning 		if country == "GB" & year == 2018 & ml_eli == 1 ///
										& inlist(econ_status,1,2) & ml_ben1 == . ///
										& (earning/4.3) >= 34

replace ml_ben2 = 164*4.3 				if country == "GB" & year == 2018 & ml_eli == 1 ///
										& inlist(econ_status,1,2)  ///
										& (earning/4.3) >= 34 & ml_ben1 >= (164*4.3)

										
										
foreach x in 1 2 {
	replace ml_dur`x' = 0 	if country == "GB" & year == 2018 & ml_eli == 0
	replace ml_ben`x' = 0 	if country == "GB" & year == 2018 & ml_eli == 0
	
}

drop ceiling
