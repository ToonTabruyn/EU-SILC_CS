/* 		*** SAMPLE SELECTION ***

-> single men and women between the age of 16 and 45
-> cohabiting couples (un/married) where woman is between 16 and 45 years old
-> delete observations with missing values on partnership status, economic status and monthly earning

*/


drop if parstat == 1 & !inrange(rx010,16,45)
drop if parstat == 2 & gender == 2 & !inrange(p_age,16,45)
drop if parstat == 2 & gender == 1 & !inrange(rx010,16,45)


drop if parstat == .

drop if econ_status == .

drop if earning == . 

