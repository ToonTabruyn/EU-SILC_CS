/* 		

creates UNIQUE HOUSEHOLD AND PERSONAL IDENTIFIERS

-> insert ISO 3166-1 numeric country codes (3 digits)
-> transform original numeric IDs into string variables
-> add 3 digit ISO before personal and household identifiers = unique identifiers 
 
*/


*** Generate unique household and personal identifiers ***
/* unique hid and pid = 3 digit ISO code before hid and pid (ISO 3166-1 numeric) */

* generate iso codes (ISO 3166-1 numeric)
gen str3 isonum = "."
replace isonum = "040" if country == "AT"
replace isonum = "056" if country == "BE"
replace isonum = "100" if country == "BG"
replace isonum = "756" if country == "CH"
replace isonum = "196" if country == "CY"
replace isonum = "203" if country == "CZ"
replace isonum = "276" if country == "DE"
replace isonum = "208" if country == "DK"
replace isonum = "233" if country == "EE"
replace isonum = "300" if country == "GR"
replace isonum = "724" if country == "ES"
replace isonum = "246" if country == "FI"
replace isonum = "250" if country == "FR"
replace isonum = "191" if country == "HR"
replace isonum = "348" if country == "HU"
replace isonum = "372" if country == "IE"
replace isonum = "352" if country == "IS"
replace isonum = "380" if country == "IT"
replace isonum = "440" if country == "LT"
replace isonum = "442" if country == "LU"
replace isonum = "428" if country == "LV"
replace isonum = "470" if country == "MT"
replace isonum = "528" if country == "NL"
replace isonum = "578" if country == "NO"
replace isonum = "616" if country == "PL"
replace isonum = "620" if country == "PT"
replace isonum = "642" if country == "RO"
replace isonum = "752" if country == "SE"
replace isonum = "705" if country == "SI"
replace isonum = "703" if country == "SK"
replace isonum = "826" if country == "GB"


* transform pid and hid into string variables
tostring (pid), gen(pids)
tostring (hid), gen(hids)
tostring (rb220), gen(fid)
tostring (rb230), gen(mid)
tostring (rb240), gen(prid)

* generate unique household and personal IDs
egen str13 person_id = concat(year isonum pids )
egen str11 hh_id = concat(year isonum hids)

egen str13 father_id = concat(year isonum fid) if fid != "."
replace father_id = "." if fid == "."

egen str13 mother_id = concat(year isonum mid) if mid != "."
replace mother_id = "." if mid == "."

egen str13 partner_id = concat(year isonum prid) if prid != "."
replace partner_id = "." if prid == "."


drop pids hids fid mid prid
