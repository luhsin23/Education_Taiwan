use "C:\Users\citro\Desktop\D00084\data.dta", clear
gen college = 1 if type_2 == 1 | type_2 == 6 | type_2 == 8 | type_2 == 3
replace college = 0 if type_2 !=. & college==.

gen salary = .
replace salary = 15840 if income == 1
replace salary = 19320 if income == 2
replace salary = 25800 if income == 3
replace salary = 32550.5 if income == 4
replace salary = 41050.5 if income == 5
replace salary = 51800.5 if income == 6
replace salary = 65300.5 if income == 7
replace salary = 78350.5 if income == 8

sum salary if college == 1
//有念大學: 31229
sum salary if college == 0
//沒念大學: 28171
