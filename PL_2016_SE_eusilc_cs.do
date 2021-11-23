/* PL_2016_SE_eusilc_cs */

/*	Sweden doesn't distinguish between ML and PT but only recognizes PARENTAL LEAVE, 
	which is a combination of individual non-transferable and individual transferable
	rights for each parent. 
	The PL data code the individual transferable right to leave for each parent.  
*/


* SWEDEN - 2016

* ELIGIBILITY
replace pl_eli = 1 			if country == "SE" & year == 2016 
replace pl_eli =  0			if pl_eli == . & country == "SE" & year == 2016


* DURATION (weeks)
/*	-> total duration per parent: 240 calendar days
		- 90 individual non-transferable for mother => coded in ml_dur
		- 90 individual non-transferable for father => coded in pt_dur
		- 150 individual transferable for each parent => coded in pl_dur 
*/

replace pl_dur = 150/7 		if country == "SE" & year == 2016 & pl_eli == 1


* BENEFIT (monthly)
/*	-> eligible for earning related benefit: min. income €26/day for 240 calendar days before childbirth

		- for 195 calendar days (includes 90 non-transferable leave = > 150 days transferable): 
			- 77.6% earning => for 105 calendar days
			- minimum: €26/day
			- ceiling: €46,803 for the duration of benefits
		- for 45 days: €19/day
	-> all others: €26/day
 */
 



replace pl_ben1 = (((0.776*earning) * (105/30)) + ((19*30) *  45/30)) / (150/30)	///	
									if country == "SE" & year == 2016 & pl_eli == 1 ///
									& earning/30 >= 26

* minimum									
replace pl_ben1 = 26*30				if country == "SE" & year == 2016 & pl_eli == 1 ///
									& earning/30 < 26

* ceiling
replace pl_ben1 = ((46803 * (105/30)) + ((19*30) *  45/30)) / (150/30)	///
									if country == "SE" & year == 2016 & pl_eli == 1 ///
									& earning >= 46803
						
									

								
									



replace pl_ben2 = 0.776*earning		if country == "SE" & year == 2016 & pl_eli == 1 ///
									& (earning/21.7) >= 26
									
replace pl_ben2 = 26*30				if country == "SE" & year == 2016 & pl_eli == 1 ///
									& earning/30 < 26
									
replace ml_ben1 = 0.776*46803		if country == "SE" & year == 2016 & pl_eli == 1 ///
									& earning >= 46803


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if country == "SE" & year == 2016 & pl_eli == 0
}

replace pl_dur = 0 	if country == "SE" & year == 2016 & pl_eli == 0
