/* PL_2019_DE_eusilc_cs

date created: 24/08/2021

*/

* GERMANY - 2019

* ELIGIBILITY
/*	-> all parents are eligible for benefits */

replace pl_eli = 1 			if country == "DE" & year == 2019 
replace pl_eli = 0 			if pl_eli == . & country == "DE" & year == 2019


* DURATION (weeks)
/*	-> benefits are family entitlement (assigned to woman)
	-> if parents interrupt their work: 12 months/parent 
	-> the maximum duration of leave is 12 months in total for both parents 
	-> bonus months if both parents take some leave: 2 months (coded as father's right)
*/
replace pl_dur = 12 		if country == "DE" & year == 2019 & pl_eli == 1 ///
							& gender == 1 
replace pl_dur = 2 			if country == "DE" & year == 2019 & pl_eli == 1 ///
							& gender == 2 & pl_dur == .

* single men
replace pl_dur = 12			if country == "DE" & year == 2019 & pl_eli == 1 ///
							& gender == 2 & parstat == 1 & pl_dur == . 


* BENEFIT (monthly)
/*	-> employed, self-employed: 65% (can be up to 67% for income below certain treshold, not coded)
	-> minimum: €300/month 
	-> maximum: €1,800/month
	-> non-working: €300/month
	-> source: LP&R 2019
	-> MISSOC 2019: benefits calculated from net income => here from gross income
	*/

replace pl_ben1 = 0.65 * earning	if country == "DE" & year == 2019 & pl_eli == 1 ///
									& pl_ben1 == .

* minimum
replace pl_ben1 = 300		if country == "DE" & year == 2019 & pl_eli == 1 ///
							& inrange(econ_status,1,2) & pl_ben1 < 300 & pl_ben1 == .

* ceiling
replace pl_ben1 = 1800		if country == "DE" & year == 2019 & pl_eli == 1 ///
							& inrange(econ_status,1,2) & pl_ben1 >= 1800 & pl_ben1 == .
							
* inactive, unemployed	
replace pl_ben1 = 300 		if country == "DE" & year == 2019 & pl_eli == 1 ///
							& inlist(econ_status,3,4) 
							
							





replace pl_ben2 = pl_ben1 		if country == "DE" & year == 2019 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "DE" & year == 2019
}

replace pl_dur = 0 	if pl_eli == 0 & country == "DE" & year == 2019
