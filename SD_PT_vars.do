/* 

Creates PATERNITY LEAVE variables 

*/

gen pt_eli = . 		// eligibility for PT
lab var pt_eli "Eligible to Paternity leave"
lab def pt_elil 0 "not eligible" 1 "eligible"
lab val pt_eli pt_elil

gen pt_dur = . 	// PT duration (weeks)
lab var pt_dur "Paternity leave duration (weeks)"

gen pt_ben1 = . 	// average monthly PT benefit 
lab var pt_ben1 "PT benefit: average"

gen pt_ben2 = . 	// monthly PT benefit, 1st month
lab var pt_ben2 "PT benefit: 1st month"

