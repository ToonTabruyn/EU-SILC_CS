/* PT_2018_LT_eusilc_cs

date created: 29/03/2021

*/

* LITHUANIA - 2018

* ELIGIBILITY
/*	-> employed, self-employed: for 12 months (coded) during past 2 years (not coded) */

replace pt_eli = 1 		if country == "LT" & year == 2018 & gender == 2 ///
						& econ_status == 1 & duremp >= 12
replace pt_eli = 1 		if country == "LT" & year == 2018 & gender == 2 ///
						& econ_status == 2 & dursemp >= 12

replace pt_eli = 0 		if pt_eli == . & country == "LT" & year == 2018 & gender == 2

* DURATION (weeks)
/*	-> 1 month */
replace pt_dur = 4.3 	if country == "LT" & year == 2018 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% average earnings
	-> ceiling: €1,617.40/month (LP&R 2018)
*/
	
replace pt_ben1 = earning 	if country == "LT" & year == 2018 & pt_eli == 1 
							
replace pt_ben1 = 1617.40 	if country == "LT" & year == 2018 & pt_eli == 1 ///
							& pt_ben1 >= 1617.40	
							
replace pt_ben2 = pt_ben1  	if country == "LT" & year == 2018 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "LT" & year == 2018
}

replace pt_dur = 0 if pt_eli == 0 & country == "LT" & year == 2018
