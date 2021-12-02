 /* PT_2019_BG_eusilc_cs */

 
* BULGARIA - 2019

* ELIGIBILITY
/*	-> Employed: at least 12 months of insurance.
	-> self-employed: voluntarily insured => not coded! 
*/
   
replace pt_eli = 1 if country == "BG" & year == 2019 & gender == 2 ///
				& econ_status == 1 & duremp == 12
replace pt_eli = 0 if pt_eli == . & country == "BG" & year == 2019 & gender == 2



* DURATION (weeks)
/*	-> 15 days */
replace pt_dur = 15/5 if country == "BG" & year == 2019 & pt_eli == 1



* BENEFIT (monthly)
/*	-> 90% earning 
	-> minimum: €235.16 for the duration of PT 
	-> ceiling: €1,329.36 for the duration of PT
	The minimum and maximum values of benefit are sourced from LP&R 2019. 
*/

	
replace pt_ben1 = ((earning * 0.9) * (15/21.7)) + (earning * ((21.7-15)/21.7)) ///
										if country == "BG" & year == 2019 ///
										& pt_eli == 1 & pt_ben1 == .
	
 
* minimum
replace pt_ben1 = 235.16 + (earning * ((21.7-15)/21.7)) 	if country == "BG" & year == 2019 ///
															& pt_eli == 1 & ((earning * 0.9) * (15/21.7)) < 235.16
 
* maximum 
replace pt_ben1 = 1329.36 + (earning * ((21.7-15)/21.7)) 	if country == "BG" & year == 2019 ///
															& pt_eli == 1 & ((earning * 0.9) * (15/21.7)) >= 1329.36
										



replace pt_ben2 = pt_ben1 if country == "BG" & year == 2019 & pt_eli == 1



foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "BG" & year == 2019
}

replace pt_dur = 0 if pt_eli == 0 & country == "BG" & year == 2019



