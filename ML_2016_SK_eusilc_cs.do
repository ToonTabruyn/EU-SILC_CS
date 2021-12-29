/* ML_2016_SK_eusilc_cs */

* SLOVAKIA - 2016

* ELIGIBILITY
/*	-> employed
	-> self-employed
	-> 270 calendar days (coded) of work during the past 2 years	(not coded) 	
	-> single fathers can also claim "ML" 	*/
	
replace ml_eli = 1 			if country == "SK" & year == 2016 & gender == 1 /// 
							& inlist(econ_status,1,2) & (duremp+dursemp) >= (270/7)/4.3


* single men
replace ml_eli = 1 			if country == "SK" & year == 2016 & gender == 2 /// 
							& inlist(econ_status,1,2) & (duremp+dursemp) >= (270/7)/4.3 & parstat == 1

							
replace ml_eli = 0 			if ml_eli == . & country == "SK" & year == 2016 & gender == 1


* DURATION (weeks)
/*	-> total: 34 weeks obligatory (LP&R p. 304 first dot under 'flexibility in use')
	-> prenatal: 6 weeks 	
	-> single mother: 37 weeks
	-> single father: 31 weeks 
*/
	
replace ml_dur1 = 6 		if country == "SK" & year == 2016 & ml_eli == 1 & gender == 1

* cohabiting women
replace ml_dur2 = 34-6 		if country == "SK" & year == 2016 & ml_eli == 1 ///
							& gender == 1 & parstat == 2
* single women
replace ml_dur2 = 37-6		if country == "SK" & year == 2016 & ml_eli == 1 ///
							& gender == 1 & parstat == 1

* single men
replace ml_dur2 = 31		if country == "SK" & year == 2016 & ml_eli == 1 ///
							& gender == 2 & parstat == 1


* BENEFIT (monthly)
/*	-> 70% average earnings
	-> ceiling: monthly ceiling 1.5-times of national average monthly wage (has to be looked up).	*/
	
replace ml_ben1 = 0.70*earning 		if country == "SK" & year == 2016 & ml_eli == 1
replace ml_ben1 = 954				if country == "SK" & year == 2016 & ml_eli == 1 ///
									& ml_ben1 >= 954

replace ml_ben2 = ml_ben1 		if country == "SK" & year == 2016 & ml_eli == 1


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "SK" & year == 2016
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "SK" & year == 2016
}
