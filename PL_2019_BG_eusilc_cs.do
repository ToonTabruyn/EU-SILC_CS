/* PL_2019_BG_eusilc_cs

date created: 24/08/2021

*/

* BULGARIA - 2019

* ELIGIBILITY
/* 	-> Parental leave is specifically designed for women. 
	-> All women are entitled to a cash benefit. 
	
	-> single father is not automatically entitled - mother's consent is required => not coded
   Source: MISSOC 01/07/2019										*/

replace pl_eli = 1 	if country == "BG" & year == 2019 & gender == 1
replace pl_eli = 0 	if pl_eli == . & country == "BG" & year == 2008 


* DURATION (weeks)
/*	-> employed for at least 12 months: until child is 2 (coded: minus postnatal ML)
	-> all other women: until child is 1 year old			
	Source: MISSOC 01/07/2019										
*/
   
replace pl_dur = (2*52) - ((410-45)/5) 		if country == "BG" & year == 2019 & pl_eli == 1 ///
											& gender == 1 & econ_status == 1 & duremp >= 12 ///
											& pl_eli == 1
replace pl_dur = 52 		if country == "BG" & year == 2019 & pl_eli == 1 ///
							& gender == 1 & pl_dur == . & pl_eli == 1



* BENEFIT (monthly)
/*	-> women employed for at least 12 months: €194/month
	-> all other women: €51/month
	Source: MISSOC 01/07/2019
*/
   
replace pl_ben1 = 194	 if country == "BG" & year == 2019 & pl_eli == 1 ///
						 & gender == 1 & econ_status == 1 & duremp >= 12
replace pl_ben1 = 51	 if country == "BG" & year == 2019 & pl_eli == 1 ///
						 & gender == 1 & pl_ben1 == . & pl_eli == 1 


replace pl_ben2 = pl_ben1 	if country == "BG" & year == 2019 & pl_eli == 1 ///
							& gender == 1

							
foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "BG" & year == 2019
}

replace pl_dur = 0 	if pl_eli == 0 & country == "BG" & year == 2019
