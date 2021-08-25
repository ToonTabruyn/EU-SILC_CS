/* Specification of PARENTAL LEAVE variables */

gen pl_eli = . 		// eligible to ML
lab var pl_eli "Eligible to PL"
lab def pl_elil 0 "not eligible" 1 "eligible"
lab val pl_eli pl_elil

gen pl_dur = . 	// PL duration (weeks)
lab var pl_dur "PL duration (weeks)"

gen pl_ben1 = . 	// average monthly PL benefit 
lab var pl_ben1 "Average monthly ML benefit"

gen pl_ben2 = . 	// monthly PL benefit, 1st month
lab var pl_ben2 "ML benefit: 1st month"

gen pl_ben3 = . 	// monthly PL benefit, 6th month 
lab var pl_ben3 "ML benefit: 6th month"

gen pl_ben4 = . 	// monthly PL benefit, 12th month
lab var pl_ben4 "ML benefit: 12th month"


