/* 

This code runs the OPEN FAMILY POLICY PROGRAM (OFPP)

 */



*** Data directory
global DATA "[enter your DATA directory]" 

cd "$DATA"

* uses data file created after MERGE of the EU-SILC UDB data files
* replace with your own merged data file name if you already work with a merged file
use SILC2018.dta, clear 



*** Code directory
global CODE "[enter your CODE directory]" 



*** Delete Serbia, Cyprus, Malta ***
drop if country == "RS"
drop if country == "CY"
drop if country == "MT"


*** Standardize country codes according to ISO 3166-1 alpha-2 ***
replace country = "GR" if country == "EL"
replace country = "GB" if country == "UK"



*** Generate unique household and personal identifiers ***
run "$CODE\SD_uid_eusilc.do"



*** Standardize variables for MS ***
run "$CODE\SD_standard_eusilc.do"



drop _merge  // part of SILC2018_ver2020_cs.dta
save OFPP_eusilc_cs, replace



*** Assign information about partners ***
run "$CODE\SD_partners_eusilc_cs.do"




*** Delete same-sex couples *** 
drop if gender == p_gender




*** Number of children per household ***
run "$CODE\SD_nchild_eusilc_cs.do"




*** Select SAMPLE ***
run "$CODE\SD_sample_eusilc_cs.do"



* create a "doorstop" before running the estimation of family policy entitlements 
save OFPP_eusilc_cs2, replace




*** Run policy coding for MATERNITY LEAVE (ML) ***

* Create ML variables
run "$CODE\SD_ML_vars.do"  

* Run ML_year_country_eusilc_cs.do 
foreach x in "AT" "BE" "BG" "CZ" "DE" "DK" "EE" "ES" "FI" "FR" "GB" "GR" "HR" "HU" "IE" "IS" "IT" "LT" "LU" "LV" "NL" "NO" "PL" "PT" "RO" "SE" "SI" "SK" {
	run "$CODE\ML_2018_`x'_eusilc_cs.do"
	run "$CODE\ML_2019_`x'_eusilc_cs.do"
}




*** Run policy coding for PATERNITY LEAVE (PT) ***

* Create PT variables
run "$CODE\SD_PT_vars.do"

* Run PT_year_country_eusilc_cs.do
foreach x in "AT" "BE" "BG" "CZ" "DE" "DK" "EE" "ES" "FI" "FR" "GB" "GR" "HR" "HU" "IE" "IS" "IT" "LT" "LU" "LV" "NL" "NO" "PL" "PT" "RO" "SE" "SI" "SK" {
	run "$CODE\PT_2018_`x'_eusilc_cs.do"
	run "$CODE\PT_2019_`x'_eusilc_cs.do"
}




*** Run policy coding for PARENTAL LEAVE (PL) ***

* Create PL variables
run "$CODE\SD_PL_vars.do"

* Run PL_year_country_eusilc_cs.do
foreach x in "AT" "BE" "BG" "CZ" "DE" "DK" "EE" "ES" "FI" "FR" "GB" "GR" "HR" "HU" "IE" "IS" "IT" "LT" "LU" "LV" "NL" "NO" "PL" "PT" "RO" "SE" "SI" "SK" {
	run "$CODE\PL_2018_`x'_eusilc_cs.do"
	run "$CODE\PL_2019_`x'_eusilc_cs.do"
}


