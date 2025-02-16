/* PL_2019_PT_eusilc_cs

date created: 21/08/2021

*/

* PORTUGAL - 2019

* ELIGIBILITY
/*	-> pooled rights (i.e. individual and family rights to leave)
		- total leave: 120 or 150 (parents' choice)
		- PL refers to the share of leave without the leave reserved for mother and father
	-> compulsory social insurance for employed and self-employed 
		- 6 months of work before childbirth	
	-> includes the portion of the intitial parental period that is a family right, and 
		extended parental period that is a family right
	-> family right => in couples leave assigned to woman */
		
replace pl_eli = 1 			if country == "PT" & year == 2019 & econ_status == 1 ///
							& duremp >= 6
replace pl_eli = 1 			if country == "PT" & year == 2019 & econ_status == 2 ///
							& dursemp >= 6
replace pl_eli = 1 			if country == "PT" & year == 2019 & inlist(econ_status,1,2) ///
							& duremp + dursemp >= 6
							
replace pl_eli =  0			if pl_eli == . & country == "PT" & year == 2019


* DURATION (weeks)
/*	-> coded more generous leave (150 days; payment identical as 120%) - family 
		right portion of the initial parental leave 
	-> 3 months of extended parental benefit 
	-> single parents are not entitled to the share of the other parent		*/

gen pl_init = (150 - (6*5) - 15)/5 		if country == "PT"
gen pl_exte = 3*4.3						if country == "PT"
	
* cohabiting women
replace pl_dur = pl_init + pl_exte  	if country == "PT" & year == 2019 ///
										& pl_eli == 1 & gender == 1

* single men											
replace pl_dur = pl_init + pl_exte  	if country == "PT" & year == 2019 ///
										& pl_eli == 1 & gender == 2 & parstat == 1



* BENEFIT (monthly)
/*	-> benefits are identical for all types of leave (reserved for mother, father, shared leave)
	-> influenced by parents' choice of duration (120 or 150 days) and whether leave is shared 
	-> 120 days: 100% earning
	-> 150 days, not shared: 80% earning
	-> 150 days, shared: 100% earning (coded)
	-> 180 days, shared: 83% earning 
	-> minimum: €435.76/month 
	-> most generous option coded (100%)	
	-> extended PL: 25% earning	 	*/
	
replace pl_ben1 =  (earning*(pl_init/pl_dur)) + ((earning*0.25)*(pl_exte/pl_dur))	///
												if country == "PT" & year == 2019 & pl_eli == 1
												
replace pl_ben1 =  435.76		if country == "PT" & year == 2019 & pl_eli == 1	///
								& pl_ben1 < 435.76
												
replace pl_ben2 = earning 		if country == "PT" & year == 2019 & pl_eli == 1

foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "PT" & year == 2019
}

replace pl_dur = 0 	if pl_eli == 0 & country == "PT" & year == 2019

drop pl_init pl_exte
