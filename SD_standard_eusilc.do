/*	STANDARDIZATION OF VARIABLES 	*/

* country
// rename oldvar country	// 

* identify household units (single, diff-sex couples, same-sex couples)

* gender
recode rb090 (2 = 1 woman) ///
			(1 = 2 man), ///
			gen(gender) label(genderl)

			
* economic status 
recode pl031 (1 2 = 1 employed) ///
			(3 4 = 2 self-employed) ///
			(5 = 3 unemployed) ///
			(6 7 8 9 10 11 = 4 inactive), ///
			gen(econ_status) label(econ_statusl)  

foreach x in a b c d e f g h i j k l {
	recode pl211`x' (1 2 = 1 employed) ///
			(3 4 = 2 self-employed) ///
			(5 = 3 unemployed) ///
			(6 7 8 9 10 11 = 4 inactive), ///
			gen(estatus`x') label(estatus`x'l)
}
	
	

* duration of employment (months) 
egen duremp = anycount(estatus*), values(1) // own calculation depending on the dataset; in months



* duration of education
egen duredu = anycount(pl211*), values(6) // duration of employment (time in education counts into qualifying period in CZ) 

* duration of unemployment
egen unemp_dur = anycount(estatus*), values(3)			

* duration of self-employment 
egen dursemp = anycount(estatus*), values(2)	
	

	
* monthly gross earning (labour income) 
// rename [] earning 

gen earning_yg = py010g + py050g 	// collapse earning from employment and self-employment

gen dureact = duremp + dursemp 	// duration of employment and self-employment
gen earning = earning_yg/dureact 

* self-employed are allowed negative "income"
replace earning = 0 if earning < 0

replace earning = 0 if econ_status == 4 & earning == .  // inactive earning = . => deletes the observations from sample

drop dureact

* age (at the time of interview)
gen age = rx010
			

* unemployment benefits - household level variable in EU-SILC
// rename oldvar unemp_ben


	
* residency status 
/* recode oldvar ([] = 0 "not resident") ///
			([] = 1 "resident"), ///
			gen(residency) label(residencyl) */ // not in EU-SILC
			



* sector - not part of EU-SILC
/* recode oldvar ([] = 1 private) ///
			([] = 2 public), ///
			gen(sector) label(sectorl) */

* region
rename db040 region		

* partnership status
recode pb200 (3 = 1 single) ///
			(1 2 = 2 "married/cohabiting"), ///
			gen(parstat) label(parstatl)	
			

* working hours
rename pl060 whours	
			

/* for child benefits! ignore for now
* number of children
recode oldvar nchild

* age of each child => depending on the survey
cage1 etc
*/
