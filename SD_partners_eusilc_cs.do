/* 			*** PARTNER DATASETS ***

-> create dataset of male partners
-> create dataset of female partners
-> merge with the master data file 				

*/

cd "$DATA" 

use FAMPOT_MS_eusilc.dta, clear 

*** MALE PARTNERS ***

* delete single and missing values
keep if parstat == 2

* delete women
drop if gender == 1

* delete observations with missing values on partner_id
drop if partner_id == "."


rename gender p_gender
rename earning p_earning
rename rx010 p_age
rename econ_status p_econ_status
rename estatus* p_estatus*

rename partner_id rb240_n
rename person_id partner_id
rename rb240_n person_id 

* partner's duration of employment
egen p_duremp = anycount(p_estatus*), values(1) // own calculation depending on the dataset; in months

* duration of partner's self-employment 
egen p_dursemp = anycount(p_estatus*), values(2)	

* collapse earning from employment and self-employment
gen p_earning_yg = py010g + py050g 	


keep year country hh_id person_id partner_id p_gender p_earning p_age ///
 p_econ_status p_estatus* p_duremp p_dursemp p_earning_yg 

save FAMPOT_MS_eusilc_fempartner.dta, replace


*** FEMALE PARTNERS ***

use FAMPOT_MS_eusilc.dta, clear

* delete single and missing values
keep if parstat == 2

* delete women
drop if gender == 2

* delete observations with missing values on partner_id
drop if partner_id == "."


rename gender p_gender
rename earning p_earning
rename rx010 p_age
rename econ_status p_econ_status
rename estatus* p_estatus*

rename partner_id rb240_n
rename person_id partner_id
rename rb240_n person_id 

* partner's duration of employment
egen p_duremp = anycount(p_estatus*), values(1) // own calculation depending on the dataset; in months

* duration of partner's self-employment 
egen p_dursemp = anycount(p_estatus*), values(2)	

* collapse earning from employment and self-employment
gen p_earning_yg = py010g + py050g 	


keep year country hh_id person_id partner_id p_gender p_earning p_age ///
p_econ_status p_estatus* p_duremp p_dursemp p_earning_yg 

save FAMPOT_MS_eusilc_malepartner.dta, replace




*** Merge with the main dataset ***

use FAMPOT_MS_eusilc.dta, clear
mer 1:1 person_id using FAMPOT_MS_eusilc_fempartner.dta 
drop _merge
mer 1:1 person_id using FAMPOT_MS_eusilc_malepartner.dta, update keep(1 3 4)
drop _merge

save FAMPOT_MS_eusilc.dta, replace 

erase "$DATA\FAMPOT_MS_eusilc_fempartner.dta"
erase "$DATA\FAMPOT_MS_eusilc_malepartner.dta"
