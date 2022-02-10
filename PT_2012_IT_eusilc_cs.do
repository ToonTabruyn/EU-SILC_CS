/* PT_2012_IT_eusilc_cs */


* ITALY - 2012

No paternity leave at all! (only under circumstances: mother's death/severe illness, child being left by mother.)

* ELIGIBILITY
/*	no statutory right to paternity leave  		*/
		
replace pt_eli = 0 		if country == "IT" & year == 2012 & gender == 2
