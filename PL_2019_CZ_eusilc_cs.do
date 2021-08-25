/* PL_2019_CZ_eusilc_cs

date created: 24/08/2021

*/

* CZECHIA - 2019

* ELIGIBILITY
/*	-> cash benefits are available to all residents
	-> all employees are entitled to parental leave 
*/
	
replace pl_eli = 1 		if country == "CZ" & year == 2019 
replace pl_eli = 0 		if pl_eli == . & country == "CZ" & year == 2019

* DURATION (weeks)
/*	-> parents choose the monthly benefit amount (determines also the duration of PL) 

	-> maximum amount of benefit for the whole period: €8,650  
   
	-> if at least one of the parents have sickness insurance:
		-> 70% of the daily assessment base
		-> ceiling: €1,576/month 
    
	-> The benefit is calculated from the higher daily assessment base (if man's dab is higher, it is calculated
		from his daily assessment base; if woman's dab is higher, it is calculated from hers).
	-> If neither of the parents have sickness insurance: €299/month 
		
	-> the most generous benefit is coded
   
	-> Social insurance is obligatory for employees, voluntary for self-employed (not coded)
	
	-> family entitlement => couples - all assigned to woman
*/


* Daily assessment base
/* daily assessment base (source: MISSOC 2019, IV. Maternity/Paternity):
	-> Benefits are not calculated from earnings but from a "daily assessment base" (MISSOC 01/07/2019) 
	-> up to €43/day = 100% daily earning
	-> €43 - €64/day = 60% daily earning
	-> €58 - €115/day = 30% daily earning  
	-> earning overe €115/day are not taken into account
*/

* daily earning < €43
gen dab = earning/21.7 				if country == "CZ" & year == 2019 & pl_eli == 1 ///
									& earning/21.7 < 43

* daily earning between €43 and €64
gen dab1 = 43 							if country == "CZ" & year == 2019 & pl_eli == 1 ///
									& 	inrange(earning/21.7,43,63)
gen dab2 = ((earning/21.7) - 43)*0.6 	if country == "CZ" & year == 2019 & pl_eli == 1 ///
										& inrange(earning/21.7,43,63)
replace dab = dab1 + dab2 				if country == "CZ" & year == 2019 & pl_eli == 1 ///
										& inrange(earning/21.7,43,63) & dab == .
drop dab1 dab2
										

* daily earning between €64 and €129										
gen dab1 = 43 						if country == "CZ" & year == 2019 & pl_eli == 1 ///
									& inrange(earning/21.7,64,129)
gen dab2 = (64 - 43)*0.6 			if country == "CZ" & year == 2019 & pl_eli == 1 ///
									& inrange(earning/21.7,64,129)
gen dab3 = ((earning/21.7) - 64)*0.3 	if country == "CZ" & year == 2019 & pl_eli == 1 ///
										& inrange(earning/21.7,64,129)

replace dab = dab1 + dab2 + dab3  	if country == "CZ" & year == 2019 & pl_eli == 1 ///
									& inrange(earning/21.7,64,129) & dab == .									
drop dab1 dab2 dab3 

* daily earning over €115
gen dab1 = 43 						if country == "CZ" & year == 2019 & pl_eli == 1 ///
									& earning/21.7 > 129
gen dab2 = (64 - 43)*0.6 			if country == "CZ" & year == 2019 & pl_eli == 1 ///
									& earning/21.7 > 129
										
gen dab3 = (129 - 64)*0.3 			if country == "CZ" & year == 2019 & pl_eli == 1 ///
									& earning/21.7 > 129

replace dab = dab1 + dab2 + dab3 	if country == "CZ" & year == 2019 & pl_eli == 1 ///
									& earning/21.7 > 129 & dab == . 		
									
									
									
* single, not employed   
replace pl_dur = (8650/299)*4.3 		if country == "CZ" & year == 2019 & pl_eli == 1 ///
										& econ_status != 1 & parstat == 1
* couple, neither is working
replace pl_dur = (8650/299)*4.3 		if country == "CZ" & year == 2019 & pl_eli == 1 ///
										& econ_status != 1 & p_econ_status != 1 & parstat == 2
										

										
* single, employed
replace pl_dur = (8650 / ((0.7*dab)*21.7))*4.3 		if country == "CZ" & year == 2019 & pl_eli == 1 ///
													& econ_status == 1 & parstat == 1 & pl_dur == . 
													
* couple, woman over ceiling
replace pl_dur = (8650/1576)*4.3 			if country == "CZ" & year == 2019 & pl_eli == 1 ///
											& econ_status == 1 & parstat == 2 & gender == 1 ///
											& ((0.7*dab)*21.7) >= 1576
											
* couple, woman higher earning than man
replace pl_dur = (8650/((0.7 * dab)*21.7)) * 4.3 	if country == "CZ" & year == 2019 & pl_eli == 1 ///
													& econ_status == 1 & parstat == 2 & gender == 1 ///
													& ((0.7*dab)*21.7) < 1576 



* BENEFIT (monthly)
/* For explanation see "Duration (weeks)" above. 
   pl_ben2/3 refer to the most generous benefit 		*/

replace pl_ben1 = 299 					if country == "CZ" & year == 2019 & pl_eli == 1 ///
										& econ_status != 1 & parstat == 1
										
										
replace pl_ben1 = 0.7*(21.7*dab) 		if country == "CZ" & year == 2019 & pl_eli == 1 ///
										& econ_status == 1 & parstat == 2 & earning > p_earning ///
										& pl_ben1 == . 
										
										
replace pl_ben1 = 1576 					if country == "CZ" & year == 2019 & pl_eli == 1 ///
										& econ_status == 1 & pl_ben1 > 1576

replace pl_ben2 = pl_ben1 				if country == "CZ" & year == 2019 & pl_eli == 1 ///
										& econ_status == 1 & pl_ben1 > 1576



foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "CZ" & year == 2019
}

replace pl_dur = 0 	if pl_eli == 0 & country == "CZ" & year == 2019

drop dab dab1 dab2 dab3 
