/* PL_2015_HR_eusilc_cs */


* CROATIA - 2015

* ELIGIBILITY
/*	-> all parents but conditions and benefits differ by categories

	-> parental leave is an individual partially transferable (2 months) entitlement (LP&R 2014)

	-> employed: parental leave
	-> self-employed: parental leave
	-> unemployed: parental exeption from work	
	-> inactive: parental care for a child
		
*/

replace pl_eli = 1 		if country == "HR" & year == 2015
replace pl_eli = 0 		if pl_eli == . & country == "HR" & year == 2015



* DURATION (weeks)
/*	-> 4 months/parent/child
  										*/
   
replace pl_dur = 4 		if country == "HR" & year == 2015 & pl_eli == 1 ///
						& inlist(econ_status,1,2) 
						
						
				


* BENEFIT (monthly)
/*	-> Employed & self-employd: 100%
		-> ceiling = €351/month
*/

replace pl_ben1 = earning 		if country == "HR" & year == 2015 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & (duremp+dursemp) >= 12

replace pl_ben1 = 351 	if country == "HR" & year == 2015 & pl_eli == 1 ///
						& inlist(econ_status,1,2) & (duremp+dursemp) >= 12 & earning > 351

 

 foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "HR" & year == 2015
}

replace pl_dur = 0 	if pl_eli == 0 & country == "HR" & year == 2015
