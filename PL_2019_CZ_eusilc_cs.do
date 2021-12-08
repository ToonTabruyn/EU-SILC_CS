/* PL_2019_CZ_eusilc_cs */


* CZECHIA - 2019

* ELIGIBILITY
/*	-> cash benefits are available to all residents
	-> all employees are entitled to parental leave 
*/
	
replace pl_eli = 1 		if country == "CZ" & year == 2019 
replace pl_eli = 0 		if pl_eli == . & country == "CZ" & year == 2019

* DURATION (weeks)
/*	-> the duration of benefit payment is dependent on the monthly amount of benefits 
		parents choose (with ceiling & maximum benefit for the whole period of parental leave)
	-> it is calculated using the Daily Assessment Base (see Maternity Leave)

	-> maximum amount of benefit for the whole period: €8,650  
   
	-> if at least one of the parents has social insurance 
		(compulsory for employed, voluntary for self-employed - not coded):
		
		-> 70% of the daily assessment base (dab)
		-> ceiling: €1,576/month 
	-> If neither of the parents have social insurance: €299/month 
    
	-> either parent's earnings can be used for calculating the benefit
		-> OFPP uses women's earning if she is employed
		-> not employed women living in partnership: man's earning
	
	-> family entitlement => couples - all assigned to woman
*/


* Daily assessment base

/* daily assessment base (source: MISSOC 2019, IV. Maternity/Paternity):
 
	-> up to €43/day = 100% daily earning
		-> €43 - €64/day = 60% daily earning
		-> €64/day = 30% daily earning  
		-> earnings over €129/day are not taken into account
		
	NOTE: 	DAB calculated in ML section
			Here only DAB for partner's variables (p_*)
*/

*** Daily Assessment Base of partners (if woman not employed)

* daily earning < 43
gen p_dab = p_earning/21.7 				if country == "CZ" & year == 2019 ///
										& (p_earning/21.7) < 43 & parstat == 2 ///
										& econ_status != 1 & p_econ_status == 1

* daily earning between €43 and €64
gen p_dab1 = 43 							if country == "CZ" & year == 2019 ///
											& inrange(p_earning/21.7,43,64) & parstat == 2 ///
											& econ_status != 1 & p_econ_status == 1
											
gen p_dab2 = ((p_earning/21.7) - 43)*0.6 	if country == "CZ" & year == 2019 ///
											& inrange(p_earning/21.7,43,64) & parstat == 2 ///
											& econ_status != 1 & p_econ_status == 1
											 
replace p_dab = p_dab1 + p_dab2 			if country == "CZ" & year == 2019 ///
											& inrange(p_earning/21.7,43,64) & p_dab == .  ///
											& parstat == 2 & econ_status != 1 & p_econ_status == 1
drop p_dab1 p_dab2

										
* daily earning between €64 and €129										
gen p_dab1 = 43 						if country == "CZ" & year == 2019  ///
										& inrange(p_earning/21.7,64,129) ///
										& parstat == 2 & econ_status != 1 & p_econ_status == 1
										
gen p_dab2 = (64 - 43)*0.6 				if country == "CZ" & year == 2019 ///
										& inrange(p_earning/21.7,64,129) ///
										& parstat == 2 & econ_status != 1 & p_econ_status == 1
										
gen p_dab3 = ((p_earning/21.7) - 64)*0.3 	if country == "CZ" & year == 2019 ///
											& inrange(p_earning/21.7,64,129) & parstat == 2 ///
											& econ_status != 1 & p_econ_status == 1

										
replace p_dab = p_dab1 + p_dab2 + p_dab3  		if country == "CZ" & year == 2019 ///
												& inrange(p_earning/21.7,64,129)  ///
												& p_dab == . & parstat == 2 & econ_status != 1 ///
												& p_econ_status == 1
drop p_dab1 p_dab2 p_dab3 


* daily earning over €129
gen p_dab1 = 43 						if country == "CZ" & year == 2019  ///
										& p_earning/21.7 > 129 ///
										& parstat == 2 & econ_status != 1  & p_econ_status == 1
										
gen p_dab2 = (64 - 43)*0.6 				if country == "CZ" & year == 2019 ///
										& p_earning/21.7 > 129 & parstat == 2 ///
										& econ_status != 1 & p_econ_status == 1
										
gen p_dab3 = (129 - 64)*0.3			 	if country == "CZ" & year == 2019 ///
										& p_earning/21.7 > 129  & parstat == 2 ///
										& econ_status != 1 & p_econ_status == 1

										
replace p_dab = p_dab1 + p_dab2 + p_dab3  		if country == "CZ" & year == 2019 ///
												& p_earning/21.7 > 129   ///
												& p_dab == . & parstat == 2 & econ_status != 1 ///
												& p_econ_status == 1
drop p_dab1 p_dab2 p_dab3 


											
										
