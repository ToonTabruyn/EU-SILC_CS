/* 

Creates PARENTAL LEAVE variables 

*/

gen pl_eli = . 		// eligibility for PL
lab var pl_eli "Eligible to PL"
lab def pl_elil 0 "not eligible" 1 "eligible"
lab val pl_eli pl_elil

gen pl_dur = . 	// PL duration (weeks)
lab var pl_dur "PL duration (weeks)"

gen pl_ben1 = . 	// average monthly PL benefit 
lab var pl_ben1 "PL benefit: average"

gen pl_ben2 = . 	// monthly PL benefit, 1st month
lab var pl_ben2 "PL benefit: 1st month"




