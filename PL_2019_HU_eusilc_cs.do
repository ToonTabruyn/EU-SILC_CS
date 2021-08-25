/* PL_2019_HU_eusilc_cs

date created: 25/08/2021

*/

* HUNGARY - 2019

* ELIGIBILITY
/*	-> all parents are eligible for some parental leave benefits 	
	-> family entitlement 
*/

replace pl_eli = 1 			if country == "HU" & year == 2019 
replace pl_eli = 0 			if pl_eli == . & country == "HU" & year == 2019


* DURATION (weeks)
/*	-> until child is 3 years old		*/

* mothers eligible for ML
replace pl_dur = (3*52) - ml_dur2 		if country == "HU" & year == 2019 & pl_eli == 1 ///
										& gender == 1 & ml_eli == 1

* women not eligible for ML
replace pl_dur = 3*52 		if country == "HU" & year == 2019 & pl_eli == 1 ///
							& pl_dur == . 

* single men eligible for PT
replace pl_dur = (3*52) - pt_dur 		if country == "HU" & year == 2019 & pl_eli == 1 ///
										& gender == 2 & parstat == 1 & pl_dur == . & pt_eli == 1
										
* single men not eligible for PT
replace pl_dur = (3*52)		if country == "HU" & year == 2019 & pl_eli == 1 ///
										& gender == 2 & parstat == 1 & pl_dur == .
							

* BENEFIT (monthly)
/*	-> employed, self-employed compulsorily insured for at least 365 days (coded)
		in past 2 years (not coded) with the same employer (not coded): 
		-> for 2 years: 70% earning
			- ceiling: €921/month (MISSOC 2019; GYED)
		-> for 1 year: €88/month (GYES)
		
	-> female tertiary education students or women who completed at least 2 semesters
		of tertiary education in past 2 years:
		-> undergraduate, for 1 year: €460/monthly
		-> MA, PhD, for 1 year: €602/month
		-> for 2 years: €88/month
		-> not coded (EU-SILC doesn't recognise)
	
	-> all other parents: €88/month 
	
	-> family entitlement: in couples all assigned to women
*/

* GYES
gen pl_gyes = 88 		if country == "HU" & year == 2019 & pl_eli == 1
replace pl_gyes = . 	if country == "HU" & year == 2019 & pl_eli == 1 ///
						& parstat == 2 & gender == 2 			// family entitlement => in couples assign all to women


* GYED
gen pl_gyed = 0.7*earning 		if country == "HU" & year == 2019 & pl_eli == 1 ///
								& ml_eli == 1 & earning < 921 & gender == 1
							
replace pl_gyed = 921		 	if country == "HU" & year == 2019 & pl_eli == 1 ///
								& ml_eli == 1 & earning >= 921 & gender == 1

replace pl_gyed = 0.7*earning 	if country == "HU" & year == 2019 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & earning < 921 ///
								& gender == 2 & parstat == 1
							
replace pl_gyed = 921		 	if country == "HU" & year == 2019 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & earning >= 921 ///
								& gender == 2 & parstat == 1

							

replace pl_ben1 = (pl_gyed/((2*52)/3*52)) + (pl_gyes/(52/(3*52))) ///
								if country == "HU" & year == 2019 & pl_eli == 1 ///
								& ml_eli == 1 & earning < 921 & gender == 1

replace pl_ben1 = (921/((2*52)/3*52)) + (pl_gyes/(52/(3*52))) ///
								if country == "HU" & year == 2019 & pl_eli == 1 ///
								& ml_eli == 1 & earning >= 921 & gender == 1 & pl_ben1 == .
								
replace pl_ben1 = (pl_gyed/((2*52)/3*52)) + (pl_gyes/(52/(3*52))) ///
								if country == "HU" & year == 2019 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & duremp >= 12 & earning < 921 ///
								& gender == 2 & parstat == 1 & pl_ben1 == .

replace pl_ben1 = (921/((2*52)/3*52)) + (pl_gyes/(52/(3*52))) ///
								if country == "HU" & year == 2019 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & earning >= 921 ///
								& gender == 2 & parstat == 1 & pl_ben1 == . 

replace pl_ben1 = pl_gyes 		if country == "HU" & year == 2019 & pl_eli == 1 ///
								& parstat == 1 & pl_ben1 == .
								
replace pl_ben1 = pl_gyes 		if country == "HU" & year == 2019 & pl_eli == 1 ///
								& parstat == 2 & gender == 1 & pl_ben1 == . 
								

								

replace pl_ben2 = pl_gyed  		if country == "HU" & year == 2019 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & duremp >= 12 & earning < 921 ///
								& parstat == 1

replace pl_ben2 = pl_gyed  		if country == "HU" & year == 2019 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & duremp >= 12 & earning < 921 ///
								& parstat == 2 & gender == 1 & pl_ben2 == .
								
replace pl_ben2 = 921  			if country == "HU" & year == 2019 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & duremp >= 12 & earning >= 921 ///
								& parstat == 1 & pl_ben2 == .

replace pl_ben2 = 921  			if country == "HU" & year == 2019 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & duremp >= 12 & earning >= 921 ///
								& parstat == 2 & gender == 1 & pl_ben2 == .
								
replace pl_ben2 = pl_gyes 		if country == "HU" & year == 2019 & pl_eli == 1 ///
								& parstat == 1 & pl_ben2 == .
								
replace pl_ben2 = pl_gyes 		if country == "HU" & year == 2019 & pl_eli == 1 ///
								& parstat == 2 & gender == 1 & pl_ben2 == .

								
foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "SI" & year == 2019
}

replace pl_dur`x' = 0 	if pl_eli == 0 & country == "HU" & year == 2019

drop pl_gyes pl_gyed
