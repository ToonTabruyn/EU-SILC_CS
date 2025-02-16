/* PL_2019_IS_eusilc_cs

date created: 23/08/2021

*/

/*	Iceland doesn't recognise ML and PT but only PL with individual non-transferable and 
	family rights. The family right for leave is coded in here. In case of couples, the 
	entitlement is assigned to women. 
*/

* ICELAND - 2019

* ELIGIBILITY
/*	-> all residents are entitled to cash benefits 
*/

replace pl_eli = 1 			if country == "IS" & year == 2019 
replace pl_eli =  0			if pl_eli == . & country == "IS" & year == 2019


* DURATION (weeks)
/*	-> 3 months of leave - family entitlement
	-> family entitlement => in couples all assigned to women 
*/
replace pl_dur = 3*4.3 		if country == "IS" & year == 2019 & pl_eli == 1 ///
							& gender == 1 
							
replace pl_dur = 3*4.3		if country == "IS" & year == 2019 & pl_eli == 1 ///
							& gender == 2 & parstat == 1


* BENEFIT (monthly)
/*	-> employed, self-employed: active for 6 months prior to birth
			- employed for at least 25% of full time (10 hours/week for 40 hours/week full-time employment) 
			- 80% earning
			- ceiling: €4,234/month 
			- minimum: €906/month 	 if worked between 25% and 49% FT (i.e. 10 and 19.6 hours/week)
					   €1,255/month if worked between 50% and 100% FT (i.e. more than 20 hours/week)
					   
	-> those not fulfilling the conditions: 
		- students: €1,255/month
		- working less than 25% FT: €548/month
*/

* employed, self-employed working 10-20 hours/week - women			
replace pl_ben1 = 0.8*earning	 		if country == "IS" & year == 2019 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) ///
										& gender == 1

replace pl_ben1 = 906	 				if country == "IS" & year == 2019 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) ///
										& pl_ben1 < 906 & gender == 1
										
replace pl_ben1 = 4234	 				if country == "IS" & year == 2019 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) ///
										& pl_ben1 >= 4234 & gender == 1
										
* employed, self-employed working 20+ hours/week - women			
replace pl_ben1 = 0.8*earning	 		if country == "IS" & year == 2019 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 & gender == 1

replace pl_ben1 = 1255	 				if country == "IS" & year == 2019 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 ///
										& pl_ben1 < 1255 & gender == 1
										
replace pl_ben1 = 4234	 				if country == "IS" & year == 2019 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 ///
										& pl_ben1 >= 4234 & gender == 1
										
* the rest - women
replace pl_ben1 = 548					if country == "IS" & year == 2019 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & whours < 10 & gender == 1
										
replace pl_ben1 = 548					if country == "IS" & year == 2019 & pl_eli == 1 ///
										& inlist(econ_status,3,4) & gender == 1 
										
replace pl_ben1 = 1255					if country == "IS" & year == 2019 & pl_eli == 1 ///
										& pl031 == 6 & gender == 1


					
* employed, self-employed working 10-20 hours/week - single men			
replace pl_ben1 = 0.8*earning	 		if country == "IS" & year == 2019 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) ///
										& gender == 2 & parstat == 1

replace pl_ben1 = 906	 				if country == "IS" & year == 2019 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) ///
										& pl_ben1 < 906 & gender == 2 & parstat == 1
										
replace pl_ben1 = 4234	 				if country == "IS" & year == 2019 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) ///
										& pl_ben1 >= 4234 & gender == 2 & parstat == 1
										
* employed, self-employed working 20+ hours/week - single men			
replace pl_ben1 = 0.8*earning	 		if country == "IS" & year == 2019 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 ///
										& gender == 2 & parstat == 1

replace pl_ben1 = 1255	 				if country == "IS" & year == 2019 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 ///
										& pl_ben1 < 1255 & gender == 2 & parstat == 1
										
replace pl_ben1 = 4234	 				if country == "IS" & year == 2019 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 ///
										& pl_ben1 >= 4234 & gender == 2 & parstat == 1
										
* the rest - single men
replace pl_ben1 = 548					if country == "IS" & year == 2019 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & whours < 10 ///
										& gender == 2 & parstat == 1
										
replace pl_ben1 = 548					if country == "IS" & year == 2019 & pl_eli == 1 ///
										& inlist(econ_status,3,4) & gender == 2 & parstat == 1
										
replace pl_ben1 = 1255					if country == "IS" & year == 2019 & pl_eli == 1 ///
										& pl031 == 6 & gender == 2 & parstat == 1


replace pl_ben2 = pl_ben1		if country == "IS" & year == 2019 & pl_eli == 1



foreach x in 1 2 {
	replace pl_ben`x' = 0 	if country == "IS" & year == 2019 & pl_eli == 0	
}

replace pl_dur = 0 	if country == "IS" & year == 2019 & pl_eli == 0
