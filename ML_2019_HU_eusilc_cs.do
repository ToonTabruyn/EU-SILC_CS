/* ML_2019_HU_eusilc_cs

date created: 11/08/2021

*/

* HUNGARY - 2019

* ELIGIBILITY
/*	-> employed
	-> self-employed
	-> compulsorily insured for at least 365 days (coded) over the past 2 years (not coded)
	
	-> father is eligible in case of mother's death or when she is not present 
		in the household due to health reason => assumed this doesn't apply to 
		fathers when the mother abandoned the child => not coded for single men
*/
	
replace ml_eli = 1 			if country == "HU" & year == 2019 & gender == 1 ///
							& econ_status == 1 & duremp >= 12
							
replace ml_eli = 1 			if country == "HU" & year == 2019 & gender == 1 ///
							& econ_status == 2 & dursemp >= 12

replace ml_eli = 0 			if ml_eli == . & country == "HU" & year == 2019 & gender == 1


* DURATION (weeks)
/*	-> prenatal: 2 weeks are compulsory (up to 4 weeks possible; LP&R 2019) 
	-> total: 24 weeks 		*/
	
replace ml_dur1 = 2 		if country == "HU" & year == 2019 & ml_eli == 1

replace ml_dur2 = 24-2 		if country == "HU" & year == 2019 & ml_eli == 1


* BENEFIT (monthly)
/*	-> 70% earnings
	-> no ceiling			*/

replace ml_ben1 = 0.7*earning 		if country == "HU" & year == 2019 & ml_eli == 1
replace ml_ben2 = 0.7*earning 		if country == "HU" & year == 2019 & ml_eli == 1


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "HU" & year == 2019
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "HU" & year == 2019
}

