/* Specify the PATERNITY LEAVE variables */

gen pt_eli = . 		// eligible to ML
lab var pt_eli "Eligible to Paternity leave"
lab def pt_elil 0 "not eligible" 1 "eligible"
lab val pt_eli pt_elil

gen pt_dur = . 	// paternity leave duration (weeks)
lab var pt_dur "Paternity leave duration (weeks)"

gen pt_ben1 = . 	// average monthly ML benefit 
lab var pt_ben1 "Average monthly Paternity Leave benefit"

gen pt_ben2 = . 	// monthly ML benefit, 1st month
lab var pt_ben2 "Paternity leave benefit: 1st month"