*** DURATION
/* -> maximum amount of benefit for the whole period: €8,650  
   
	-> if at least one of the parents has social insurance:
		-> 70% of the daily assessment base (dab)
		-> ceiling: €1,576/month 
		-> If neither of the parents have social insurance: €299/month 
	-> social insurance compulsory only for employees
*/									

* SINGLE (women & men)
	* not employed
replace pl_dur = (8650/299) * 4.3		if country == "CZ" & year == 2019 & pl_eli == 1 ///
										& econ_status != 1 & parstat == 1

	* employed
replace pl_dur = (8650 / ((0.7*dab)*21.7)) * 4.3 		if country == "CZ" & year == 2019 & pl_eli == 1 ///
														& econ_status == 1 & parstat == 1 & pl_dur == . ///
														& earning/21.7 < 1567
	* employed, above ceiling	
replace pl_dur = (8650 /1576) * 4.3 					if country == "CZ" & year == 2019 & pl_eli == 1 ///
														& econ_status == 1 & parstat == 1 & pl_dur == . ///
														& earning/21.7 >= 1567


* COUPLE (assigned to women)
	* neither is working														
replace pl_dur = (8650/299)*4.3 		if country == "CZ" & year == 2019 & pl_eli == 1 ///
										& econ_status != 1 & !inlist(p_econ_status,.,1) & parstat == 2
										
	* woman not employed, man employed, below ceiling
replace pl_dur = (8650/((0.7 * p_dab)*21.7)) * 4.3 	if country == "CZ" & year == 2019 & pl_eli == 1 /// 
													& p_econ_status == 1 & !inlist(econ_status,.,1) ///
													& parstat == 2 & ((0.7*p_dab)*21.7) < 1576
																										
	* woman not employed, man employed, above ceiling
replace pl_dur = (8650/1576) * 4.3					if country == "CZ" & year == 2019 & pl_eli == 1 /// 
													& p_econ_status == 1 & econ_status != 1 ///
													& parstat == 2 & ((0.7*p_dab)*21.7) >= 1576
															
	* woman employed, below ceiling
replace pl_dur = (8650/((0.7 * dab)*21.7)) * 4.3 	if country == "CZ" & year == 2019 & pl_eli == 1 /// 
													& econ_status == 1 & parstat == 2 ///
													& ((0.7*dab)*21.7) < 1576

	* woman employed, above ceiling
replace pl_dur = (8650/1576) * 4.3				 	if country == "CZ" & year == 2019 & pl_eli == 1 /// 
													& econ_status == 1 & parstat == 2 ///
													& ((0.7*dab)*21.7) >= 1576
	
	
	

										

* BENEFIT (monthly)
/* For explanation see "Duration (weeks)" above. 
   pl_ben2/3 refer to the most generous benefit 		*/
   
   
* SINGLE
	* not employed
replace pl_ben1 = 299 					if country == "CZ" & year == 2019 & pl_eli == 1 ///
										& econ_status != 1 & parstat == 1
										
	* employed, below ceiling
replace pl_ben1 = 0.7 * (21.7*dab)		if country == "CZ" & year == 2019 & pl_eli == 1 ///
										& econ_status == 1 & parstat == 1 & earning/21.7 < 1576
										
	* employed, above ceiling
replace pl_ben1 = 1576					if country == "CZ" & year == 2019 & pl_eli == 1 ///
										& econ_status == 1 & parstat == 1 & earning/21.7 >= 1576

	
		
* COUPLE (assigned to women)
	* neither employed
replace pl_ben1 = 299 					if country == "CZ" & year == 2019 & pl_eli == 1 ///
										& econ_status != 1 & !inlist(p_econ_status,.,1) & parstat == 2
										
	* woman not employed, man employed, below ceiling
replace pl_ben1 =  0.7 * (21.7*p_dab)	if country == "CZ" & year == 2019 & pl_eli == 1 ///
										& econ_status != 1 & p_econ_status == 1 & parstat == 2 ///
										& p_earning/21.7 < 1576
	
	* woman not employed, man employed, above ceiling
replace pl_ben1 =  1576					if country == "CZ" & year == 2019 & pl_eli == 1 ///
										& econ_status != 1 & p_econ_status == 1 & parstat == 2 ///
										& p_earning/21.7 >= 1576	
										
	* woman employed, below ceiling
replace pl_ben1 =  0.7 * (21.7*dab)	if country == "CZ" & year == 2019 & pl_eli == 1 ///
										& econ_status == 1 & parstat == 2 ///
										& earning/21.7 < 1576
	
	* woman employed, above ceiling
replace pl_ben1 =  1576					if country == "CZ" & year == 2019 & pl_eli == 1 ///
										& econ_status == 1 & parstat == 2 ///
										& earning/21.7 >= 1576
	

replace pl_ben2 = pl_ben1 				if country == "CZ" & year == 2019 & pl_eli == 1 



foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "CZ" & year == 2019
}

replace pl_dur = 0 	if pl_eli == 0 & country == "CZ" & year == 2019

drop dab dab1 dab2 dab3 
