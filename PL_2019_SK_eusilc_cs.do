/* PL_2019_SK_eusilc_cs

date created: 21/08/2021

*/

* SLOVAKIA - 2019

* ELIGIBILITY
/*	-> employed, self-employed: parental leave
	-> all residents: benefits 
	-> benefits: family entitlement => pl_dur & pl_ben assigned to woman in couples 	
*/
	
replace pl_eli = 1 			if country == "SK" & year == 2019 
replace pl_eli =  0			if pl_eli == . & country == "SK" & year == 2019


* DURATION (weeks)
/*	-> until child is 3 years old */

* women eligible for ML
replace pl_dur = (3*52) - ml_dur2 		if country == "SK" & year == 2019 & pl_eli == 1 ///
										& gender == 1 & ml_eli == 1

* women not eligible for ML
replace pl_dur = (3*52) 		 		if country == "SK" & year == 2019 & pl_eli == 1 ///
										& gender == 1 & ml_eli == 0


* single men eligible for ML
replace pl_dur = (3*52) - ml_dur2		if country == "SK" & year == 2019 & pl_eli == 1 ///
										& gender == 2 & parstat == 1 & ml_eli == 1

* single men not eligible for ML
replace pl_dur = (3*52)					if country == "SK" & year == 2019 & pl_eli == 1 ///
										& gender == 2 & parstat == 1 & ml_eli == 0


* BENEFIT (monthly)
/*	-> €220.70/month  (per family) */

replace pl_ben1 = 220.70 		if country == "SK" & year == 2019 & pl_eli == 1 

* cohabiting men (entitlement assigned to woman)
replace pl_ben1 = 0 			if country == "SK" & year == 2019 & pl_eli == 1 ///
								& gender == 2 & parstat == 2
								
replace pl_ben2 = pl_ben1		if country == "SK" & year == 2019 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "SK" & year == 2019
}

replace pl_dur = 0 	if pl_eli == 0 & country == "SK" & year == 2019
